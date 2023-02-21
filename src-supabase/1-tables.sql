--
-- Project-defined tables
-- (Includes constraints, except that foreign key constraints are in 3-fkey-constraints.sql.)

/*  To adapt tables, it is best to alter them in Supabase, and reflect the changes 
    in code here. If you need to see a table definition for <tablename>, use this command:

    pg_dump -h db.uvjqnxkfzenbljxcutbx.supabase.co -p 5432 -d postgres -U postgres \
        -t public.<tablename> --schema-only --no-comments | sed -e '/^--/d' | sed -e '/^$/N;/^\n$/D'

    However, if there is a need to empty the table space to recreate the schema below:
    (Best done this "tabula rasa" way to not have to deal with dependent objects. Remember to 
    also re-create the table's dependent views, foreign key constraints, triggers and privileges.)

DROP TABLE IF EXISTS 
    public.medium,
    public.profile,
    public.programme_response,
    public.programme_step,
    public.project,
    public.role,
    public.response,
    public.step
    CASCADE;
*/

--
-- medium
--

CREATE TABLE public.medium (
    id bigint NOT NULL,
    mimetype text,
    name text,
    extension text,
    created timestamp with time zone DEFAULT (now() AT TIME ZONE 'utc'::text) NOT NULL,
    url text,
    caption text,
    programme_id bigint,
    project_id bigint,
    programme_step_id bigint,
    role text,
    creator uuid,
    object_id uuid
);

ALTER TABLE public.medium OWNER TO postgres;

ALTER TABLE public.medium ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.medium_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY public.medium ADD CONSTRAINT medium_pkey PRIMARY KEY (id);

COMMENT ON TABLE public.medium IS 
    'File uploads, in an external S3 compatible object storage system. Read-accessible with just '
    'the anon API key, no account needed.';
COMMENT ON COLUMN public.medium.id IS 'Database-internal ID. Auto-generated for inserts.';
COMMENT ON COLUMN public.medium.mimetype IS E''
    'Media type (formerly called "MIME type") of the file. Should be a value from the official '
    'standard: https://www.iana.org/assignments/media-types/media-types.xhtml . In practice, only '
    'images and videos will be used here, so one of the following values should be used (considers '
    'Android encoder support and how MIME types are designated there):'
    '\n\n'
    '  • image/png \n'
    '  • image/jpg \n'
    '  • image/jpeg \n'
    '  • video/H263 \n'
    '  • video/H264 \n'
    '  • video/VP8 \n'
    '  • video/3gpp (.3gp files. Container format for H.263 and H.264.) \n'
    '  • video/mp4 (.mp4 files. Container format for H.263, H.264, H.265.) \n'
    '  • video/x-matroska (.mkv files. Container format for any video codec.) \n'
    '  • video/webm (.webm files. Container format for VP8.)';
COMMENT ON COLUMN public.medium.name IS 'File basename of the file, as uploaded. Not including any '
    'directory names or the filename extension.';
COMMENT ON COLUMN public.medium.extension IS 'Extension of the filename, as uploaded. For example '
    'jpg or mp4. Not including a "." (dot).';
COMMENT ON COLUMN public.medium.created IS 'File upload time.  If not provided, set to the current '
    'time for inserts.';
COMMENT ON COLUMN public.medium.url IS E'Public URL for file access. All files are read-only '
    'accessible via such public URLs. This URL is usually auto-generated based on the assigned '
    'object ID, so does not have to be provided when uploading.'
    '\n\n'
    'However, as a special case (useful for testing etc.) this also allows table rows describing an '
    'externally hosted file, by providing an external URL and no object_id value.';
COMMENT ON COLUMN public.medium.caption IS 'Image or video caption to show alongside the medium on '
    'display.';
COMMENT ON COLUMN public.medium.programme_id IS 'ID (see programme.id) of the programme to which '
    'the file is associated. One and only one of programme_id, project_id or programme_step_id must '
    'be set, the others must be NULL.';
COMMENT ON COLUMN public.medium.project_id IS 'ID (see project.id) of the project to which the file '
    'is associated. One and only one of programme_id, project_id or programme_step_id must be set, '
    'the others must be NULL.';
