ALTER TABLE ONLY public.medium
    ADD CONSTRAINT medium_creator_fkey FOREIGN KEY (creator) REFERENCES public.profile(id);

ALTER TABLE ONLY public.medium
    ADD CONSTRAINT medium_object_id_fkey FOREIGN KEY (object_id) REFERENCES storage.objects(id);

ALTER TABLE ONLY public.medium
    ADD CONSTRAINT medium_programme_id_fkey FOREIGN KEY (programme_id) REFERENCES public.programme(id);

ALTER TABLE ONLY public.medium
    ADD CONSTRAINT medium_programme_step_id_fkey FOREIGN KEY (programme_step_id) REFERENCES public.step(id);

ALTER TABLE ONLY public.medium
    ADD CONSTRAINT medium_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.project(id);

ALTER TABLE ONLY public.profile
    ADD CONSTRAINT profile_id_fkey FOREIGN KEY (id) REFERENCES auth.users(id);

ALTER TABLE ONLY public.programme_response
    ADD CONSTRAINT programme_response_programme_step_id_fkey FOREIGN KEY (programme_step_id) REFERENCES public.programme_step(id);

ALTER TABLE ONLY public.programme_step
    ADD CONSTRAINT programme_step_programme_id_fkey FOREIGN KEY (programme_id) REFERENCES public.programme(id);

ALTER TABLE ONLY public.project
    ADD CONSTRAINT project_programme_id_fkey FOREIGN KEY (programme_id) REFERENCES public.programme(id);

ALTER TABLE ONLY public.response
    ADD CONSTRAINT response_creator_fkey FOREIGN KEY (creator) REFERENCES public.profile(id);

ALTER TABLE ONLY public.response
    ADD CONSTRAINT response_object_id_fkey FOREIGN KEY (object_id) REFERENCES storage.objects(id);

ALTER TABLE ONLY public.response
    ADD CONSTRAINT response_programme_response_id_fkey FOREIGN KEY (programme_response_id) REFERENCES public.programme_response(id);

ALTER TABLE ONLY public.response
    ADD CONSTRAINT response_step_id_fkey FOREIGN KEY (step_id) REFERENCES public.step(id);

ALTER TABLE ONLY public.role
    ADD CONSTRAINT role_programme_id_fkey FOREIGN KEY (programme_id) REFERENCES public.programme(id);

ALTER TABLE ONLY public.role
    ADD CONSTRAINT role_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.project(id);

ALTER TABLE ONLY public.role
    ADD CONSTRAINT role_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id);

ALTER TABLE ONLY public.step
    ADD CONSTRAINT step_paid_by_fkey FOREIGN KEY (paid_by) REFERENCES public.profile(id);

ALTER TABLE ONLY public.step
    ADD CONSTRAINT step_programme_step_id_fkey FOREIGN KEY (programme_step_id) REFERENCES public.programme_step(id);

ALTER TABLE ONLY public.step
    ADD CONSTRAINT step_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.project(id);

ALTER TABLE ONLY public.step
    ADD CONSTRAINT step_submitter_fkey FOREIGN KEY (submitter) REFERENCES public.profile(id);

ALTER TABLE ONLY public.step
    ADD CONSTRAINT step_validator_fkey FOREIGN KEY (validator) REFERENCES public.profile(id);