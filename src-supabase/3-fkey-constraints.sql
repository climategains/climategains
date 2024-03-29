--
-- Foreign key constraints for tables defined by the project
-- (Other constraints that do not depend on table creation order and are in 1-tables.sql.)
--

-- benefit

ALTER TABLE ONLY public.benefit
    ADD CONSTRAINT benefit_project_id_fkey 
        FOREIGN KEY (project_id) REFERENCES public.project(id) ON DELETE CASCADE;

ALTER TABLE ONLY public.benefit
    DROP CONSTRAINT IF EXISTS benefit_beneficiary_fkey,
    ADD CONSTRAINT benefit_beneficiary_fkey 
        FOREIGN KEY (beneficiary) REFERENCES public.profile(id) ON DELETE RESTRICT;

ALTER TABLE ONLY public.benefit
    DROP CONSTRAINT IF EXISTS benefit_evidence_fkey,
    ADD CONSTRAINT benefit_evidence_fkey 
        FOREIGN KEY (evidence) REFERENCES public.medium(id) ON DELETE SET NULL;

ALTER TABLE ONLY public.backing
    DROP CONSTRAINT IF EXISTS backing_support_type_fkey,
    ADD CONSTRAINT backing_support_type_fkey 
        FOREIGN KEY (support_type) REFERENCES public.tag(id) ON DELETE SET NULL;

-- benefit_type

ALTER TABLE ONLY public.benefit_type
    ADD CONSTRAINT benefit_type_benefit_id_fkey 
        FOREIGN KEY (benefit_id) REFERENCES public.benefit(id) ON DELETE CASCADE;

ALTER TABLE ONLY public.benefit_type
    ADD CONSTRAINT benefit_type_tag_id_fkey 
        FOREIGN KEY (tag_id) REFERENCES public.tag(id) ON DELETE CASCADE;


-- emissions_avoided

ALTER TABLE ONLY public.emissions_avoided
    DROP CONSTRAINT IF EXISTS emissions_avoided_project_id_fkey,
    ADD CONSTRAINT emissions_avoided_project_id_fkey FOREIGN KEY (project_id) 
        REFERENCES public.project(id) ON DELETE CASCADE;

-- medium

ALTER TABLE ONLY public.medium
    DROP CONSTRAINT IF EXISTS medium_creator_fkey,
    ADD CONSTRAINT medium_creator_fkey FOREIGN KEY (creator) REFERENCES public.profile(id);

ALTER TABLE ONLY public.medium
    DROP CONSTRAINT IF EXISTS medium_object_id_fkey,
    ADD CONSTRAINT medium_object_id_fkey FOREIGN KEY (object_id) REFERENCES storage.objects(id);

ALTER TABLE ONLY public.medium
    DROP CONSTRAINT IF EXISTS medium_programme_id_fkey,
    ADD CONSTRAINT medium_programme_id_fkey 
        FOREIGN KEY (programme_id) REFERENCES public.programme(id);

ALTER TABLE ONLY public.medium
    DROP CONSTRAINT IF EXISTS medium_programme_step_id_fkey,
    ADD CONSTRAINT medium_programme_step_id_fkey 
        FOREIGN KEY (programme_step_id) REFERENCES public.step(id);

ALTER TABLE ONLY public.medium
    DROP CONSTRAINT IF EXISTS medium_project_id_fkey,
    ADD CONSTRAINT medium_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.project(id);


-- profile

ALTER TABLE ONLY public.profile
    DROP CONSTRAINT IF EXISTS profile_id_fkey,
    ADD CONSTRAINT profile_id_fkey FOREIGN KEY (id) REFERENCES auth.users(id) ON DELETE CASCADE;


-- programme_response

ALTER TABLE ONLY public.programme_response
    DROP CONSTRAINT IF EXISTS programme_response_programme_step_id_fkey,
    ADD CONSTRAINT programme_response_programme_step_id_fkey 
        FOREIGN KEY (programme_step_id) REFERENCES public.programme_step(id);


-- programme_step

ALTER TABLE ONLY public.programme_step
    DROP CONSTRAINT IF EXISTS programme_step_programme_id_fkey,
    ADD CONSTRAINT programme_step_programme_id_fkey 
        FOREIGN KEY (programme_id) REFERENCES public.programme(id);


-- project

ALTER TABLE ONLY public.project
    DROP CONSTRAINT IF EXISTS project_programme_id_fkey,
    ADD CONSTRAINT project_programme_id_fkey 
        FOREIGN KEY (programme_id) REFERENCES public.programme(id);


-- response

ALTER TABLE ONLY public.response
    DROP CONSTRAINT IF EXISTS response_creator_fkey,
    ADD CONSTRAINT response_creator_fkey FOREIGN KEY (creator) REFERENCES public.profile(id);

ALTER TABLE ONLY public.response
    DROP CONSTRAINT IF EXISTS response_object_id_fkey,
    ADD CONSTRAINT response_object_id_fkey FOREIGN KEY (object_id) REFERENCES storage.objects(id);

ALTER TABLE ONLY public.response
    DROP CONSTRAINT IF EXISTS response_programme_response_id_fkey,
    ADD CONSTRAINT response_programme_response_id_fkey 
        FOREIGN KEY (programme_response_id) REFERENCES public.programme_response(id);

ALTER TABLE ONLY public.response
    DROP CONSTRAINT IF EXISTS response_step_id_fkey,
    ADD CONSTRAINT response_step_id_fkey FOREIGN KEY (step_id) REFERENCES public.step(id);


-- role

ALTER TABLE ONLY public.role
    DROP CONSTRAINT IF EXISTS role_programme_id_fkey,
    ADD CONSTRAINT role_programme_id_fkey FOREIGN KEY (programme_id) REFERENCES public.programme(id);

ALTER TABLE ONLY public.role
    DROP CONSTRAINT IF EXISTS role_project_id_fkey,
    ADD CONSTRAINT role_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.project(id);

ALTER TABLE ONLY public.role
    DROP CONSTRAINT IF EXISTS role_user_id_fkey,
    ADD CONSTRAINT role_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id);


-- step

ALTER TABLE ONLY public.step
    DROP CONSTRAINT IF EXISTS step_paid_by_fkey,
    ADD CONSTRAINT step_paid_by_fkey FOREIGN KEY (paid_by) REFERENCES public.profile(id);

ALTER TABLE ONLY public.step
    DROP CONSTRAINT IF EXISTS step_programme_step_id_fkey,
    ADD CONSTRAINT step_programme_step_id_fkey 
        FOREIGN KEY (programme_step_id) REFERENCES public.programme_step(id);

ALTER TABLE ONLY public.step
    DROP CONSTRAINT IF EXISTS step_project_id_fkey,
    ADD CONSTRAINT step_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.project(id);

ALTER TABLE ONLY public.step
    DROP CONSTRAINT IF EXISTS step_submitter_fkey,
    ADD CONSTRAINT step_submitter_fkey FOREIGN KEY (submitter) REFERENCES public.profile(id);

ALTER TABLE ONLY public.step
    DROP CONSTRAINT IF EXISTS step_validator_fkey,
    ADD CONSTRAINT step_validator_fkey FOREIGN KEY (validator) REFERENCES public.profile(id);