COMMENT ON COLUMN public.medium.programme_step_id IS 'ID (see programme_step.id) of the programme '
    'step to which the file is associated. One and only one of programme_id, project_id or '
    'programme_step_id must be set, the others must be NULL.';
COMMENT ON COLUMN public.medium.role IS E'In what capacity or function the file should be displayed '
    'in the associated programme, project or step.'
    '\n\n'
    'Currently must be one of: \n'
    '  • video \n'
    '  • gallery_picture \n'
    '  • poster \n';
COMMENT ON COLUMN public.medium.creator IS 'User ID (see profile.id) of the user who has uploaded '
    'the file.';
COMMENT ON COLUMN public.medium.object_id IS 'S3 object ID of the file. References '
    'storage.objects.id, a column in an internal table of the Supabase-generated storage system.';


--
-- profile
--

CREATE TABLE public.profile (
    id uuid NOT NULL,
    fullname text NOT NULL,
    organization text,
    ui_language text DEFAULT '''en'''::text,
    payment_accounts jsonb
);

ALTER TABLE public.profile OWNER TO postgres;

ALTER TABLE ONLY public.profile ADD CONSTRAINT profile_pkey PRIMARY KEY (id);

COMMENT ON TABLE public.profile IS 'Profile information of Climate Gains API users. Associated 1:1 '
    'with the Supabase provided table auth.users, and providing extended information for it.';
COMMENT ON COLUMN public.profile.id IS 'Database-internal ID. Must be provided for inserts as '
    'a value referencing auth.users.id, a column in a Supabase provided internal table.';
COMMENT ON COLUMN public.profile.fullname IS 'Full user name, in "firstname middlenames lastname" '
    'format.';
COMMENT ON COLUMN public.profile.organization IS 'Name of the organization (if any) that deployed '
    'the user to work in a Climate Gains programme.';
COMMENT ON COLUMN public.profile.ui_language IS 'User’s preferred user interface language. Must be a '
    'two-letter language code according to ISO 639-1. See: '
    'https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes';
COMMENT ON COLUMN public.profile.payment_accounts IS E'Payment information how this user wants to '
    'receive the funding associated with project steps. One payment account per array element.'
    '\n\n'
    'A JSON array, whose elements must conform to https://schema.googleapis.com/Account (sadly, no '
    'equivalent is available yet in schema.org properties). Many different types of accounts (bank '
    'account, MPesa, PayPal, cash transfer services etc.) can be described.';


--
-- programme
--

CREATE TABLE public.programme (
    id bigint NOT NULL,
    name text NOT NULL,
    created timestamp with time zone DEFAULT (now() AT TIME ZONE 'utc'::text) NOT NULL,
    updated timestamp with time zone DEFAULT (now() AT TIME ZONE 'utc'::text),
    country_code text,
    location_name text,
    funding_source text NOT NULL,
    emissions_avoided bigint,
    active boolean DEFAULT true NOT NULL
);

ALTER TABLE public.programme OWNER TO postgres;

ALTER TABLE public.programme ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.programme_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY public.programme ADD CONSTRAINT programmes_name_key UNIQUE (name);

ALTER TABLE ONLY public.programme ADD CONSTRAINT programmes_pkey PRIMARY KEY (id);

COMMENT ON TABLE public.programme IS 'Funding programmes, with one to many projects each. Read-'
    'accessible with just the anon API key, no account needed.';
COMMENT ON COLUMN public.programme.id IS 'Database-internal ID. Auto-generated for inserts.';
COMMENT ON COLUMN public.programme.name IS 'Programme name. Enforced to be unique within the API’s '
    'database.';
COMMENT ON COLUMN public.programme.created IS 'Creation date and time of the programme’s database '
    'record. If not provided, set to the current time for inserts.';
COMMENT ON COLUMN public.programme.updated IS 'Date and time of the programme database record’s '
    'last update. If not provided, set to the current time for inserts.';
COMMENT ON COLUMN public.programme.country_code IS 'Two-letter ("alpha-2") country code of the '
    'country to which the programme applies. See https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2 . '
    'Each programme is valid in exactly one country only.';
