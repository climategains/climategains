--
-- Functions for project defined tables
-- Including their use as triggers in tables.
--

-- can_implement(a_project_id)

-- Needed only when changing the function signature (incl. parameter renaming).
DROP FUNCTION IF EXISTS public.can_implement(bigint) CASCADE;

CREATE OR REPLACE FUNCTION public.can_implement(a_project_id bigint) RETURNS boolean 
    LANGUAGE plpgsql AS $$
DECLARE 
    result boolean;
BEGIN
    SELECT 
        EXISTS (
            SELECT role.user_id
            FROM project JOIN role ON project.id = role.project_id
            WHERE 
                project.id = a_project_id AND 
                (role.manager OR role.activist) AND 
                role.user_id = auth.uid()
        )
        INTO result;

    RETURN(result);
END;$$;

/* To recreate dropped dependent objects:

CREATE POLICY update_for_own_project ON public.project FOR UPDATE TO authenticated 
    USING (public.can_implement(id))
    WITH CHECK (public.can_implement(id));
CREATE POLICY insert_for_own_project ON public.response FOR INSERT TO authenticated 
    WITH CHECK (public.can_implement(public.project_for_response(id)));
CREATE POLICY insert_for_own_project ON public.step FOR INSERT TO authenticated 
    WITH CHECK (public.can_implement(project_id));
*/

COMMENT ON FUNCTION public.can_implement(a_project_id bigint) IS E''
    'Check if the current user has the activist or manager role in the given project.'
    '\n\n'
    'Important: Make sure the calling user’s JWT token has not expired. Otherwise the API call is '
    'silently treated like a call by an anonymous user, for which this function returns false.'
    '\n\n'
    'Used by RLS these policies:\n'
    '  • public.project.update_for_own_project\n'
    '  • public.response.insert_for_own_project\n'
    '  • public.step.insert_for_own_project';


-- can_pay(a_project_id)

-- Needed only when changing the function signature (incl. parameter renaming).
DROP FUNCTION IF EXISTS public.can_pay(bigint) CASCADE;

CREATE OR REPLACE FUNCTION public.can_pay(a_project_id bigint) RETURNS boolean
    LANGUAGE plpgsql AS $$
DECLARE
    result boolean;
BEGIN
    SELECT 
        EXISTS (
            SELECT role.user_id
            FROM project
                JOIN programme on project.programme_id = programme.id
                JOIN role ON programme.id = role.programme_id
            WHERE 
                project.id = a_project_id AND 
                role.manager AND 
                role.user_id = auth.uid()
        )
        INTO result;

    RETURN(result);
END;$$;

COMMENT ON FUNCTION public.can_pay(a_project_id bigint) IS E''
    'Determine if the current user should be able to edit payment information for a project step. '
    'Allowed only if the user has role "manager" for the project’s programme.'
    '\n\n'
    'Important: Make sure the calling user’s JWT token has not expired. Otherwise the API call is '
    'silently treated like a call by an anonymous user, for which this function returns false.'
    '\n\n'
    'Used in view public.step_for_payment.';

/* To recreate dropped dependent objects: See 2-views.sql under "step_for_payment". */


-- can_validate(a_project_id)

-- Needed only when changing the function signature (incl. parameter renaming).
DROP FUNCTION IF EXISTS public.can_validate(bigint) CASCADE;

CREATE OR REPLACE FUNCTION public.can_validate(a_project_id bigint) RETURNS boolean
    LANGUAGE plpgsql AS $$
DECLARE 
    result boolean;
BEGIN
    -- TODO: Extend this implementation so that validators of the project's programme are also 
    -- considered as able to validate the project. Then adapt the COMMENT on view step_for_validation
    -- accordingly, and the COMMENT on this function below.
    SELECT
        EXISTS (
            SELECT role.user_id
                FROM project JOIN role ON project.id = role.project_id
                WHERE 
                    project.id = a_project_id AND 
                    role.validator AND 
                    role.user_id = auth.uid()
        )
        INTO result;

    RETURN(result);
END;$$;

COMMENT ON FUNCTION public.can_validate(a_project_id bigint) IS E''
    'Determine if the current user should be able to edit validation information for a project step. '
    'Allowed only if the user has role "validator" for the project. And in the future also if the '
    'user has the role "validator" for the project’s programme.'
    '\n\n'
    'Important: Make sure the calling user’s JWT token has not expired. Otherwise the API call is '
    'silently treated like a call by an anonymous user, for which this function returns false.'
    '\n\n'
    'Used in view public.step_for_validation.';

