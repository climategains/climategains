--
-- Functions for project defined tables
-- Including their use as triggers in tables.
--

CREATE OR REPLACE FUNCTION public.can_implement(my_project_id bigint) RETURNS boolean 
    LANGUAGE plpgsql AS $$
BEGIN
    SELECT EXISTS (
        SELECT role.user_id
        FROM project
            JOIN role ON project.id = role.project_id
        WHERE 
            project.id = my_project_id AND 
            (role.manager OR role.activist) AND 
            role.user_id = auth.uid()
    );
END;$$;


CREATE OR REPLACE FUNCTION public.can_pay(my_project_id bigint) RETURNS boolean
    LANGUAGE plpgsql AS $$
BEGIN
    /* Determine if the current user should be able to edit payment 
     * information for a project step. Allowed only if the user is a 
     * manager of the project's programme. */
    SELECT EXISTS (
        SELECT role.user_id
        FROM project
            JOIN programme on project.programme_id = programme.id
            JOIN role ON programme.id = role.programme_id
        WHERE 
            project.id = my_project_id AND 
            role.manager AND 
            role.user_id = auth.uid()
    );
END;$$;


CREATE OR REPLACE FUNCTION public.can_validate(my_project_id bigint) RETURNS boolean
    LANGUAGE plpgsql AS $$
BEGIN
    SELECT EXISTS (
        SELECT role.user_id
        FROM project
            JOIN role ON project.id = role.project_id
        WHERE 
            project.id = my_project_id AND 
            role.validator AND 
            role.user_id = auth.uid()
    -- TODO: Extend this implementation so that validators of the project's programme are also 
    -- considered as able to validate the project. Then adapt the COMMENT on view step_for_validation
    -- accordingly.
    );
END;$$;


CREATE OR REPLACE FUNCTION public.insert_project_mgr() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER AS $$
BEGIN
    /* AFTER INSERT trigger for table project */
    /* Creates a manager role for the user who created the project.*/
    /* Privileged function, protect from direct execution. See:
    *  https://dba.stackexchange.com/a/264001 
    *  https://stackoverflow.com/a/72140046 */
    INSERT 
        INTO public.role ("project_id", "user_id", "manager")
        VALUES (new.id, auth.uid(), true);
    RETURN new;
END;$$;

-- At this time, CREATE TRIGGER IF EXISTS does not work in Supabase SQL Editor due to a bug. See:
-- https://github.com/supabase/supabase/issues/12523 . (It works via psql, though.)
DROP TRIGGER IF EXISTS insert_project_mgr ON auth.users;
CREATE TRIGGER insert_project_mgr AFTER INSERT ON public.project 
    FOR EACH ROW EXECUTE FUNCTION public.insert_project_mgr();


CREATE OR REPLACE FUNCTION public.project_for_response(my_response_id bigint) RETURNS bigint
    LANGUAGE plpgsql AS $$
BEGIN
    SELECT step.project_id
        FROM response JOIN step ON step.id = response.step_id
        WHERE response.id = my_response_id;
END;$$;


--
-- Functions for Supabase defined tables
-- Including their use as triggers in tables.
--

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
    -- endpoint returning the user data just saved. But no matter, at that point they are up to date.
    new.raw_user_meta_data := '{}';
    RETURN new;
END;$$;

DROP TRIGGER IF EXISTS insert_profile ON auth.users;
CREATE TRIGGER insert_profile AFTER INSERT ON auth.users
    FOR EACH ROW EXECUTE FUNCTION public.insert_profile();