COMMENT ON COLUMN public.programme.location_name IS 'Name of the location in which the programme '
    'applies. Omit (leave NULL) to apply the programme to the whole of the country. Any value is '
    'understood to refer to the first search result of OpenStreetMap Nominatim (see '
    'https://nominatim.openstreetmap.org/ ), allowing to show an embedded map with the corresponding '
    'boundaries.';
COMMENT ON COLUMN public.programme.funding_source IS 'Name of the organization or person financing '
    'this programme.';
COMMENT ON COLUMN public.programme.emissions_avoided IS 'Estimated greenhouse gas (GHG) emissions '
    'avoided by each project of this programme, over the estimated full lifetime if the solution '
    'implemented by the project. Unit is kg of CO₂ equivalent GHG emissions. This estimate does not '
    'consider that projects may differ from each other in small ways. If changed, the new value is '
    'retroactively applied to all existing projects as well.';
COMMENT ON COLUMN public.programme.active IS 'Programme status; use "false" for draft or completed '
    'programmes. Do not use "false" to replace a programme with an updated version. This column is '
    'not a version management mechanism, as there is no way to navigate from a replaced programme '
    'to its replacement, or vice versa. Instead of replacing a programme, replace the steps inside '
    'it that you want to update.';


--
-- programme_response
--

CREATE TABLE public.programme_response (
    id bigint NOT NULL,
    programme_step_id bigint NOT NULL,
    "order" smallint NOT NULL,
    prompt text NOT NULL,
    active boolean DEFAULT true NOT NULL
);

ALTER TABLE public.programme_response OWNER TO postgres;

ALTER TABLE public.programme_response ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.programme_response_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY public.programme_response ADD CONSTRAINT programme_response_pkey PRIMARY KEY (id);

COMMENT ON TABLE public.programme_response IS 'Programme-level metadata about the (video) responses '
    'created during the implementation of a project. Read-accessible with just the anon API key, no '
    'account needed.';
COMMENT ON COLUMN public.programme_response.id IS 'Database-internal ID. Auto-generated for inserts.';
COMMENT ON COLUMN public.programme_response.programme_step_id IS E'Programme step associated with '
    'this programme response. Several programme responses can be associated with the same programme '
    'step.'
    '\n\n'
    'A similar association holds for the implementation data: several responses can be associated '
    'with the same step, but this is transitively so because each step is associated with one '
    'programme step, and each response with one programme response.';
COMMENT ON COLUMN public.programme_response."order" IS E'Relative order of this record, relative to '
    'the programme response records that belong to the same programme step (see programme_step_id).'
    '\n\n'
    'When adding a new response, the recommended practice is to use a value 128 larger than for the '
    'previous response, to support inserting  responses in between later at the half-way point '
    'between two order values.';
COMMENT ON COLUMN public.programme_response.prompt IS 'Prompt to be answered by a project’s '
    'associated video response. Should generally be a full sentence and end in a question mark.';
COMMENT ON COLUMN public.programme_response.active IS E'If this programme response record should be '
    'considered when recording new responses in a project. If false, it may still be used by existing '
    'responses.'
    '\n\n'
    'This allows for simple version management: you can replace a programme response with a new '
    'version (needed only if the meaning changes significantly) by using the same order value and '
    'setting the old one’s active column to "false".';


--
-- programme_step
--

CREATE TABLE public.programme_step (
    id bigint NOT NULL,
    programme_id bigint NOT NULL,
    "order" smallint,
    name text NOT NULL,
    description text,
    funding_amount numeric DEFAULT '0'::numeric NOT NULL,
    worktime numeric,
    risks text[],
    supplies text[],
    suppliers jsonb[],
    active boolean DEFAULT true NOT NULL,
    funding_currency text NOT NULL,
    support jsonb
);

ALTER TABLE public.programme_step OWNER TO postgres;

ALTER TABLE public.programme_step ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.programme_step_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY public.programme_step ADD CONSTRAINT programme_step_pkey PRIMARY KEY (id);

COMMENT ON TABLE public.programme_step IS 'Programme-level metadata about the steps of a project’s '
    'implementation. Read-accessible with just the anon API key, no account needed.';
