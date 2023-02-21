--
-- Privileges for project-defined entities
-- 
-- Throughout this file, GRANTs are not revoked from users by username, as users are not 
-- addressed by name in Supabase. If a grant had been given to a user by name, it was an admin 
-- action for a specific installation and should probably not be reversed.
--

-- Tables

-- TODO: Add REVOKE statements before GRANT, to make sure we start from scratch.

GRANT ALL ON TABLE public.medium TO anon, authenticated, service_role;
GRANT ALL ON TABLE public.profile TO anon, authenticated, service_role;
GRANT ALL ON TABLE public.programme TO anon, authenticated, service_role;
GRANT ALL ON TABLE public.programme_response TO anon, authenticated, service_role;
GRANT ALL ON TABLE public.programme_step TO anon, authenticated, service_role;
GRANT ALL ON TABLE public.project TO anon, authenticated, service_role;
GRANT ALL ON TABLE public.response TO anon, authenticated, service_role;
GRANT ALL ON TABLE public.role TO anon, authenticated, service_role;
GRANT ALL ON TABLE public.step TO anon, authenticated, service_role;


-- Views

REVOKE ALL   ON TABLE public.profile_for_all FROM PUBLIC, anon, authenticated, service_role;
GRANT ALL    ON TABLE public.profile_for_all TO service_role;
GRANT SELECT ON TABLE public.profile_for_all TO anon, authenticated;

REVOKE ALL   ON TABLE public.project_for_mgm FROM PUBLIC, anon, authenticated, service_role;
GRANT ALL    ON TABLE public.project_for_mgm TO service_role;
GRANT SELECT ON TABLE public.project_for_mgm TO anon, authenticated;
GRANT UPDATE ON TABLE public.project_for_mgm TO anon, authenticated;

REVOKE ALL   ON TABLE public.role_for_usermgm FROM PUBLIC, anon, authenticated, service_role;
GRANT ALL    ON TABLE public.role_for_usermgm TO service_role;
GRANT SELECT ON TABLE public.role_for_usermgm TO anon, authenticated;
GRANT UPDATE ON TABLE public.role_for_usermgm TO anon, authenticated;

REVOKE ALL   ON TABLE public.step_for_payment FROM PUBLIC, anon, authenticated, service_role;
GRANT ALL    ON TABLE public.step_for_payment TO service_role;
GRANT SELECT ON TABLE public.step_for_payment TO anon, authenticated;
GRANT UPDATE ON TABLE public.step_for_payment TO anon, authenticated;

REVOKE ALL   ON TABLE public.step_for_validation FROM PUBLIC, anon, authenticated, service_role;
GRANT ALL    ON TABLE public.step_for_validation TO service_role;
GRANT SELECT ON TABLE public.step_for_validation TO anon, authenticated;
GRANT UPDATE ON TABLE public.step_for_validation TO anon, authenticated;


-- Sequences

-- TODO: Add REVOKE statements before GRANT, to make sure we start from scratch.

GRANT ALL ON SEQUENCE public.medium_id_seq TO anon, authenticated, service_role;
GRANT ALL ON SEQUENCE public.programme_id_seq TO anon, authenticated, service_role;
GRANT ALL ON SEQUENCE public.programme_response_id_seq TO anon, authenticated, service_role;
GRANT ALL ON SEQUENCE public.programme_step_id_seq TO anon, authenticated, service_role;
GRANT ALL ON SEQUENCE public.project_id_seq TO anon, authenticated, service_role;
GRANT ALL ON SEQUENCE public.response_id_seq TO anon, authenticated, service_role;
GRANT ALL ON SEQUENCE public.role_id_seq TO anon, authenticated, service_role;
GRANT ALL ON SEQUENCE public.steps_id_seq TO anon, authenticated, service_role;


-- Functions

-- TODO: Add REVOKE statements before GRANT, to make sure we start from scratch.

ALTER FUNCTION public.can_implement(my_project_id bigint) OWNER TO postgres;
GRANT ALL ON FUNCTION public.can_implement(my_project_id bigint) 
    TO anon, authenticated, service_role;

ALTER FUNCTION public.can_pay(my_project_id bigint) OWNER TO postgres;
GRANT ALL ON FUNCTION public.can_pay(my_project_id bigint)
    TO anon, authenticated, service_role;

ALTER FUNCTION public.can_validate(my_project_id bigint) OWNER TO postgres;
GRANT ALL ON FUNCTION public.can_validate(my_project_id bigint)
    TO anon, authenticated, service_role;

ALTER FUNCTION public.insert_project_mgr() OWNER TO postgres;
REVOKE ALL ON FUNCTION public.insert_project_mgr() FROM PUBLIC, anon, authenticated, service_role;
GRANT ALL ON FUNCTION public.insert_project_mgr() TO service_role;
-- TODO: The following was contained in the Supabase dump, but probably is wrong as it would 
-- counteract the (necessary) REVOKE ALL for this "SECURITY definer" function. To confirm.
-- GRANT ALL ON FUNCTION public.insert_project_mgr() TO
--    TO anon, authenticated, service_role;

ALTER FUNCTION public.project_for_response(my_response_id bigint) OWNER TO postgres;
GRANT ALL ON FUNCTION public.project_for_response(my_response_id bigint)
    TO anon, authenticated, service_role;

ALTER FUNCTION public.insert_profile() OWNER TO postgres;
REVOKE ALL ON FUNCTION public.insert_profile() FROM PUBLIC, anon, authenticated, service_role;
GRANT ALL ON FUNCTION public.insert_profile() TO service_role;
-- TODO: The following was contained in the Supabase dump, but probably is wrong as it would 
-- counteract the (necessary) REVOKE ALL for this "SECURITY definer" function. To confirm.
-- GRANT ALL ON FUNCTION public.insert_project_mgr() TO
--    TO anon, authenticated, service_role;
