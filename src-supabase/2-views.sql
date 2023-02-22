--
-- Project-defined views
--


-- profile_for_all

-- DROP first, as CREATE OR REPLACE will only attempt column renaming, failing when adding columns.
DROP VIEW IF EXISTS public.profile_for_all;
CREATE VIEW public.profile_for_all AS
    SELECT id, fullname, organization
        FROM public.profile;

ALTER VIEW public.profile_for_all OWNER TO postgres; -- Populate view with Use superuser privileges.
REVOKE ALL   ON TABLE public.profile_for_all FROM PUBLIC, anon, authenticated, service_role;
GRANT ALL    ON TABLE public.profile_for_all TO service_role;
GRANT SELECT ON TABLE public.profile_for_all TO anon, authenticated;

COMMENT ON VIEW public.profile_for_all IS 
    'The subset of profile information that should be publicly accessible.';
COMMENT ON COLUMN public.profile_for_all.id IS 'Same as profile.id.';
COMMENT ON COLUMN public.profile_for_all.fullname IS 'Same as profile.fullname.';
COMMENT ON COLUMN public.profile_for_all.organization IS 'Same as profile.organization.';


-- project_for_mgm

DROP VIEW IF EXISTS public.project_for_mgm;
-- See for security_barrier requirement: https://www.postgresql.org/docs/current/rules-privileges.html
CREATE VIEW public.project_for_mgm WITH (security_barrier) AS
    SELECT project.id, project.name, project.location_name, project.geo_lat, project.geo_long
        FROM public.project JOIN public.role ON role.project_id = project.id
        WHERE role.user_id = auth.uid() AND role.manager = true;
        -- TODO Make the implementation simpler and more consistent with the other views below 
        -- by using a function: no join, then "WHERE is_manager(project.id)" or maybe 
        -- can_manage(project.id) or invoker_is_manager(project.id).

ALTER VIEW public.project_for_mgm OWNER TO postgres; -- Populate view with Use superuser privileges.
REVOKE ALL   ON TABLE public.project_for_mgm FROM PUBLIC, anon, authenticated, service_role;
GRANT ALL    ON TABLE public.project_for_mgm TO service_role;
GRANT SELECT ON TABLE public.project_for_mgm TO anon, authenticated;
GRANT UPDATE ON TABLE public.project_for_mgm TO anon, authenticated;

COMMENT ON VIEW public.project_for_mgm IS 
    E'Project metadata that the current user can edit.'
    '\n\n'
    'With this view, a user can edit name, location etc. of projects she has a manager role in.';
COMMENT ON COLUMN public.project_for_mgm.id IS 'Same as project.id.';
COMMENT ON COLUMN public.project_for_mgm.name IS 'Same as project.name.';
COMMENT ON COLUMN public.project_for_mgm.location_name IS 'Same as project.location_name.';
COMMENT ON COLUMN public.project_for_mgm.geo_lat IS 'Same as project.geo_lat.';
COMMENT ON COLUMN public.project_for_mgm.geo_long IS 'Same as project.geo_long.';


-- role_for_usermgm

DROP VIEW IF EXISTS public.role_for_usermgm;
-- See for security_barrier requirement: https://www.postgresql.org/docs/current/rules-privileges.html
CREATE VIEW public.role_for_usermgm WITH (security_barrier) AS
    -- List all role records associated with projects that current user manages.
    SELECT view.id, view.project_id, view.user_id, 
        view.activist_application, view.activist, view.manager_application, view.manager
        FROM public.role AS view JOIN public.role AS rights ON view.project_id = rights.project_id
        WHERE rights.user_id = auth.uid() AND rights.manager = true;
        -- TODO Make the implementation simpler and more consistent with the other views below 
        -- by using a function: no join, then "WHERE is_manager(project.id)" or maybe 
        -- can_manage(project.id) or invoker_is_manager(project.id).

ALTER VIEW public.role_for_usermgm OWNER TO postgres; -- Populate view with Use superuser privileges.
REVOKE ALL   ON TABLE public.role_for_usermgm FROM PUBLIC, anon, authenticated, service_role;
GRANT ALL    ON TABLE public.role_for_usermgm TO service_role;
GRANT SELECT ON TABLE public.role_for_usermgm TO anon, authenticated;
GRANT UPDATE ON TABLE public.role_for_usermgm TO anon, authenticated;