COMMENT ON COLUMN public.programme_step.id IS 'Database-internal ID. Auto-generated for inserts.';
COMMENT ON COLUMN public.programme_step.programme_id IS 'Programme to which this programme step '
    'belongs. Each programme can have any number of programme steps.';
COMMENT ON COLUMN public.programme_step."order" IS E'Relative order of this record, relative to the '
    'programme step records that belong to the same programme (see programme_id).'
    '\n\n'
    'When adding a new step, the recommended practice is to use a value 128 larger than for the '
    'previous response, to support inserting steps in between later at the half-way point between '
    'two order values.';
COMMENT ON COLUMN public.programme_step.name IS 'Name of this programme step. For example, '
    '"Application", "Baseline Situation", "Stove Installation". Should use title case.';
COMMENT ON COLUMN public.programme_step.description IS 'Plain text description of what this '
    'programme step is about.';
COMMENT ON COLUMN public.programme_step.funding_amount IS 'Use together with column funding_currency.';
COMMENT ON COLUMN public.programme_step.worktime IS 'Estimate of the number of hours that will be '
    'required to execute this step, incl. reporting via the Climate Gains app.';
COMMENT ON COLUMN public.programme_step.risks IS E'Risks and challenges associated with executing '
    'this step in any one project.'
    '\n\n'
    'One risk per array element. Each array element should be suitable for display as a list item '
    '(starting with lowercase, max. half a sentence long).';
COMMENT ON COLUMN public.programme_step.supplies IS E'Supplies needed to execute this step in any '
    'one project.'
    '\n\n'
    'One supply item per array element. Each array element should be suitable for display as a list '
    'item (starting with lowercase, max. half a sentence long).';
COMMENT ON COLUMN public.programme_step.suppliers IS E'Businesses that are approved suppliers of the '
    'supplied needed for the execution of this step.'
    '\n\n'
    'One supplier per array element. Data must conform to https://schema.org/LocalBusiness , though '
    'only a basic subset will be used in client applications. For the supported subset regarding '
    'contact information, see on column "programme_step.support".';
COMMENT ON COLUMN public.programme_step.active IS E'If this programme step should be considered '
    'when showing the remaining steps to existing and new projects.\n'
    '\n\n'
    'This allows for simple version management: you can replace a programme step with a new version '
    '(needed only if the meaning changes significantly) by using the same order value and setting '
    'the old one’s active column to "false".';
COMMENT ON COLUMN public.programme_step.funding_currency IS 'Currency used for the funding amount '
    '(see column funding_amount). Must be an ISO 4217 three-letter currency code such as "EUR", '
    '"GBP", "USD". See: https://en.wikipedia.org/wiki/ISO_4217';
COMMENT ON COLUMN public.programme_step.support IS E'Contact point for technical support for the '
    'execution of this step in a project.'
    '\n\n'
    'Data must conform to https://schema.org/Organization or https://schema.org/Person , though '
    'only a basic subset will be evaluated in client applications. Client applications are only '
    'required to evaluate the following properties:'
    '\n\n'
    '  • Organization.name / Person.name \n'
    '  • Organization.url / Person.url (official website, optional) \n'
    '  • Organization.address / Person.address (optional) \n'
    '  • Organization.contactPoint / Person.workLocation \n'
    '\n\n'
    'The latter two are of type https://schema.org/ContactPoint , used for all other contact '
    'options. Only the following subset of its properties needs to be evaluated by client '
    'applications:'
    '\n\n'
    '  • name (contact point name, e.g. "Company WhatsApp number") \n'
    '  • description \n'
    '  • contactType (freetext value, e.g. "support (WhatsApp)") \n'
    '  • telephone \n'
    '  • email \n'
    '  • hoursAvailable \n'
    '  • identifier (for non-standard contact options such as WhatsApp) \n'
    '  • url (if an external URL, even if with a custom protocol prefix, is available that '
        'corresponds to the contact option; provide "identifier" as well where possible) \n'
    '  • sameAs (for social media profile links, according to widespread practice; also in case '
        'several URLs have to be stored, such as a call link and a profile link for a Skype handle) \n'
    '\n\n'
    'For the recommended way to encode WhatsApp, Facebook Messenger etc. contact options, see '
    'https://stackoverflow.com/a/75437791 and for social media links see '
    'https://stackoverflow.com/a/27376493. Multiple ContactPoint values per property are possible, '
    'as always with schema.org definitions.';


