-- 
-- Row-Level Security (RLS) policies for project defined tables
-- 

ALTER TABLE public.medium ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS select_for_all ON public.medium;
CREATE POLICY select_for_all ON public.medium FOR SELECT USING (true);


ALTER TABLE public.profile ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS select_for_all ON public.profile;
CREATE POLICY select_for_self ON public.profile FOR SELECT TO authenticated 
    USING auth.uid() = id;

DROP POLICY IF EXISTS insert_for_self ON public.profile;
CREATE POLICY insert_for_self ON public.profile FOR INSERT TO authenticated 
    WITH CHECK auth.uid() = id;

DROP POLICY IF EXISTS update_for_self ON public.profile;
CREATE POLICY update_for_self ON public.profile FOR UPDATE TO authenticated 
    USING auth.uid() = id
    WITH CHECK auth.uid() = id;


ALTER TABLE public.programme ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS select_for_all ON public.programme;
CREATE POLICY select_for_all ON public.programme FOR SELECT 
    USING true;


ALTER TABLE public.programme_response ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS select_for_all ON public.programme_response;
CREATE POLICY select_for_all ON public.programme_response FOR SELECT 
    USING true;


ALTER TABLE public.programme_step ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS select_for_all ON public.programme_step;
CREATE POLICY select_for_all ON public.programme_step FOR SELECT 
    USING true;


ALTER TABLE public.project ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS select_for_all ON public.project;
CREATE POLICY select_for_all ON public.project FOR SELECT 
    USING true;

DROP POLICY IF EXISTS insert_for_auth ON public.project;
CREATE POLICY insert_for_auth ON public.project FOR INSERT TO authenticated 
    WITH CHECK true;

DROP POLICY IF EXISTS update_for_own_project ON public.project;
CREATE POLICY update_for_own_project ON public.project FOR UPDATE TO authenticated 
    USING public.can_implement(id)
    WITH CHECK public.can_implement(id);


ALTER TABLE public.response ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS select_for_all ON public.response;
CREATE POLICY select_for_all ON public.response FOR SELECT 
    USING true;

DROP POLICY IF EXISTS insert_for_own_project ON public.response;
CREATE POLICY insert_for_own_project ON public.response FOR INSERT TO authenticated 
    WITH CHECK public.can_implement(public.project_for_response(id));


ALTER TABLE public.role ENABLE ROW LEVEL SECURITY;


ALTER TABLE public.step ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS select_for_all ON public.step;
CREATE POLICY select_for_all ON public.step FOR SELECT 
    USING true;

DROP POLICY IF EXISTS insert_for_own_project ON public.step;
CREATE POLICY insert_for_own_project ON public.step FOR INSERT TO authenticated 
    WITH CHECK public.can_implement(project_id);


--
-- Row-Level Security (RLS) policies for Supabase defined tables
--

ALTER TABLE storage.buckets ENABLE ROW LEVEL SECURITY;


ALTER TABLE storage.migrations ENABLE ROW LEVEL SECURITY;


ALTER TABLE storage.objects ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "insert_for_auth 12m4lle_0" ON storage.objects;
CREATE POLICY "insert_for_auth 12m4lle_0" ON storage.objects FOR INSERT TO authenticated 
    WITH CHECK 
        bucket_id = 'responses' AND 
        -- Function call to determine file extension from name field. 
        -- See "\sf storage.extension" and https://supabase.com/blog/supabase-storage
        storage.extension(name) IN ('mp4', '3gp', 'webm', 'mkv');

DROP POLICY IF EXISTS "select_for_all 12m4lle_0" ON storage.objects;
CREATE POLICY "select_for_all 12m4lle_0" ON storage.objects FOR SELECT 
    USING 
        bucket_id = 'responses' AND 
        storage.extension(name) IN ('mp4', '3gp', 'webm', 'mkv');
