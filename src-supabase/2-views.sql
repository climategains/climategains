--
-- Project-defined views
--

CREATE VIEW public.project_for_mgm AS
 SELECT project.id,
    project.name,
    project.location_name,
    project.geo_lat,
    project.geo_long
   FROM (public.project
     JOIN public.role ON ((role.project_id = project.id)))
  WHERE ((role.manager = true) AND (role.user_id = auth.uid()));

ALTER TABLE public.project_for_mgm OWNER TO postgres;


CREATE VIEW public.role_for_usermgm AS
 SELECT role.id,
    role.project_id,
    role.user_id,
    role.activist_application,
    role.activist,
    role.manager_application,
    role.manager
   FROM public.role
  WHERE ((role.project_id IS NOT NULL) AND (auth.uid() IN ( SELECT role_1.user_id
           FROM (public.role role_1
             JOIN public.project ON ((role_1.project_id = project.id)))
          WHERE (role_1.manager = true))));

ALTER TABLE public.role_for_usermgm OWNER TO postgres;


CREATE VIEW public.step_for_payment AS
 SELECT step.id,
    step.paid,
    step.payment_comment,
    step.paid_by
   FROM public.step
  WHERE public.can_pay(step.project_id);

ALTER TABLE public.step_for_payment OWNER TO postgres;


CREATE VIEW public.step_for_validation AS
 SELECT step.validation_status,
    step.validation_comment,
    step.validation_updated,
    step.validator
   FROM public.step
  WHERE public.can_validate(step.project_id);

ALTER TABLE public.step_for_validation OWNER TO postgres;