--
-- project
--

CREATE TABLE public.project (
    id bigint NOT NULL,
    programme_id bigint NOT NULL,
    name text NOT NULL,
    created timestamp with time zone DEFAULT (now() AT TIME ZONE 'utc'::text) NOT NULL,
    updated timestamp with time zone DEFAULT (now() AT TIME ZONE 'utc'::text) NOT NULL,
    geo_lat double precision,
    geo_long double precision,
    location_name text
);

ALTER TABLE public.project OWNER TO postgres;

ALTER TABLE public.project ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.project_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY public.project ADD CONSTRAINT project_pkey PRIMARY KEY (id);

COMMENT ON TABLE public.project IS 'A project is an instance of a programme, that is, one "run" or '
    'execution at a specific place and time with a specific project team. Each project has several '
    'steps, each step has several responses. Read-accessible with just the anon API key, no account '
    'needed.';
COMMENT ON COLUMN public.project.id IS 'Database-internal ID. Auto-generated for inserts.';
COMMENT ON COLUMN public.project.programme_id IS 'Programme implemented by this project.';
COMMENT ON COLUMN public.project.name IS 'Name of this project. Often set to an auto-generated '
    'value based on the programme name and the project’s location.';
COMMENT ON COLUMN public.project.created IS 'Date and time when this project has been created. If '
    'not provided, set to the current time for inserts.';
COMMENT ON COLUMN public.project.updated IS 'Date and time when this project has been last updated. '
    'If not provided, set to the current time for inserts.';
COMMENT ON COLUMN public.project.geo_lat IS 'Latitude of this project’s geolocation. If the '
    'project does not have a point-like geolocation (for example, a village or town), use the '
    'approximate centerpoint of the project area instead. This is meant to show a reference to this '
    'project on maps, not to direct visitors.';
COMMENT ON COLUMN public.project.geo_long IS 'Longitude of this project’s geolocation. If the '
    'project does not have a point-like geolocation (for example, a village or town), use the '
    'approximate centerpoint of the project area instead. This is meant to show a reference to this '
    'project on maps, not to direct visitors.';
COMMENT ON COLUMN public.project.location_name IS E'Name of the location at which the project is '
    'executed. Used to show the outline of the area in which the project is executed. Supply only '
    'if the project does not have a point-like geolocation (for example, if it applies to a whole '
    'village or town). Omit if the project has a point-like geolocation (house, farm etc.), as in '
    'that case the name of any containing georeferences can be determined automatically.'
    '\n\n'
    'Any value is understood to refer to the first search result of OpenStreetMap Nominatim (see '
    'https://nominatim.openstreetmap.org/ ), allowing to show an embedded map with the corresponding'
    ' boundaries.';


--
-- response
--

CREATE TABLE public.response (
    id bigint NOT NULL,
    object_id uuid,
    created timestamp with time zone DEFAULT (now() AT TIME ZONE 'utc'::text) NOT NULL,
    creator uuid NOT NULL,
    geo_lat double precision,
    geo_long double precision,
    url text,
    mimetype text DEFAULT 'video/*'::text,
    programme_response_id bigint NOT NULL,
    step_id bigint NOT NULL
);

ALTER TABLE public.response OWNER TO postgres;

ALTER TABLE public.response ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.response_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY public.response ADD CONSTRAINT response_pkey PRIMARY KEY (id);

COMMENT ON TABLE public.response IS E''
    'A response, in video format, to a prompt defined in a programme response record.'
    '\n\n'
    'Each project has several steps (see table "step"), each step has several responses. Each '
    'response belongs to one project, and each project to one programme.'
    '\n\n'
    'Read-accessible with just the anon API key, no account needed. Response records are not '
    'supposed to be updated. If a response is not validated, a new response can be submitted for '
    'validation.';
COMMENT ON COLUMN public.response.id IS 'Database-internal ID. Auto-generated for inserts.';
COMMENT ON COLUMN public.response.object_id IS 'Reference to the video object of which this '
    'response is made.';
