-- 
-- Row-Level Security (RLS) policies for project defined tables
-- 

ALTER TABLE public.medium ENABLE ROW LEVEL SECURITY;

CREATE POLICY select_for_all ON public.medium FOR SELECT USING (true);


ALTER TABLE public.profile ENABLE ROW LEVEL SECURITY;

CREATE POLICY select_for_self ON public.profile FOR SELECT TO authenticated 
    USING ((auth.uid() = id));
CREATE POLICY insert_for_self ON public.profile FOR INSERT TO authenticated 
    WITH CHECK ((auth.uid() = id));
CREATE POLICY update_for_self ON public.profile FOR UPDATE TO authenticated 
    USING ((auth.uid() = id)) 
    WITH CHECK ((auth.uid() = id));


ALTER TABLE public.programme ENABLE ROW LEVEL SECURITY;

CREATE POLICY select_for_all ON public.programme FOR SELECT 
    USING (true);


ALTER TABLE public.programme_response ENABLE ROW LEVEL SECURITY;

CREATE POLICY select_for_all ON public.programme_response FOR SELECT 
    USING (true);


ALTER TABLE public.programme_step ENABLE ROW LEVEL SECURITY;

CREATE POLICY select_for_all ON public.programme_step FOR SELECT 
    USING (true);


ALTER TABLE public.project ENABLE ROW LEVEL SECURITY;

CREATE POLICY select_for_all ON public.project FOR SELECT 
    USING (true);
CREATE POLICY insert_for_auth ON public.project FOR INSERT TO authenticated 
    WITH CHECK (true);
CREATE POLICY update_for_own_project ON public.project FOR UPDATE TO authenticated 
    USING (public.can_implement(id)) WITH CHECK (public.can_implement(id));


ALTER TABLE public.response ENABLE ROW LEVEL SECURITY;

CREATE POLICY select_for_all ON public.response FOR SELECT 
    USING (true);
CREATE POLICY insert_for_own_project ON public.response FOR INSERT TO authenticated 
    WITH CHECK (public.can_implement(public.project_for_response(id)));


ALTER TABLE public.role ENABLE ROW LEVEL SECURITY;


ALTER TABLE public.step ENABLE ROW LEVEL SECURITY;

CREATE POLICY select_for_all ON public.step FOR SELECT 
    USING (true);
CREATE POLICY insert_for_own_project ON public.step FOR INSERT TO authenticated 
    WITH CHECK (public.can_implement(project_id));


ALTER TABLE storage.migrations ENABLE ROW LEVEL SECURITY;


ALTER TABLE storage.objects ENABLE ROW LEVEL SECURITY;


--
-- Row-Level Security (RLS) policies for Supabase defined tables
--

ALTER TABLE storage.buckets ENABLE ROW LEVEL SECURITY;

CREATE POLICY "insert_for_auth 12m4lle_0" ON storage.objects FOR INSERT TO authenticated 
    WITH CHECK 
        (((bucket_id = 'responses'::text) AND 
        (storage.extension(name) = ANY (ARRAY['mp4'::text, '3gp'::text, 'webm'::text, 'mkv'::text]))));

CREATE POLICY "select_for_all 12m4lle_0" ON storage.objects FOR SELECT 
    USING 
        (((bucket_id = 'responses'::text) AND 
        (storage.extension(name) = ANY (ARRAY['mp4'::text, '3gp'::text, 'webm'::text, 'mkv'::text]))));
