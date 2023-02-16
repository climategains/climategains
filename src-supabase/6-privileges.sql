--
-- Privileges for all project-defined entities
--

-- Tables and views

GRANT ALL ON TABLE public.medium TO anon, authenticated, service_role;
GRANT ALL ON SEQUENCE public.files_id_seq TO anon, authenticated, service_role;
GRANT ALL ON TABLE public.profile TO anon, authenticated, service_role;
GRANT ALL ON TABLE public.programme TO anon, authenticated, service_role;
GRANT ALL ON TABLE public.programme_response TO anon, authenticated, service_role;
GRANT ALL ON TABLE public.programme_step TO anon, authenticated, service_role;
GRANT ALL ON TABLE public.project TO anon, authenticated, service_role;
GRANT ALL ON TABLE public.project_for_mgm TO anon, authenticated, service_role;
GRANT ALL ON TABLE public.response TO anon, authenticated, service_role;
GRANT ALL ON TABLE public.role TO anon, authenticated, service_role;
GRANT ALL ON TABLE public.role_for_usermgm TO anon, authenticated, service_role;
GRANT ALL ON TABLE public.step TO anon, authenticated, service_role;
GRANT ALL ON TABLE public.step_for_payment TO anon, authenticated, service_role;
GRANT ALL ON TABLE public.step_for_validation TO anon, authenticated, service_role;


-- Sequences

GRANT ALL ON SEQUENCE public.programmes_id_seq TO anon, authenticated, service_role;
GRANT ALL ON SEQUENCE public.projects_id_seq TO anon, authenticated, service_role;
GRANT ALL ON SEQUENCE public.responses_id_seq TO anon, authenticated, service_role;
GRANT ALL ON SEQUENCE public.responses_templates_id_seq TO anon, authenticated, service_role;
GRANT ALL ON SEQUENCE public.role_application_id_seq TO anon, authenticated, service_role;
GRANT ALL ON SEQUENCE public.steps_id_seq TO anon, authenticated, service_role;
GRANT ALL ON SEQUENCE public.steps_meta_id_seq TO anon, authenticated, service_role;


-- Functions

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
REVOKE ALL ON FUNCTION public.insert_project_mgr() FROM PUBLIC;
GRANT ALL ON FUNCTION public.insert_project_mgr() TO
    TO anon, authenticated, service_role;

ALTER FUNCTION public.project_for_response(my_response_id bigint) OWNER TO postgres;
GRANT ALL ON FUNCTION public.project_for_response(my_response_id bigint)
    TO anon, authenticated, service_role;