COMMENT ON COLUMN public.response.created IS 'Date and time when this response record has been '
    'created. If not provided, set to the current time for inserts.';
COMMENT ON COLUMN public.response.creator IS 'User ID of the user submitting the response. '
    'Different responses may be submitted by different users, even for responses that belong to '
    'the same step.';
COMMENT ON COLUMN public.response.geo_lat IS 'Geolocation latitude of the response’s video, '
    'extracted from its metadata.';
COMMENT ON COLUMN public.response.geo_long IS 'Geolocation longitude of the response’s video, '
    'extracted from its metadata.';
COMMENT ON COLUMN public.response.url IS E'Public URL for file access. All files are read-only '
    'accessible via such public URLs. This URL is usually auto-generated based on the assigned '
    'object ID, so does not have to be provided when uploading.'
    '\n\n'
    'However, as a special case (useful for testing etc.) this also allows records describing an '
    'externally hosted file, by providing an external URL and no object_id value.';
COMMENT ON COLUMN public.response.mimetype IS E'Media type (formerly called "MIME type") of the '
    'file. Should be a value from the official standard: '
    'https://www.iana.org/assignments/media-types/media-types.xhtml . In practice, only videos will '
    'be used here, so one of the following values should be used (considers Android encoder support '
    'and how MIME types are designated there):'
    '\n\n'
    '  • video/mp4 (.mp4 files. Container format for H.263, H.264, H.265.) \n'
    '  • video/3gpp (.3gp files. Container format for H.263 and H.264.) \n'
    '  • video/webm (.webm files. Container format for VP8.) \n'
    '  • video/x-matroska (.mkv files. Container format for any video codec.) \n'
    '  • video/H263 (H.263 media format, no own file extension) \n'
    '  • video/H264 (MPEG-4 Visual media format, no own file extension) \n'
    '  • video/VP8 (Vorbis media format, no own file extension)'
    '\n\n'
    'Later, image formats may also be allowed, but not yet:'
    '\n\n'
    '  • image/png \n'
    '  • image/jpg \n'
    '  • image/jpeg \n';
COMMENT ON COLUMN public.response.programme_response_id IS 'Reference to the associated programme '
    'response record. Contains programme-level metadata associated with this response, among other '
    'things including the prompt to display when collecting this response.';
COMMENT ON COLUMN public.response.step_id IS 'Project step associated with this response. Find out '
    'the response’s associated project via this association.';


--
-- role
--

CREATE TABLE public.role (
    programme_id bigint,
    project_id bigint,
    user_id uuid NOT NULL,
    id bigint NOT NULL,
    activist_application boolean,
    manager_application boolean,
    validator_application boolean,
    activist boolean,
    manager boolean,
    validator boolean
);

ALTER TABLE public.role OWNER TO postgres;

ALTER TABLE public.role ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.role_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY public.role ADD CONSTRAINT role_pkey PRIMARY KEY (id);

COMMENT ON TABLE public.role IS 'User permission records. One column per role and role application '
    'due to Supabase good practices (see https://noteshub.net/tLUW3ojVyImd ).';
COMMENT ON COLUMN public.role.programme_id IS 'Programme ID if this ACL entry relates to a '
    'programme. NULL otherwise. Either programme_id or project_id must be set.';
COMMENT ON COLUMN public.role.project_id IS 'Programme ID if this ACL entry relates to a project. '
    'NULL otherwise. Either programme_id or project_id must be set.';
COMMENT ON COLUMN public.role.user_id IS 'UUID of the user who is subject of this role record.';
COMMENT ON COLUMN public.role.id IS 'Database-internal ID. Auto-generated for inserts.';
    -- A surrogate primary key was necessary as the SQL standard forbids NULL in primary key values. 
    -- A composite primary key (programme_id, project_id, user_id, role) would have needed NULL 
    -- values due to the polymorphic relation modeled there.
COMMENT ON COLUMN public.role.activist_application IS 'If the user applied for the activist role to '
    'the project or programme.';
COMMENT ON COLUMN public.role.manager_application IS 'If the user applied for the manager role to '
    'the project or programme.';
