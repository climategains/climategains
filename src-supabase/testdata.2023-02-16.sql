
SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

INSERT INTO auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) VALUES
	('00000000-0000-0000-0000-000000000000', '22d24ffa-9e8d-4eb3-a681-80a313202eae', '{"action":"user_invited","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"supabase_admin","log_type":"team","traits":{"user_email":"matthias@ansorgs.de","user_id":"4153beed-984d-4108-bf43-c0f5617f44bd"}}', '2023-01-31 19:24:56.628868+00', ''),
	('00000000-0000-0000-0000-000000000000', '61e634d5-e55c-4337-820c-663855462a34', '{"action":"user_signedup","actor_id":"4153beed-984d-4108-bf43-c0f5617f44bd","actor_username":"matthias@ansorgs.de","log_type":"team"}', '2023-01-31 19:28:31.701229+00', ''),
	('00000000-0000-0000-0000-000000000000', 'f55fcc3f-136c-43d3-8119-2f73857a27f7', '{"action":"user_recovery_requested","actor_id":"4153beed-984d-4108-bf43-c0f5617f44bd","actor_username":"matthias@ansorgs.de","log_type":"user"}', '2023-02-01 14:32:12.579219+00', ''),
	('00000000-0000-0000-0000-000000000000', '7b065d9b-5cda-4101-81b2-1815bccc9e54', '{"action":"login","actor_id":"4153beed-984d-4108-bf43-c0f5617f44bd","actor_username":"matthias@ansorgs.de","log_type":"account"}', '2023-02-01 14:33:33.601421+00', ''),
	('00000000-0000-0000-0000-000000000000', 'b688bc38-2852-4b1c-a5f6-aea25d9950a7', '{"action":"user_updated_password","actor_id":"4153beed-984d-4108-bf43-c0f5617f44bd","actor_username":"matthias@ansorgs.de","log_type":"user"}', '2023-02-01 14:42:20.707776+00', ''),
	('00000000-0000-0000-0000-000000000000', 'bab00e6e-3497-4eba-b421-d15ed4497574', '{"action":"user_modified","actor_id":"4153beed-984d-4108-bf43-c0f5617f44bd","actor_username":"matthias@ansorgs.de","log_type":"user"}', '2023-02-01 14:42:20.711275+00', ''),
	('00000000-0000-0000-0000-000000000000', 'aed82585-4ad4-47dc-874f-3320fcb6fffe', '{"action":"login","actor_id":"4153beed-984d-4108-bf43-c0f5617f44bd","actor_username":"matthias@ansorgs.de","log_type":"account","traits":{"provider":"email"}}', '2023-02-01 14:52:08.046664+00', ''),
	('00000000-0000-0000-0000-000000000000', '6f96383a-50a0-4e20-8e7f-b7ea4c29be54', '{"action":"user_invited","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"supabase_admin","log_type":"team","traits":{"user_email":"cg-api-testuser-1@grr.la","user_id":"545a051d-dd3a-4fdc-8a49-753d3466f57e"}}', '2023-02-07 18:39:22.544405+00', ''),
	('00000000-0000-0000-0000-000000000000', 'ce712fc9-a004-4862-9f6b-ed6bab29b759', '{"action":"user_signedup","actor_id":"545a051d-dd3a-4fdc-8a49-753d3466f57e","actor_username":"cg-api-testuser-1@grr.la","log_type":"team"}', '2023-02-07 18:39:47.157861+00', ''),
	('00000000-0000-0000-0000-000000000000', '7f36c8c4-2f29-42e3-bd57-d338d54cbe1f', '{"action":"user_updated_password","actor_id":"545a051d-dd3a-4fdc-8a49-753d3466f57e","actor_username":"cg-api-testuser-1@grr.la","log_type":"user"}', '2023-02-07 19:03:56.854929+00', ''),
	('00000000-0000-0000-0000-000000000000', 'b0c8b14f-6132-4951-b60a-8c49107f50c7', '{"action":"user_modified","actor_id":"545a051d-dd3a-4fdc-8a49-753d3466f57e","actor_username":"cg-api-testuser-1@grr.la","log_type":"user"}', '2023-02-07 19:03:56.856776+00', '');