/* To recreate dropped dependent objects: See 2-views.sql under "step_for_validation". */


-- insert_project_mgr()

DROP FUNCTION IF EXISTS public.insert_project_mgr() CASCADE;

CREATE OR REPLACE FUNCTION public.insert_project_mgr() RETURNS trigger
    LANGUAGE plpgsql SECURITY definer AS $$
BEGIN
    INSERT 
        INTO public.role (project_id, user_id, manager)
        VALUES (new.id, auth.uid(), true);
    RETURN new;
END;$$;

COMMENT ON FUNCTION public.insert_project_mgr() IS E''
    'Trigger function for table table public.project that creates a project manager role for the '
    'current user.'
    '\n\n'
    'This is a privileged function ("SECURITY definer") and must be protected from direct execution. '
    'Used as AFTER INSERT trigger public.project.insert_project_mgr, where it makes the user a '
    'project manager of the project she just created.';

-- At this time, CREATE OR REPLACE TRIGGER does not work in Supabase SQL Editor due to a bug. See:
-- https://github.com/supabase/supabase/issues/12523 . (It works via psql, though.)
DROP TRIGGER IF EXISTS insert_project_mgr ON public.project;
CREATE TRIGGER insert_project_mgr AFTER INSERT ON public.project 
    FOR EACH ROW EXECUTE FUNCTION public.insert_project_mgr();


-- project_for_response(a_response_id)

DROP FUNCTION IF EXISTS public.project_for_response(bigint) CASCADE;

CREATE OR REPLACE FUNCTION public.project_for_response(a_response_id bigint) RETURNS bigint
    LANGUAGE plpgsql AS $$
BEGIN
    SELECT step.project_id
        FROM response JOIN step ON step.id = response.step_id
        WHERE response.id = a_response_id;
END;$$;

COMMENT ON FUNCTION public.project_for_response(a_response_id bigint) IS 
    'Determines the project of the specified response.'
    '\n\n'
    'Used by this RLS policy: public.response.insert_for_own_project';

/* To recreate dropped dependent objects:

CREATE POLICY insert_for_own_project ON public.response FOR INSERT TO authenticated 
    WITH CHECK (public.can_implement(public.project_for_response(id)));
*/


--
-- Functions for Supabase defined tables
-- Including their use as triggers in tables.
--

-- insert_profile()

DROP FUNCTION IF EXISTS public.insert_profile() CASCADE;

CREATE OR REPLACE FUNCTION public.insert_profile() RETURNS trigger 
    LANGUAGE plpgsql SECURITY definer AS $$
BEGIN
    INSERT 
        INTO public.profile (id, fullname, organization, ui_language, payment_accounts)
        VALUES (
            new.id,
            -- If key does not exist, ->> returns NULL, here mostly suitable as the default value.
            new.raw_user_meta_data->>'fullname', 
            new.raw_user_meta_data->>'organization',
            coalesce(new.raw_user_meta_data->>'ui_language', 'en'),
            new.raw_user_meta_data->'payment_accounts'
        );

    -- We want to use this field only for data collection at signup, but use our own table profile
    -- as authoritative data source afterwards. Without this, possibly outdated user metadata 
    -- would be returned encoded in JWT tokens. See:
    -- https://supabase.com/docs/learn/auth-deep-dive/auth-deep-dive-jwts#jwts-in-supabase
    UPDATE auth.users 
        SET raw_user_meta_data = '{}'
        WHERE id = new.id;
    
    -- Also update the NEW variable. Not sure if necessary. It does not prevent the signup API 
    -- endpoint returning the user data just saved. But that does not matter, as at that point in 
    -- time the user data returned this way is correct.
    new.raw_user_meta_data := '{}';
    RETURN new;
END;$$;

COMMENT ON FUNCTION public.insert_profile() IS E''
    'Trigger function for table auth.users that creates a public.profile record, populates it with '
    'relevant data from auth.users.raw_user_meta_data, and then deletes the raw_user_meta_data '
    'value. This leaves public.profile as the only and authoritative data source of this data.'
    '\n\n'
    'This is a privileged function ("SECURITY definer") and must be protected from direct execution. '
    'Used as AFTER INSERT trigger auth.users.insert_profile where is transfers additional user meta '
    'data to the profile. This enables signup and profile data submission in a single API call.';

DROP TRIGGER IF EXISTS insert_profile ON auth.users;
CREATE TRIGGER insert_profile AFTER INSERT ON auth.users
    FOR EACH ROW EXECUTE FUNCTION public.insert_profile();