COMMENT ON COLUMN public.role.validator_application IS 'If the user applied for the validator role '
    'to the project or programme.';
COMMENT ON COLUMN public.role.activist IS E'If the user has been approved (true) or disapproved '
    '(false, preventing further applications) for the activist role in this project or programme.'
    '\n\n'
    'In a project, this role gives general team collaborator access, allowing to submit steps and '
    'responses. In a programme, this gives no additional permissions, it’s just possible for '
    'symmetry.';
COMMENT ON COLUMN public.role.manager IS E'If the user has been approved (true) or disapproved '
    '(false, preventing further applications) for the manager role in this project or programme.'
    '\n\n'
    'In a project, this role allows to edit project metadata and to approve applying activists. In '
    'a programme, this allows full user management in the programme and all its projects (incl. of '
    'validators), and to edit payment information of its projects.';
COMMENT ON COLUMN public.role.validator IS E'If the user has been approved (true) or disapproved '
    '(false, preventing further applications) for the validator role in this project or programme.'
    '\n\n'
    'In a project, this role allows to validate project steps. In a programme, this allows to '
    'validate project steps in all projects of the programme.';


--
-- step
--

CREATE TABLE public.step (
    id bigint NOT NULL,
    project_id bigint NOT NULL,
    programme_step_id bigint NOT NULL,
    submitted timestamp with time zone DEFAULT (now() AT TIME ZONE 'utc'::text) NOT NULL,
    validation_updated timestamp with time zone,
    validation_status text,
    validation_comment text,
    paid timestamp with time zone,
    payment_comment text,
    submitter uuid NOT NULL,
    validator uuid,
    paid_by uuid
);

ALTER TABLE public.step OWNER TO postgres;

ALTER TABLE public.step ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.steps_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY public.step ADD CONSTRAINT step_pkey PRIMARY KEY (id);

COMMENT ON TABLE public.step IS E'Each record contains execution related information about one step '
    'in a project’s execution. Each project has several steps, each step has several responses.'
    '\n\n'
    'Read-accessible with just the anon API key, no account needed.';
COMMENT ON COLUMN public.step.id IS 'Database-internal ID. Auto-generated for inserts.';
COMMENT ON COLUMN public.step.project_id IS 'Project to which this step belongs. Also allows to '
    'find out the  programme with which this step is associated. (Another way to find this out is '
    'via column programme_step_id.)';
COMMENT ON COLUMN public.step.programme_step_id IS 'Programme step record that serves as the '
    'template for this step, also providing relevant meta information. Among that is the programme '
    'with which this step is associated. (Another way to find this out is via column project_id.)';
COMMENT ON COLUMN public.step.submitted IS 'Timestamp when this step has been submitted by the '
    'activist for approval. No edits are possible by the activist after that.';
COMMENT ON COLUMN public.step.validation_updated IS 'Timestamp when this step’s validation status '
    'has been last updated, if any.';
COMMENT ON COLUMN public.step.validation_status IS 'Current validation status of this step. One of '
    '"validateable", "validated", "rejected". NULL is equivalent to "validateable". Status '
    '"validated" or "rejected" will not change anymore. Rather, in status "rejected", the next step '
    'would be a resubmission with fixed data (i.e. creating a new step record).';
COMMENT ON COLUMN public.step.validation_comment IS 'Optional comment by the validator on the last '
    'validation status change. Can detail the reasons for rejecting to validate a step.';
COMMENT ON COLUMN public.step.paid IS 'Timestamp when the funding associated with the successful '
    'validation of this step has been paid (see programme_step.funding_amount). NULL if no payment '
    'has been sent yet.';
COMMENT ON COLUMN public.step.payment_comment IS 'Optional comment by the user who made the '
    'payment, detailing any relevant details that should be relayed to the project’s team. For '
    'example, the choice of payment channel in case there were several options.';
COMMENT ON COLUMN public.step.submitter IS 'UUID of the user who submitted (created) this record.';
COMMENT ON COLUMN public.step.validator IS 'UUID of the user who made the most recent change to '
    'column validation_status.';
COMMENT ON COLUMN public.step.paid_by IS 'UUID of the user who paid out the funding associated '
    'with the successful validation of this step.';