COMMENT ON VIEW public.role_for_usermgm IS 
    E'User permission records that the current user can manage (edit).'
    '\n\n'
    'A user can manage (edit) the permission of another user if the user is a project manager of '
    'the project to which the permission relates, and the permission relates to an activist or '
    'manager role, but not a validator role.';
COMMENT ON COLUMN public.role_for_usermgm.id IS 'Same as role.id.';
COMMENT ON COLUMN public.role_for_usermgm.project_id IS 'Same as role.project_id.';
COMMENT ON COLUMN public.role_for_usermgm.user_id IS 'Same as role.user_id.';
COMMENT ON COLUMN public.role_for_usermgm.activist_application IS 'Same as role.activist_application.';
COMMENT ON COLUMN public.role_for_usermgm.activist IS 'Same as role.activist.';
COMMENT ON COLUMN public.role_for_usermgm.manager_application IS 'Same as role.manager.';
COMMENT ON COLUMN public.role_for_usermgm.manager IS 'Same as role.manager.';


-- step_for_payment

DROP VIEW IF EXISTS public.step_for_payment;
-- See for security_barrier requirement: https://www.postgresql.org/docs/current/rules-privileges.html
CREATE VIEW public.step_for_payment WITH (security_barrier) AS
    SELECT step.id, step.paid, step.payment_comment, step.paid_by
        FROM public.step
        WHERE public.can_pay(step.project_id);

ALTER VIEW public.step_for_payment OWNER TO postgres; -- Populate view with Use superuser privileges.
REVOKE ALL   ON TABLE public.step_for_payment FROM PUBLIC, anon, authenticated, service_role;
GRANT ALL    ON TABLE public.step_for_payment TO service_role;
GRANT SELECT ON TABLE public.step_for_payment TO anon, authenticated;
GRANT UPDATE ON TABLE public.step_for_payment TO anon, authenticated;

COMMENT ON VIEW public.step_for_payment IS E''
    'Payment related information about projects steps that is editable by the current user.'
    '\n\n'
    'A user can edit the payment payment status, comment and "paid by" information if she is a '
    'payment manager of the associated project’s programme.';
COMMENT ON COLUMN public.step_for_payment.id IS 'Same as step.id.';
COMMENT ON COLUMN public.step_for_payment.paid IS 'Same as step.paid.';
COMMENT ON COLUMN public.step_for_payment.payment_comment IS 'Same as step.payment_comment.';
COMMENT ON COLUMN public.step_for_payment.paid_by IS 'Same as step.paid_by.';


-- step_for_validation

DROP VIEW IF EXISTS public.step_for_validation;
-- See for security_barrier requirement: https://www.postgresql.org/docs/current/rules-privileges.html
CREATE OR REPLACE VIEW public.step_for_validation WITH (security_barrier) AS
    SELECT step.id, 
        step.validation_status, step.validation_comment, step.validation_updated, step.validator
        FROM public.step
        WHERE public.can_validate(step.project_id);

ALTER VIEW public.step_for_validation OWNER TO postgres; -- Populate view with Use superuser privileges.
REVOKE ALL   ON TABLE public.step_for_validation FROM PUBLIC, anon, authenticated, service_role;
GRANT ALL    ON TABLE public.step_for_validation TO service_role;
GRANT SELECT ON TABLE public.step_for_validation TO anon, authenticated;
GRANT UPDATE ON TABLE public.step_for_validation TO anon, authenticated;

COMMENT ON VIEW public.step_for_validation IS E''
    'Validation related information about project steps that is editable by the current user.'
    '\n\n'
    'A user can edit the validation related information about a project step if she is a validator'
    'of the project (or of the project’s programme, but that has yet to be implemented).';
COMMENT ON COLUMN public.step_for_validation.id IS 'Same as step.id.';
COMMENT ON COLUMN public.step_for_validation.validation_status IS 'Same as step.validation_status.';
COMMENT ON COLUMN public.step_for_validation.validation_comment IS 'Same as step.validation_comment.';
COMMENT ON COLUMN public.step_for_validation.validation_updated IS 'Same as step.validation_updated.';
COMMENT ON COLUMN public.step_for_validation.validator IS 'Same as step.validator.';