INSERT INTO auth.users (instance_id, id, aud, role, email, encrypted_password, email_confirmed_at, invited_at, confirmation_token, confirmation_sent_at, recovery_token, recovery_sent_at, email_change_token_new, email_change, email_change_sent_at, last_sign_in_at, raw_app_meta_data, raw_user_meta_data, is_super_admin, created_at, updated_at, phone, phone_confirmed_at, phone_change, phone_change_token, phone_change_sent_at, email_change_token_current, email_change_confirm_status, banned_until, reauthentication_token, reauthentication_sent_at, is_sso_user) VALUES
	('00000000-0000-0000-0000-000000000000', '4153beed-984d-4108-bf43-c0f5617f44bd', 'authenticated', 'authenticated', 'matthias@ansorgs.de', '$2a$10$bXVE0PbbSX3F8xndmRPrtOMjxegZCMtk8zfzGuRPgEihT9q7WKnm2', '2023-01-31 19:28:31.702358+00', '2023-01-31 19:24:56.630124+00', '', '2023-01-31 19:24:56.630124+00', '', '2023-02-01 14:32:12.582247+00', '', '', NULL, '2023-02-01 14:52:08.047519+00', '{"provider": "email", "providers": ["email"]}', '{}', NULL, '2023-01-31 19:24:56.59452+00', '2023-02-01 14:52:08.049701+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false),
	('00000000-0000-0000-0000-000000000000', '545a051d-dd3a-4fdc-8a49-753d3466f57e', 'authenticated', 'authenticated', 'cg-api-testuser-1@grr.la', '$2a$10$s9GNP2K.VCuvEAlMjXWYs.8IZ.DACZuw2hziTB1UBkwnVm7oYeF0S', '2023-02-07 18:39:47.158504+00', '2023-02-07 18:39:22.545699+00', '', '2023-02-07 18:39:22.545699+00', '', NULL, '', '', NULL, '2023-02-07 18:39:47.15935+00', '{"provider": "email", "providers": ["email"]}', '{}', NULL, '2023-02-07 18:39:22.526785+00', '2023-02-07 19:03:56.854036+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false);

INSERT INTO auth.sessions (id, user_id, created_at, updated_at, factor_id, aal, not_after) VALUES
	('5d607df1-5120-4a98-906e-4b5ec1db90a0', '4153beed-984d-4108-bf43-c0f5617f44bd', '2023-02-01 14:33:33.602153+00', '2023-02-01 14:33:33.602153+00', NULL, 'aal1', NULL),
	('ad5151ff-423b-4f23-942b-9dc08cf94ca5', '4153beed-984d-4108-bf43-c0f5617f44bd', '2023-02-01 14:52:08.047584+00', '2023-02-01 14:52:08.047584+00', NULL, 'aal1', NULL),
	('e005f7e6-7c22-4208-9d46-b8ff25ed0d00', '545a051d-dd3a-4fdc-8a49-753d3466f57e', '2023-02-07 18:39:47.1594+00', '2023-02-07 18:39:47.1594+00', NULL, 'aal1', NULL);

INSERT INTO auth.mfa_amr_claims (session_id, created_at, updated_at, authentication_method, id) VALUES
	('5d607df1-5120-4a98-906e-4b5ec1db90a0', '2023-02-01 14:33:33.607203+00', '2023-02-01 14:33:33.607203+00', 'otp', '83438502-e6b4-4eea-87a6-2cd172cbb8f0'),
	('ad5151ff-423b-4f23-942b-9dc08cf94ca5', '2023-02-01 14:52:08.050938+00', '2023-02-01 14:52:08.050938+00', 'password', '1acf51a6-4e7f-4174-a1f4-30fb0921cccc'),
	('e005f7e6-7c22-4208-9d46-b8ff25ed0d00', '2023-02-07 18:39:47.163873+00', '2023-02-07 18:39:47.163873+00', 'otp', 'dfc431aa-e291-4a65-b607-a31cee1f47e1');

INSERT INTO auth.refresh_tokens (instance_id, id, token, user_id, revoked, created_at, updated_at, parent, session_id) VALUES
	('00000000-0000-0000-0000-000000000000', 2, 'oV3KMRPW7_yAr2r7JTR1Wg', '4153beed-984d-4108-bf43-c0f5617f44bd', false, '2023-02-01 14:33:33.603073+00', '2023-02-01 14:33:33.603073+00', NULL, '5d607df1-5120-4a98-906e-4b5ec1db90a0'),
	('00000000-0000-0000-0000-000000000000', 3, 'eTeaHZgoRzqIhB8cGd6Ezg', '4153beed-984d-4108-bf43-c0f5617f44bd', false, '2023-02-01 14:52:08.04858+00', '2023-02-01 14:52:08.04858+00', NULL, 'ad5151ff-423b-4f23-942b-9dc08cf94ca5'),
	('00000000-0000-0000-0000-000000000000', 4, 'cyfTgyXS0QaP2FjwN-303g', '545a051d-dd3a-4fdc-8a49-753d3466f57e', false, '2023-02-07 18:39:47.160792+00', '2023-02-07 18:39:47.160792+00', NULL, 'e005f7e6-7c22-4208-9d46-b8ff25ed0d00');

INSERT INTO auth.schema_migrations (version) VALUES
	('20171026211738'),
	('20171026211808'),
	('20171026211834'),
	('20180103212743'),
	('20180108183307'),
	('20180119214651'),
	('20180125194653'),
	('00'),
	('20210710035447'),
	('20210722035447'),
	('20210730183235'),
	('20210909172000'),
	('20210927181326'),
	('20211122151130'),
	('20211124214934'),
	('20211202183645'),
	('20220114185221'),
	('20220114185340'),
	('20220224000811'),
	('20220323170000'),
	('20220429102000'),
	('20220531120530'),
	('20220614074223'),
	('20220811173540'),
	('20221003041349'),
	('20221003041400'),
	('20221011041400'),
	('20221020193600'),
	('20221021073300'),
	('20221021082433'),
	('20221027105023'),
	('20221114143122'),
	('20221114143410'),
	('20221125140132'),
	('20221208132122'),
	('20221215195500'),
	('20221215195800'),
	('20221215195900');

INSERT INTO public.profile (id, firstname, lastname, organization, language, payment_accounts) VALUES
	('4153beed-984d-4108-bf43-c0f5617f44bd', 'Matthias', 'Ansorg', 'Climate Gains', 'en', NULL);

INSERT INTO public.programme (id, name, created, updated, country_code, location_name, funding_source, emissions_avoided, active) VALUES
	(1, 'Uganda school kitchen modernisation', '2023-02-01 19:15:23.613125+00', '2023-02-01 19:15:23.613125+00', 'ug', 'Kampala', 'European Union', 50000, true);

INSERT INTO public.programme_step (id, programme_id, "order", name, description, funding_amount, worktime, risks, supplies, suppliers, active, funding_currency, support) VALUES
	(2, 1, 200, 'Baseline situation', 'Create and submit a video showing the situation at the start of the project.', 2000, 2, '{"Ordinary occpational hazards"}', '{"smartphone with video camera"}', '{"{\"url\": \"https://kazanga.store/\", \"name\": \"Mr. Kazanga''s Universal Store\", \"@type\": \"LocalBusiness\", \"address\": {\"@type\": \"PostalAddress\", \"postalCode\": \"94086\", \"addressRegion\": \"\", \"streetAddress\": \"Soandso Street 123\", \"addressLocality\": \"Kampala\"}, \"@context\": \"https://schema.org\", \"telephone\": \"+34 850 648 4200\", \"description\": \"Good source of construction materials.\"}"}', true, 'EUR', NULL),
	(1, 1, 100, 'Application Phase', 'Create and submit an application video. After approval, you will receive the first funding and can start the work.', 1000, 1, '{"loss of time if application rejected"}', '{"smartphone with video camera"}', '{"{\"url\": \"https://kazanga.store/\", \"name\": \"Mr. Kazanga''s Universal Store\", \"@type\": \"LocalBusiness\", \"address\": {\"@type\": \"PostalAddress\", \"postalCode\": \"94086\", \"addressRegion\": \"\", \"streetAddress\": \"Soandso Street 123\", \"addressLocality\": \"Kampala\"}, \"@context\": \"https://schema.org\", \"telephone\": \"+34 850 648 4200\", \"description\": \"Good source of construction materials.\"}"}', true, 'EUR', '{"name": "Peter Helpful", "@type": "Person", "@context": "https://schema.org", "workLocation": [{"telephone": "+12 345 67890", "contactType": "WhatsApp"}, {"telephone": "+12 543 09876", "contactType": "phone (work)"}, {"email": "mail@example.com", "contactType": "e-mail"}]}');

INSERT INTO public.project (id, programme_id, name, created, updated, geo_lat, geo_long, location_name) VALUES
	(1, 1, 'Kampala 1 project', '2023-02-07 19:15:40.323956+00', '2023-02-07 19:15:40.323956+00', 0.398251, 32.478843, 'Kampala');

INSERT INTO public.step (id, project_id, programme_step_id, submitted, validation_updated, validation_status, validation_comment, paid, payment_comment, submitter, validator, paid_by) VALUES
	(1, 1, 1, '2023-02-11 18:53:37.403701+00', NULL, NULL, NULL, NULL, NULL, '4153beed-984d-4108-bf43-c0f5617f44bd', NULL, NULL);

INSERT INTO storage.buckets (id, name, owner, created_at, updated_at, public) VALUES
	('media', 'media', NULL, '2023-02-01 14:06:03.878134+00', '2023-02-01 14:06:03.878134+00', true),
	('responses', 'responses', NULL, '2023-02-02 03:07:08.36242+00', '2023-02-02 03:07:08.36242+00', true);

INSERT INTO public.medium (id, mimetype, name, extension, created, url, caption, programme_id, project_id, programme_step_id, role, creator, object_id) VALUES
	(2, 'video/h265', 'UG1', 'mp4', '2023-02-01 20:22:39.788713+00', 'https://cloud.vashgreenschools.org/index.php/apps/cms_pico/pico/ghanagreenschools/assets/UG1.mp4', 'placeholder video', 1, NULL, NULL, 'video', '4153beed-984d-4108-bf43-c0f5617f44bd', NULL),
	(3, 'image/jpg', 'UG3', 'jpg', '2023-02-01 20:24:14.754219+00', 'https://cloud.vashgreenschools.org/index.php/apps/cms_pico/pico/ghanagreenschools/assets/UG3.jpg', 'Stove Construction', 1, NULL, NULL, 'gallery_picture', '4153beed-984d-4108-bf43-c0f5617f44bd', NULL),
	(4, 'image/jpg', 'UG4', 'jpg', '2023-02-01 20:25:02.701166+00', 'https://cloud.vashgreenschools.org/index.php/apps/cms_pico/pico/ghanagreenschools/assets/UG4.jpg', 'Final Installation New Stove', 1, NULL, NULL, 'gallery_picture', '4153beed-984d-4108-bf43-c0f5617f44bd', NULL),
	(1, 'image/jpg', 'UG2', 'jpg', '2023-02-01 20:14:13.069952+00', 'https://cloud.vashgreenschools.org/index.php/apps/cms_pico/pico/ghanagreenschools/assets/UG2.jpg', 'Traditional School Kitchen', 1, NULL, NULL, 'poster', '4153beed-984d-4108-bf43-c0f5617f44bd', NULL);

INSERT INTO public.programme_response (id, programme_step_id, "order", prompt, active) VALUES
	(1, 1, 100, 'Tell us how do you plan to execute this project?', true),
	(2, 1, 200, 'What challenges will you probably encounter, and how will you solve them?', true),
	(3, 1, 300, 'As a security check, repeat this phrase: the quick young fox jumps over the lazy dog.', true),
	(4, 2, 100, 'Show and describe the school''s kitchen situation on video while walking around in the kitchen.', true);

INSERT INTO public.response (id, object_id, created, creator, geo_lat, geo_long, url, mimetype, programme_response_id, step_id) VALUES
	(2, NULL, '2023-02-07 20:14:14+00', '4153beed-984d-4108-bf43-c0f5617f44bd', NULL, NULL, 'https://cloud.vashgreenschools.org/index.php/s/ZpNaL2miYBEJqWd/download/UG1.mp4', 'video/*', 1, 1),
	(3, NULL, '2023-02-07 20:15:11+00', '4153beed-984d-4108-bf43-c0f5617f44bd', NULL, NULL, 'https://2050today.org/wp-content/uploads/2020/07/Video-Placeholder.mp4', 'video/*', 2, 1),
	(4, NULL, '2023-02-07 20:18:19+00', '4153beed-984d-4108-bf43-c0f5617f44bd', NULL, NULL, 'https://samplelib.com/lib/preview/mp4/sample-5s.mp4', 'video/*', 3, 1);

INSERT INTO public.role (programme_id, project_id, user_id, id, activist_application, manager_application, validator_application, activist, manager, validator) VALUES
	(1, NULL, '4153beed-984d-4108-bf43-c0f5617f44bd', 1, NULL, NULL, NULL, NULL, NULL, NULL),
	(NULL, 1, '545a051d-dd3a-4fdc-8a49-753d3466f57e', 4, NULL, NULL, NULL, NULL, NULL, NULL),
	(NULL, 1, '545a051d-dd3a-4fdc-8a49-753d3466f57e', 2, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO storage.migrations (id, name, hash, executed_at) VALUES
	(0, 'create-migrations-table', 'e18db593bcde2aca2a408c4d1100f6abba2195df', '2023-01-30 16:55:08.989349'),
	(1, 'initialmigration', '6ab16121fbaa08bbd11b712d05f358f9b555d777', '2023-01-30 16:55:08.994394'),
	(2, 'pathtoken-column', '49756be03be4c17bb85fe70d4a861f27de7e49ad', '2023-01-30 16:55:08.998073'),
	(3, 'add-migrations-rls', 'bb5d124c53d68635a883e399426c6a5a25fc893d', '2023-01-30 16:55:09.026399'),
	(4, 'add-size-functions', '6d79007d04f5acd288c9c250c42d2d5fd286c54d', '2023-01-30 16:55:09.031891'),
	(5, 'change-column-name-in-get-size', 'fd65688505d2ffa9fbdc58a944348dd8604d688c', '2023-01-30 16:55:09.037092'),
	(6, 'add-rls-to-buckets', '63e2bab75a2040fee8e3fb3f15a0d26f3380e9b6', '2023-01-30 16:55:09.046179'),
	(7, 'add-public-to-buckets', '82568934f8a4d9e0a85f126f6fb483ad8214c418', '2023-01-30 16:55:09.050526'),
	(8, 'fix-search-function', '1a43a40eddb525f2e2f26efd709e6c06e58e059c', '2023-01-30 16:55:09.055227'),
	(9, 'search-files-search-function', '34c096597eb8b9d077fdfdde9878c88501b2fafc', '2023-01-30 16:55:09.061173'),
	(10, 'add-trigger-to-auto-update-updated_at-column', '37d6bb964a70a822e6d37f22f457b9bca7885928', '2023-01-30 16:55:09.068161');

SELECT pg_catalog.setval('auth.refresh_tokens_id_seq', 4, true);

SELECT pg_catalog.setval('public.files_id_seq', 4, true);

SELECT pg_catalog.setval('public.programmes_id_seq', 1, true);

SELECT pg_catalog.setval('public.projects_id_seq', 1, true);

SELECT pg_catalog.setval('public.responses_id_seq', 4, true);

SELECT pg_catalog.setval('public.responses_templates_id_seq', 4, true);

SELECT pg_catalog.setval('public.role_application_id_seq', 4, true);

SELECT pg_catalog.setval('public.steps_id_seq', 1, true);

SELECT pg_catalog.setval('public.steps_meta_id_seq', 2, true);

