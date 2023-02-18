# Climate Gains

## Table of Contents

[**1. Project**](#1-project)

[**2. Components**](#2-components)

[**3. Features**](#3-features)

[**4. Instructions**](#4-instructions)


## **1. Project**

*   **Overview**

    *   A mobile application and its backend API for the parallel and massively parallel management of projects. Basically a crowd project management software. Unlike in existing project management software, all messaging is done with videos, both for verifiability of work, and for convenience.

    *   The initial usage is for carbon emission reduction projects, executed by activists. Each project by itself is on a small to medium scale, but all projects combined can have a huge impact.

*   **💡 App**
    
    *   README
        
        *   \[<mark>TODO; for build, distribution and development instructions</mark>\]
            
    *   source code
        
        *   https://github.com/climategains/ionic-vue-app
            
    *   💡 online test version
        
        *   https://climategainsapp.netlify.app/
            
    *   credentials
        
*   **💡 Backend API**
    
    *   💡 Rationale for the Climate Gains API design
        
        *   **Option for external media hosting.** Tables `medium` and `response` have both a reference to an uploaded file in column `object_id` and a column `url`. Both columns are nullable, but at least one has to set (and that can and should be ensured with a composite constraint on the table). Only column `url` should be used by client software – when no external URL is given, this column will default to a value based on the `object_id` column.  
            This allows to point to an externally hosted file instead of an uploaded object, which is useful for example during testing.
            
            *   For the composite constraint on the table to ensure at least one of `object_id` and `url` is set, use method "Exclusive Belongs To" from [this article](https://hashrocket.com/blog/posts/modeling-polymorphic-associations-in-a-relational-database).
                
        *   **Programme change management.** It must be possible to change programmes while they are running, but without affecting the already created project, step and response records of that programme. Full duplication of project, step and response metadata into the project, step and response records is not a good idea as it creates a lot of redundancy, making it hard to, for example, fix a spelling error everywhere. Full version management is also not a good idea, as a whole programme would be duplicated whenever a new version is made. Instead, we chose a simple option: being able to simply edit programmes (incl. the order of steps and responses) when it does not affect the meaning, and being able to replace or add step and response metadata when it does affect the meaning.  
            Replacing is done by adding a new step or response metadata record and setting `active = false` for the old ones. These old records are still kept, as existing steps and responses refer to them. However, the remaining steps and responses of existing projects will be the new, active versions (where "remaining" means, having a higher `order` value than already submitted steps and responses). Already submitted `step` records will be validated according to the programme as it was when submitting; this is possible, as the `step` and `response` records refer to the old `programme_step` and `programme_response` records, respectively. Similarly, already validated `step` records are still considered validated after changes to the programme.  
            In short, never delete records from the `programme*` tables.
            
        *   **Order columns with gaps for intermediate values.** To support [programme change management](https://noteshub.net/WEPTuNYihGtD), `programme_step.order` and `programme_response.order` columns use values with delta 128 initially (128, 256, 384 etc.), allowing to easily add records in between existing ones when needed.
            
        *   **Re-execution of project steps.** After a project step has been disapproved, there has to be an option to resubmit it. In that case, simply a new `step` record is created. The step record with the last `step.submitted` date is the one that will be presented for validation. From the activist side, submitting a `step` record is final: until its potential disapproval, no deletion or editing or submission of a new `step` record for the same (or any later) project step is possible. The same applies to all `response` records associated to a `step` record. Also to allow resubmission, both `step` and `response` records have an auto-incrementing artificial primary key, rather than using a composite primary key (such as `step.programme_step_id` with `step.project_id`).
            
        *   **One type of users, different roles.** Users do not sign up as either "activist" or "validator", just as a user. All roles are assigned later, always in relation to specific projects. So, every user can apply as validator to any programme or project, can create projects for every programme, and so on. And every user can be set (by an admin user) to be a payment\_manager for a project or programme, or (later) to have global role "funder" or "admin" and so on.
            
*   **Domains**
    
    *   climategains.org
        
        *   usage
            
            *   main domain
                
            *   e-mail domain
                
        *   DNS hosting
            
            *   DomainDiscount24, account of Edgeryders
                
    *   climategains.community
        
        *   usage
            
            *   Discourse forum domain
                
        *   DNS hosting
            
            *   DomainDiscount24, account of Edgeryders
                
*   **Forum**
    
    *   https://climategains.community/
        
*   **Github**
    
    *   organization
        
        *   URL
            
            *   https://github.com/climategains
                
        *   account name
            
            *   climategains
                
        *   controlled by
            
            *   account "tanius"
                
            *   Chosen because the business details of the Climate Gains company were not available when creating the organization. Does not matter, as user "tanius" can give control to business representatives himself. See: https://github.com/orgs/community/discussions/23813
                
*   **Landing Site**
    
    *   URL
        
        *   https://web.climategains.community/
            
        *   https://climategains.org/


## **2. Components**

*   **JWT**
    
    *   JavaScript Web Token, a token standard to establish authentication against the Backend API.
        
    *   JWT analyzer and builder tool
        
        *   [https://jwt.io/#debugger-io](https://jwt.io/#debugger-io)
            
*   **OpenAPI Spec, Swagger**
    
    *   [OpenAPI Specification](https://spec.openapis.org/oas/latest.html) (OAS)
        
        *   A standard for API documentation of all RESTful HTTP APIs. There are related standards for documenting asyncAPIs, JSON schemas etc. as well.
            
        *   Developed by the [OpenAPI Initiative](https://www.openapis.org/).
            
        *   [💡 basic structure](https://swagger.io/docs/specification/basic-structure/)
            
        *   [specs document v3.0.3](https://github.com/OAI/OpenAPI-Specification/blob/master/versions/3.0.3.md)
            
    *   Using Swagger from Nest.js
        
        *   [Swagger integration module source code](https://github.com/nestjs/swagger) (note: we currently use version 5.1.5)
            
        *   [Swagger API Documentation Tips and Tricks in NestJS](https://trilon.io/blog/nestjs-swagger-tips-tricks) (article)
            
        *   [Nest.js OpenAPI documentation](https://docs.nestjs.com/openapi/introduction) (the official Nest.js Swagger integration manual, but for some reason does not list all options of all decorators, that is, it is not a full reference)
            
        *   [](https://docs.swagger.io/swagger-core/v2.0.0-RC3/apidocs/overview-summary.html)[💡 Sw](https://swagger.io/docs/specification/basic-structure/)[agger Annotations API reference 2.0.0](https://docs.swagger.io/swagger-core/v2.0.0-RC3/apidocs/overview-summary.html) (since the Nest.js OpenAPI docs are incomplete, we need to use this; add `@Api…` in front of an annotation name to use it inside Nest.js code)
            
            *   For example, for documentation of `@ApiOperation` in Nest.js code, you would [look here](https://docs.swagger.io/swagger-core/v2.0.0-RC3/apidocs/io/swagger/v3/oas/annotations/Operation.html).
                
            *   This is (probably …) the correct reference vesion. Because this is OpenAPI v3 based, and the Swagger documentation created for our applications also mentions "OASv3" at the top.
                
        *   [Swagger 2.x Annotations Wiki](https://github.com/swagger-api/swagger-core/wiki/Swagger-2.X---Annotations) (resource that can be useful in addition to the Swagger reference)
            
        *   [OpenAPI Data Types](https://swagger.io/docs/specification/data-models/data-types/) (You can usually expect these to be usable in `@ApiOperation` with the Nest.js Swagger integration.)
            
        *   Use `'\n\n'` or `"\n\n"` to generate a new paragraph in Swagger output ([source](https://stackoverflow.com/a/58848132)).
            
        *   Use Markdown to add links, headings, formatting etc. to Swagger `description` fields ([source](https://stackoverflow.com/a/39929108)).
            
    *   [Swagger Open Source Tools](https://swagger.io/tools/open-source/)
        
        *   Tools that implement the OpenAPI Specification and can be used, among other things, to provide the API documentation as part of the project's website.
            
    *   Swagger-to-diagram tools
        
        *   https://github.com/nrekretep/pikturr
            
        *   https://github.com/mcf-rocha/swagger-graph
            
        *   Or just create this manually in FreeMind. For one diagram and its updates, that is way faster than installing all that jazz of other tools.
            
*   **NotesHub**
    
*   **n:point**
    
    *   A JSON storage service to create and edit JSON responses, forming a lightweight backend that can be used during software development and prototyping. Also supports JSON schemas, so that editing the data afterwards will not break the app connected to it.
        
    *   website
        
        *   [https://www.npoint.io/](https://www.npoint.io/)
            
    *   documents
        
        *   [Climate Gains Programmes](https://www.npoint.io/docs/357710bb39fbed2df166)
            
        *   [Climate Gains Projects](https://www.npoint.io/docs/ba243b5c47dd4e69d3a1)
            
*   **PostgreSQL**
    
    *   [PostgreSQL 15.2 Documentation](https://www.postgresql.org/docs/15/)
        
    *   💡 PostgreSQL and Supabase Good Practices _(alias)_
        
*   **PostgREST**
    
    *   An API generator based on a PostgreSQL database schema. Used by Supabase.
        
*   **Supabase**
    
    *   An open source [low-code development platform](https://en.wikipedia.org/wiki/Low-code_development_platform) for RESTful APIs that is [rapidly gaining in popularity since early 2021](https://trends.google.com/trends/explore?date=today%205-y&q=supabase). Meant to be an open source replacement for Firebase. Based on PostgreSQL, PostgREST and other open source technologies.
        
    
    *   Documentation
        
        *   Article series: "[Going "Serverless" With Supabase](https://dev.to/davepar/series/20898)". Best technical intro so far.
            
    *   JavaScript client library 2.0
        
        *   [reference documentation](https://supabase.com/docs/reference/javascript)
            
    *   💡💡 Supabase and PostgreSQL Good Practices
        
        *   _(Conventions follows in this project. Provided as aliases of notes in Instructions.)_
            
        *   What are best practices for indenting SQL statements?
            
        *   What are good principles and practices for Supabase API design?
            
        *   Why is it good practice to to only use schema-qualified identifiers inside views and function?
            
*   **Digital Public Goods Standard**
    
    *   A standard for their digital outputs that UNDP and other similar organizations promised to adhere to.
        
    *   [https://digitalpublicgoods.net/](https://digitalpublicgoods.net/)


## **3. Features**

*   **❌ Discarded**
    
    *   **Location radius for Climate Actions**
        
        *   _Status: Discarded in favour of "API for programme location via OSM outlines"_
            
        *   A Climate Action needs a "meta → location → radius" element in the API. Because sometimes the location is a whole country, or a region, or similar. Then at least an approx. location and can be shown on a map. Limiting it to various levels of political boundaries would be even better, but for much later.
            
    *   **Backend API (ITMO) extension for Climate Gains app**
        
        *   _⚠️ Status: No longer needed since the move to the Supabase API implementation._
            
        *   Everything that is required by the Climate Gains app. See: [actions.json](https://github.com/climategains/ionic-vue-app/blob/main/src/json/actions.json).
            
        *   Users: login
            
            *   Proposal: Use the existing `POST /api/v1/auth/login`. See also POST /api/v1/auth/authenticate, which is to send the one-time password (OTP) that has been delivered after calling the login endpoint. But we don't want this 2FA hassle, esp. as our users often own only one device anyway. So we need to change the software to make authentication optional in the configuration.  
                See also `GET /api/v1/token` (refreshing the JWT) to keep logged in.
                
            *   The `GET /api/v1/token` endpoint is quite certainly for refreshing the JWT token periodically, which is necessary to stay logged in. From the README: "[JWT](https://jwt.io/) takes care about authentication with token and refresh token." ([source](https://github.com/climategains/digital-carbon-finance/tree/main/api#building-the-project))
                
        *   User Profile: show
            
            *   Proposal: Implement with the existing `GET /api/v1/me`[.](http://admin.climategains.community:8080/docs/#/v1/me/MeController_retrieveMyUserData)
                
        *   User profile: create / show payment information
            
            *   Proposal: Implement by extending the existing `GET /api/v1/me` and `PATCH /api/v1/me` endpoints with optional fields for payment information.
                
        *   Video Inbox: list
            
            *   Proposal: The idea of having an inbox for video messages similar to an e-mail inbox might just not be a good one. It loses the context. Video messages should always appear in the project to which they belong, as part of that project's process. This can be done by extending the existing `POST /api/v1/projects/{id}/comments` endpoint with a way to post a video comment instead of text. [](http://admin.climategains.community:8080/docs/#/v1/projects/ProjectController_sendComment)Notifications about such updates can be provided via the existing `GET /api/v1/me/notifications` endpoint, and clicking on such a notification would bring the user to the right location inside a project's process.
                
            *   ❌ Proposal: Implement with the existing `GET /api/v1/me/files`, `POST /api/v1/me/files`, `GET /api/v1/me/files/{id}`. Files can have different MIME types, allowing to differentiate between videos and documents. For that, the `GET /api/v1/me/files` endpoints needs an additional `mimetype` parameter. **However,** this is called a "video inbox", so probably meant for receiving video messages.
                
        *   Documents: create
            
            *   Proposal: Implement with the existing `POST /api/v1/me/files`.
                
        *   Documents: list
            
            *   Proposal: Implement with the existing `GET /api/v1/me/files`, `GET /api/v1/me/files/{id}`. Files can have different MIME types, allowing to differentiate between videos and documents. For that, the `GET /api/v1/me/files` endpoints needs an additional `mimetype` parameter.
                
        *   Climate Actions: list
            
            *   Formally called "Climate Actions Opportunity Index".
                
            *   💡 Current dummy implementation: see: [actions.json](https://github.com/climategains/ionic-vue-app/blob/main/src/json/actions.json).
                
                *   Showing one action, out of several that can make up one "response" `{ "response": [{ … }]}`.
                    
                *       {  "id": "12982","meta": {"title": "Bisate Reforestation Program","createdAt": "2022-12-01T16:49:00.370Z","author": "479c55b5-0731-4ad9-9012-a9e56f341399","icon": "tree","location": {"lat": "0.317714","long": "32.5813539","town": "Kampala","country": "Rwanda","iso": "RWA"},"funding": {"source": "Climate Gains","currency": "EUR","total": 1670,"carbon": 1200,"hours": 40}},"media": {"poster": "https://example.com/image001.jpg","video": {"url": "https://example.com/video001.mp4","caption": "video caption"},"gallery": [{"url": "https://example.com/gallery_img_001.jpg","caption": ""},{"url": "https://example.com/gallery_img_002.jpg","caption": ""},{"url": "https://example.com/gallery_img_003.jpg","caption": ""}]},"steps": [{"title": "Installation of Counters","funds": "400","hours": 10,"materials": "Wood, tiles, tools","risks": "Must conform to health and safety guidelines","technical_support": {"name": "","address": "","phone": "","email": ""},"suppliers": [2872892,2387872,238738237]},{ … }],"application": {"user_id": "479c55b5-0731-4ad9-9012-a9e56f341338","status": "pending","contract": "uid","questions": [{"text": "Tell us how you plan to execute this project?","duration": 200},{"text": "Question 2","duration": 200}]}}}
                    
            *   💡 Proposal: Rename entity "Country" to "Process" in the software. Only in the backend dashboard UI, not in the API or code, until that renaming has been accepted by the ITMO developers. That keeps the code as compatible as possible with ITMO, making it less effort to merge upstream commits.  
                  Use that "Process" entity to represent climate action opportunities. (Assuming that is what Nadia and Tim want.) When somebody applies to a listed climate action opportunity, a project record is created.  
                  Also add a generic way to attach meta information to processes. Not as fields of the "process" entity, but in a variable way. In our case we need "location", "CO2 reduction amount" and "budget". Also add some fixed fields to this entity, such as the presentation images needed for displaying stuff in the app etc.. Both types of fields must be editable in the backend dashboard ("ITMO"), but not initially. Direct MongoDB manipulation can be used at first.  
                  To associate processes with countries, use the location metadata of the process. Or have an additional association field to select one or more countries from a list. That is enough to display all applicable climate action opportunities to a user based on their location. No separate "country" entity is needed.
                
            *   ❌ Proposal: Implement with the existing `GET /api/v1/projects` endpoint. This is not the right option, as projects seem like individual executions that use a process (that has a set of defined steps etc.). Climate actions would be equivalent to project templates, as they also have these steps.  
                Steps are not defined when creating a project. So "project" probably means a single execution of a project template. Project templates are defined, as a set of steps, in the country's settings. And there will be only one set of steps per country. See "Project Settings" when creating country.
                
        *   ✏️ Climate Actions: show
            
            *   ❌ Proposal: Implement with the existing `GET /api/v1/projects/{id}`. But the same caveats as for "Climate Actions: list" apply.
                
        *   My Climate Actions: list
            
            *   Refers to "Saved Actions" in the wireframes video. Not sure if that is the right understanding.
                
            *   Proposal: Implement with the existing `GET /api/v1/projects`.
                
        *   My Climate Actions: create
            
            *   Refers to "Saved Actions" in the wireframes video. Not sure if that is the right understanding.
                
            *   Proposal: Implement with the existing `POST /api/v1/projects`.
                
        *   Applications: list
            
            *   Proposal: Add an additional endpoint `GET /api/v1/me/applications`. There is already `GET /api/v1/applications` but it is an admin feature for getting all applications, not filtered by user.
                
        *   Applications: create
            
            *   Proposal: Implement with existing `POST /api/v1/me/applications`. Needs extending it with additional parameters. Probably with just one: an optional reference to a video that has been uploaded via the file upload API (see: "Documents: create").
                
        *   Suppliers: list
            
            *   Proposal: Implement with the existing `GET /api/v1/users` endpoint. Add a user role "supplier", and support filtering for that role in this endpoint using the `role` parameter.
                
        *   Suppliers: create
            
            *   Proposal: Implement by filling additional fields in the profile of a user who wants to become a supplier. One of the existing fields is "role", and it must get an additional value option "supplier".
                
        *   ⏳ Search: query
            
            *   Not essential for software functioning, will be implemented as one of the last endpoints.
                
            *   Proposal: Not sure yet what the search function should find: climate actions, users, documents, videos, all of that? For users, there is an existing endpoint `GET /api/v1/users` that supports a free-text search. Other endpoints might have a similar feature.
                
        *   FAQ: list
            
            *   Proposal: Needs a new API endpoint.
                
        *   FAQ: show
            
            *   Proposal: Needs a new API endpoint.
                
*   **✅ Done**
    
    *   **API for programme location via OSM outlines**
        
        *   Decision: In practice, programmes will apply to whole countries, first-layer administrative divisions, and in rare cases to cities. Outlines for all these are available in OpenStreetMap. So, we store only the country name and, in one other field, one location or area identifier that has an outline in OpenStreetMap. Fields for that are already implemented.
            
        *   Alternatives: If there is a need to show the programme area on a map properly with a polygonal outline, then a field with a GeoJSON Polygon can be added: https://www.mongodb.com/docs/manual/reference/geojson/#polygon . For one-off projects in individual buildings or similar, GeoJSON Point would be used: https://www.mongodb.com/docs/manual/reference/geojson/#point . The problem with this approach is, who creates the polygons. A map interface to draw them would be a complex thing to implement. A list of pre-defined polygons (regions, major cities etc.) would be incomplete, but could be extended by admins manually when something is missing.
            
    *   **User permissions in Supabase**
        
        *   ✅ All users, including non-registered / anonymous users with just the "anon" API key, must be able to read the content of tables with "select\_for\_all" LS policies.
            
        *   ✅ All global admin users (currently meaning, those with the service API key) must be able to do everything. They will at first be needed to create programme records, and dependent records.
            
        *   ✅ All users must be able to read video files from bucket "responses".
            
        *   ✅ All registered users must be able to upload videos, that is, to create storage.objects records. But anonymous users must not be able to do so, to prevent offering "free video hosting".
            
        *   ✅ All registered users must be able to create and edit one profile record, containing their own user\_id.
            
        *   ✅ All registered users must be able to create project records.
            
        *   ✅ All registered users must be able to create step records, but only for own projects.
            
        *   ✅ All registered users must be able to create response records for their existing step records.
            
        *   ✅ Users with role "manager" for a project must be able to approve applications of activists to the project.
            
        *   ✅ All users with role "manager" for a project must be able to edit the name, location\_name and geo\_\* columns of that project. But not the others.
            
        *   ✅ Users with role "validator" for a project must be able to validate steps of a project.
            
        *   ✅ Users with role "manager" for a programme must be able to set payment related information in the steps of all projects of the programme.
            
*   **⭐ In Progress, Next**
    
    *   **Host organization name for programmes**
        
        *   A Climate Action (programme) needs a "host organization" name that is listed in the overview.
            
        *   See at 0:20 in the [wireframes video](https://noteshub.net/u43ku6iLpmOE).
            
*   **⏳ Planned**
    
    *   **Errors when directly visiting app URLs**
        
        *   Fix that the web version of the Climate Gains app creates 404 errors when directly visiting URLs that it displayed before.
            
        *   Example: [https://climategainsapp.netlify.app/actions](https://climategainsapp.netlify.app/actions)
            
    *   **Fix authorization in the Swagger UI for the Backend API docs**
        
        *   This should work with the top-right "Authorize" button.
            
        *   It requires entering an `apiKey` and also mentions "Name: `x-api-key` In: `header`". In requests by a logged-in user, there is indeed an `x-api-key` header. Using its value from a logged-in user however does not work to gain privileges in the Swagger docs. The issue seems to be that the Swagger UI simply does not send any API key in the request: there is no `x-api-key` HTTP header in its requests, unlike in the requests made by the ITMO Dashboard software.
            
        *   Seems to be a configuration issue or software bug.
            
        *   For what it's worth, supplying the API key configured as `export API_KEY=…` in the application's `.env` file does not work. It will be accepted, but not lead to any additional privileges.
            
    *   **Show map pins of existing projects in the map of a programme**
        
        *   These map pins should be clickable and open an overlay window of some sort in which one can play the videos associated with the project. These videos are by default public, so there is no issue with access rights.
            
        *   Discussed with Tim Reutemann 2023-01-09 as something that should be implemented, just not immediately.
            
    *   **Reporting for donors**
        
        *   The donor reporting interface can be part of the Backend Dashboard, and probably should be because donors would expect to see reporting on a big screen rather than having to use a mobile app. Reports may include downloadable components ("PDFs"), but as they also include interactive components, there has to be a UI for it somewhere.
            
        *   This has to include an interactive map where all project locations of a programme are visible as map pins, and that allows to click through to the videos provided by each project.
            
    *   **Re-enable the Helmet module in the ClimateGains Backend API**
        
        *   It caused issues with mixed HTTPS and HTTP content when trying to use it together with the Swagger API documentation.
            
        *   Hint on how to solve this: see this [page in the Nest.js docs](https://docs.nestjs.com/openapi/introduction), in the section where it says "When using fastify and helmet, there may be a problem with CSP, to solve this collision, configure the CSP as shown below: \[…\]".
            
    *   **Video upload in multiple chunks**
        
        *   To speed up video uploading and decrease data usage when connectivity is poor and whole-file uploads would have to be retried often.
            
        *   See: [interesting writeup](https://api.video/blog/tutorials/uploading-large-files-with-javascript) demoing this approach, and an associated [JS library](https://api.video/blog/tutorials/new-video-uploader-javascript-library).
            
*   **❓ Potential**
    
    *   **Steps for supplier users**
        
        *   Currently, users of role "SUPPLIER" can only enter contact information in their profile, be approved, and be found in a directory of approved suppliers.
            
        *   In the future, it may be desirable to allow them also to execute steps in a project's execution. Such as "provide these materials", "make a cost estimate" or the like. That would require them to install and use the ClimateGains mobile app, which may or may not be realistic. It also requires a lot of extensions in the ClimateGains API, affecting several hundred locations in the code.
            
    *   **Better API docs**
        
        *   API tags (the first-level groupings in the Swagger UI) [can be documented](https://stackoverflow.com/a/72992150) as well, but are not currently.


## **4. Instructions**

*   **App**
    
    *   **How to package the app into an APK file?**
        
        *   #todo
            
    *   **How to publish a new APK file on Google Play?**
        
        *   #todo
            
    *   **How to publish a new APK file on F-Droid?**
        
        *   #todo
            
*   **Backend API**
    
    *   **How to install the Climate Gains Backend API on supabase.com?**
        
        *   Create a new project on app.supabase.com.
            
            *   This will provide all the Supabase defaults in the project: tables, functions, privileges, triggers etc.. These defaults are not contained in the Climate Gains Git repo, as they are considered dependencies.
                
        *   Enable and disable PostgreSQL extensions as required.
            
            *   Required extensions for a default Supabase project ([source](https://stackoverflow.com/q/72999025)):
                
                *   pgcrypto
                    
                *   pgjwt
                    
                *   uuid-ossp
                    
            *   Additionally required extensions for the Climate Gains project:
                
                *   (none)
                    
        *   Clone [the Github repository](https://github.com/climategains/ionic-vue-app):
            
            *       git clone git@github.com:climategains/ionic-vue-app.git
                
        *   Execute the SQL scripts to set up the database structure.
            
            *   Script location in the Github repository (repo name will later change to `climategains`):  
                `https://github.com/climategains/ionic-vue-app/src-supabase/[1-9]-*.sql`
                
            *   You can copy-and-paste them one by one into the Supabase SQL editor.
                
            *   Alternatively, you can use `psql` version 15 on your local machine to execute these scripts:  
                `psql -h db.{ref_id}.supabase.co -p 5432 -d postgres -U postgres -a -f file.sql`
                
        *   Optionally, execute the SQL scripts that provides the latest test dataset:
            
            *   Script location in the Github repository (repo name will later change to `climategains`):  
                `https://github.com/climategains/ionic-vue-app/src-supabase/testdata.yyyy-mm-dd.sql`
                
    *   **How to sign a user up to the Backend API while also providing profile data?**
        
        *   Additional profile information can optionally be supplied at the time of signup via additional payload JSON key `options -> data`. This data will, after signup, be only available and editable in table `profile` as authoritative data source. (User metadata edits via "Update User" (`PUT /auth/v1/user`) are ignored.) Providing any piece of profile data at signup is optional. When not provided, the default will be `NULL`, resp. `'en'` for `language`.
            
        *   JavaScript examples <mark>(not sure yet which one will work, please test and adapt)</mark>
            
            *       // For Supabase API Client Library v2 (supposedly)
                    // TODO: Include example for meta data key "payment_accounts".
                    const result = await my_supabase_client.auth.signUp({ 
                      email: 'xxxx', 
                      password :'xxxx', 
                      options: { 
                        data: { 
                          fullname: 'firstname lastname',
                          organization: 'org name',
                          ui_language: 'en'
                        }
                      }
                    })
                
            *       // For Supabase API Client Library v1 (supposedly)
                    // TODO: Include example for meta data key "payment_accounts".
                    const result = await my_supabase_client.auth.signUp(
                      { email: 'xxxx', password :'xxxx'},
                      { data: { 
                          fullname: 'firstname lastname',
                          organization: 'org name',
                          ui_language: 'en'
                      } }
                    )
                
            *       // For Supabase API Client Library (guess based on JSON structure for curl)
                    // TODO: Include example for meta data key "payment_accounts".
                    const result = await my_supabase_client.auth.signUp({
                      email: 'xxxx', 
                      password :'xxxx'},
                      data: { 
                          fullname: 'firstname lastname',
                          organization: 'org name',
                          ui_language: 'en'
                      }
                    )
                
        *   `curl` example (tested, works; note the different JSON structure)
            
            *       curl -X POST 'https://uvjqnxkfzenbljxcutbx.supabase.co/auth/v1/signup' \
                    -H "apikey: SUPABASE_ANON_KEY" \
                    -H "Content-Type: application/json" \
                    -d '{
                      "email": "test-1@example.com", 
                      "password": "ehwLkXvCscDzRoxVk",
                      "data": { 
                        "fullname": "Test User 1",
                        "organization": "Climate Gains",
                        "ui_language": "en"
                      }
                    }'
                
*   **Noteshub**
    
    *   **How to transfer content from Noteshub to Discourse?**
        
        *   Copy from Noteshub to LibreOffice.
            
        *   Save as a LibreOffice .odt text document.
            
        *   `pandoc --from odt --to markdown_strict --standalone --wrap=none --atx-headers file.odt -o file.odt.md`
            
        *   `xclip -sel c file.odt.md`
            
        *   Now paste into the Discourse editor.
            
*   **PostgreSQL**
    
    *   **What are best practices for indenting SQL statements?**
        
        *   **For SQL scripts.** There is no standard, obviously. But PostgreSQL's `pg_dump` will indent all but the fist line of a statement with a constant indentation. For code, this is a good solution, as you _can_ (if you want) place two statements together without an empty line between them, and still have visual cues where each one ends. This is adopted as best practice in this project. Examples:
            
            *       INSERT INTO public.releases (version) VALUES
                        ('20171026211738'),
                        ('20171026211808'),
                        ('20171026211834');
                
        *   **For individual statements.** For individual SQL statements entered interactively, or reproduced in a book or article, a nice indentation style is to let each line of a SQL statement start without indentation. Examples:
            
            *       SELECT step.project_id
                    FROM response 
                        JOIN step ON step.id = response.step_id
                    WHERE
                        response.id = 2;
                
            *       CREATE POLICY update_for_self ON public.profile FOR UPDATE TO authenticated 
                    USING auth.uid() = id
                    WITH CHECK auth.uid() = id;
                
        *   **For FUNCTION statements.** Compared to the general rule of indenting the second and following keywords, we recommend to make one exception in functions and reset the indentation level to zero at `$$BEGIN`. This way, the function body starts with an indentation level of 1 (rather than 2), as in basically every other programming language. Examples:
            
            *       CREATE OR REPLACE FUNCTION public.project(my_response_id bigint) RETURNS bigint
                        LANGUAGE plpgsql AS
                    $$BEGIN
                        SELECT step.project_id
                            FROM response JOIN step ON step.id = response.step_id
                            WHERE response.id = my_response_id;
                    END;$$;
                
        *   **For COMMENT statements.** Create lines that fit into the source file, with line breaks in the output that are independent of the source file formatting, but using adjacent string literals together with `E'\n'` syntax for linebreaks and `E'\n\n'` for empty lines as paragraph separator ([details](https://stackoverflow.com/a/75490356)).
            
        *   **More information.** See [this StackOverflow question](https://stackoverflow.com/q/272210) and [this article](https://solutioncenter.apexsql.com/sql-formatting-standards-capitalization-indentation-comments-parenthesis/). Note how nearly every answer except one on StackOverflow seems to agree to _not_ indent the second and following keywords of one statement. But above, for SQL scripts, we do recommend that.
            
    *   **Why is it good practice to to only use schema-qualified identifiers inside views and function?**
        
        *   **In views.** If you do not use schema-qualified identifiers, what exactly identifiers of functions, tables etc. mean in your view depends on the `search_path` value at the time the VIEW is created ([source](https://stackoverflow.com/a/42507437)). Means, your SQL source code would not contain the full meaning of what you want to say, which could lead to (rare) deployment issues when names collide. It can not lead to security issues, since the binding is done at view creation time.
            
        *   **In functions.** In order to write SECURITY DEFINER functions safely, PostgreSQL recommends to append `SET search_path = …` to a CREATE FUNCTION statement ([source](https://www.postgresql.org/docs/current/sql-createfunction.html#SQL-CREATEFUNCTION-SECURITY)). However, the problem to solve this way, of malicious users redirecting calls to identifiers to their own tables etc., cannot arise when using only schema-qualified identifiers in the function. And since that is our established practice anyway (see above), we recommend that.
            
    *   **How to protect a function / trigger function from direct execution by users?**
        
        *   This needs three parts: defining the function as "SECURITY DEFINER", revoking execution privileges, and appending pg\_temp to its search path. Instead of the latter, it is also enough to only use schema-qualified tablenames in the function.
            
        *   Sources and explanations:
            
            *   [https://dba.stackexchange.com/a/264001](https://dba.stackexchange.com/a/264001)
                
            *   [https://stackoverflow.com/a/72140046](https://stackoverflow.com/a/72140046)
                
    *   **How to create a RLS policy that involves a JOIN?**
        
        *   This is possible. See: [Supabase Docs: Row Level Security: Policies with Joins](https://supabase.com/docs/guides/auth/row-level-security#policies-with-joins).
            
        *   The thing to keep in mind is how to reference columns of the _current_ row that is being checked by the RLS policy. In all simple RLS policies, simply referring to it by column name is enough. With joins however, it often happens that it will share the same column name as one of the joined tables. In that case, the solution is to prefix it with the table name of the table to which you are adding the RLS policy.
            
    *   **How to simplify RLS policies by chaining them together?**
        
        *   See: "[Intro to Postgres Row-Level Security](https://dev.to/davepar/intro-to-postgres-row-level-security-3b3)", under "Chaining policies".
            
*   **Supabase**
    
    *   **💡 What are good principles and practices for Supabase API design?**
        
        *   **Try to make do with Studio UI options.** Only a subset of PostgREST features can be accessed through the Supabase UI "Studio" currently. Other field types etc. can be added with PostgreSQL commands, but when possible, we want to avoid that. Because then, the database becomes easy to manage, maintain and extend by non-developers, which is the potential of Supabase.
            
        *   **Array types over JSON.** In PostgREST, array columns and JSON / JSONB columns share the same query syntax ([see](https://postgrest.org/en/stable/api.html#composite-array-columns), [see](https://postgrest.org/en/stable/api.html#json-columns)) and insert syntax ([see](https://postgrest.org/en/stable/how-tos/working-with-postgresql-data-types.html#arrays), [see](https://postgrest.org/en/stable/how-tos/working-with-postgresql-data-types.html#json)). However, arrays provide for tighter restrictions on the data: instead of allowing an arbitrarily nested, schemaless JSON data structure, it is clear that a flat list is inside. The more constraints on data are expressed with database means, the better. So where possible, use array type columns over JSON columns.  
            Exception: an "array of json" column makes no sense, as it adds additional complexity for inserting and querying due to the composite datatype. Just use JSON in that case.
            
        *   **JSONB over JSON.** There is little reason to use the JSON column type in PostgreSQL, as JSONB provides more operations without any obvious drawbacks ([see](https://stackoverflow.com/a/39637548)). So it seems best to make the use of JSONB an internal standard for Supabase database design.
            
        *   **All JSON with schemas.** To avoid confusion about what to expect in a JSON / JSONB column, use JSON schema definitions. Wherever possible, use those already defined by schema.org, for example [LocalBusiness](https://schema.org/LocalBusiness) for a supplier listing. It is ok for client applications to only understand and utilize a subset of this information. There are other, competing JSON format standards as well, for example [jCard (RFC7095)](https://www.rfc-editor.org/rfc/rfc7095.html) is a JSON variant of vCard that could be used as an alternative to LocalBusiness. However, schema.org schemas are interconnected, use the same design principles, and are easy to read and write for humans, making it preferable to stick with schema.org schemas, and where needed third-party schemas extending schema.org schemas.
            
        *   **Separate columns over composite types.** It should be possible to use and filter with PostgreSQL composite types in Supabase ([see](https://github.com/supabase/supabase/discussions/2825)). However, these types cannot be created in Supabase Studio UI right now, so in simple cases we rather use a column prefix instead. So instead of a composite type `CREATE TYPE money AS (amount numeric, currency text);` we would always use two separate columns together, such as `funding_amount` and `funding_currency`.
            
        *   **Avoid** `varchar`**.** Even the Supabase UI tells you to not use this column type. The PostgreSQL manual mentions that only `varchar(n)`, as an alternative to `text` plus `CHECK` constraint, can make sense sometimes. But that is not even available in the Supabase interface, just `varchar`.
            
        *   **Column type** `timestamptz` **for timestamps and dates.** Because the PostgreSQL manual [tells](https://wiki.postgresql.org/wiki/Don't_Do_This#Date.2FTime_storage) that basically all other time and date related column types should be avoided. This even applies to column type `date`, as the PostgreSQL manual says [in a different place](https://www.postgresql.org/docs/current/datatype-datetime.html#DATATYPE-TIMEZONES): "the SQL standard has an odd mix of date and time types and capabilities. Two obvious problems are: Although the date type cannot have an associated time zone, the time type can. Time zones in the real world have little meaning unless associated with a date as well as a time, since the offset can vary through the year with daylight-saving time boundaries. \[…\] To address these difficulties, we recommend using date/time types that contain both date and time when using time zones. \[…\] PostgreSQL assumes your local time zone for any type containing only date or time."
            
        *   **Avoid value-level security requirements.** Means, when a user has write access to a column, they should be allowed to use all values this column can take. This is recommendable, as it enabled much simpler options for implementing column-level security. Structure tables so that a user with write access to a column is allowed to use every value in that column. For example, instead of columns `role` (user, admin) and `status` (applied, approved, disapproved), there would be nullable boolean columns `user_application`, `admin_application`, `user_status`, `admin_status`.
            
        *   **Column-level security via RLS policies, triggers or privileged functions.** CLS means to selectively prohibit column updates based on certain conditions. There are several [alternative solutions](https://dba.stackexchange.com/a/323514) for this, each with advantages and disadvantages. They are discussed below.
            
            *   ❓💡💡 **Use RLS policies.** Here, you would use a row-level security (RLS) policy by manually retrieving the old row and comparing if your field's value would change from the old to the new value. A solution candiadate for this has been posted as [a Stack Overflow answer](https://stackoverflow.com/a/71167428), but this has to be made into a generic function still. At first, this seems better than a trigger: it shares its advantages and in addition, Supabase promotes the use of RLS policies for access control anyway, and has much better UI support for RLS than for triggers. So it would improve consistency and maintainability of the database by reducing complexity.  
                However, the Supabase RLS editor cannot be used for complex RLS policies ([issue report](https://github.com/supabase/supabase/issues/12443)), so as a workaround one should wrap all RLS code into a single or nested function call, or at least something no longer than one line of code.
                
            *   ❓💡 **Use triggers.** See [here](https://github.com/supabase/supabase/discussions/656#discussioncomment-4974429) for instructions. A trigger has the advantages to (1) not add another table or view, so that the database structure is determined by the data and not by permission system quirks, as it should be, and (2) to not require changes to the default Supabase permissions or table-to-schema assignments, (3) to combine the powers of RLS policies and column-level permissions. But a trigger has the disadvantages that (1) it is not yet well supported by Supabase: only the trigger status can be changed, but it cannot be shown or edited in the UI, only in PostgreSQL console; and that (2) it requires knowledge of PGSQL or another programming language, and programming is what we try to avoid with Supabase.
                
            *   ❓💡 **Use security definer functions.** "You can hide the table behind a FUNCTION with SECURITY DEFINER. The table itself would not provide UPDATE access, instead users can only update the table through the FUNCTION." ([source](https://dba.stackexchange.com/a/323514)) That function is then exposed through the API: "write PostgreSQL SQL functions \[…\] and call them via `supabase.rpc('function_name', {param1: 'value'});`." ([source](https://dev.to/davepar/going-serverless-with-supabase-103h)). The issue is, however, that the API then no longer has a unified structure of "everything is tables".
                
            *   **Use user-specific views.** [Instructions](https://dba.stackexchange.com/a/301113). More instructions: "You can create a view to only show the columns you want, make sure you secure with a where statement as it ignores RLS (normally), and then use RLS to block the original table." ([source](https://github.com/supabase/supabase/discussions/8663#discussioncomment-3484271)). This solution has been [recommended by a Supabase maintainer](https://github.com/supabase/supabase/discussions/8663#discussioncomment-3484271). In total, RLS policies and triggers seem preferable, though. Advantages and disadvantages:
                
                *   **Advantage: Simple.** Views are just like tables, and everyone knows PostgreSQL tables – in contrast to triggers or (complex) RLS policies.
                    
                *   **Advantage: You see what you edit.** Users (or their applications) who can see records in the table do not have to worry if they are editable due to RLS policies. Whatever a user can see, they can edit.
                    
                *   **❓ Advantage: Extendable as needed.** Only the columns a certain user is allowed to edit can be provided in the view. To find the right column, sometimes more context is needed. Not a problem: join the view and columns from the underlaying base table again as needed, at API access time. Only the surrogate primary key column `id` needs to be always included into the view; this is not an issue: if a user tries to edit it, it can only succeed when using new values, in which case effectively a new record is created, which the user is probably allowed to do anyway. _(To be confirmed that updates with proper access protection are then still possible.)_
                    
                *   **Disadvantage: Cluttering the table space.** Ideally, the API would expose the data in the form they have in a proper database design. By exposing additional views, the API becomes unnecessarily complex.
                    
                *   **Disadvantage: Can not really reuse RLS policies of underlaying table.** To be done by using `security_invoker = on` when creating the view ([details](https://github.com/supabase/supabase/discussions/901)). However, when doing this, the same user that can, say, update a record through the view can then also update that record in the base table, circumventing the column access restrictions for which the view is used. The only way around that would be to move the base table to a custom database scheme that is not exposed by API. That is possible, but adds yet more structural complexity.
                    
                *   **Disadvantage: Needs changes to the default view permissions.** Since these are simple views, they are "updateable" views in PostgreSQL. Together with the default table-level / view-level permissions in Supabase schema public this means that all users, even anonymous ones, can delete records from these views, leading to the deletion of records in the underlaying tables.  
                    To fix this, one has to remove the INSERT and DELETE privileges from the view. This is a change to the default Supabase permissions that would ideally not be necessary.  
                    There is an alternative solution, but it is not very practical: you can create the views with `security_invoker = on` to reuse the RLS policies of the underlaying table. Then use these RLS policies to prevent record deletion. However, they have to allow SELECT and UPDATE; so unless you move the underlaying table to a schema not exposed by API, it would allow users to circumvent the column-level security for which the views were created.
                    
                *   **Disadvantage: No good way to restrict the use of certain** _**values**_ **in a column to certain users.** This is because views cannot have their own RLS policies. There are several ways to work around this:
                    
                    *   Probably the best way to work around that is to structure tables so that a user with write access to a column is allowed to use every value in that column. For example, instead of columns `role` (user, admin) and `status` (applied, approved, disapproved), there would be nullable boolean columns `user_application`, `admin_application`, `user_status`, `admin_status`.
                        
                    *   Another option, for complex cases, is to move the underlying table to a custom schema that is not API accessible (while still granting USAGE and permissions to all Supabase roles; [see](https://stackoverflow.com/a/73282539)), to create RLS policies on that underlying table, and to re-use them in the views via `security_invoker = on`.
                        
                    *   Another option, also for complex cases, is to use triggers on the view or the underlaying table.
                        
            *   **Use column-level access rights.** "You can provide UPDATE access to only a subset of columns of the table: GRANT UPDATE(col1, col2). ([details](https://stackoverflow.com/a/3281750))" ([source](https://dba.stackexchange.com/a/323514)). Reportedly, it is a hassle to maintain all these access rights. And it would not be applicable in Supabase to differentiate between different _authenticated_ users, as them all share the same role ("user") `authenticated` in Supabase. (PostgREST could offer different options for this.)
                
            *   **Use table splitting.** Compared to views, this splits the main table into multiple parts. Using RLS policies, it is defined who can do what with each partial table; and, different from views where you can only partially emulate RLS policies in a WHERE clause, a RLS policy can also be used to limit which values a user can use for a column. To use them together, they have to be joined in requests. Quite ok when splitting a table in two. But sometimes the splitting is almost "one table per column", for example for permission management tables with one column per role. This is bad because it "atomizes" the data rather than keeping it in a proper normal form, meaning that the data is not even accessible to admins in a comfortable way.
                
        *   **Collect profile information on signup but manage it in an own table.** Supabase provides a column `auth.users.raw_user_meta_data` that can be filled on signup with additional user profile data. However, it should not be retrieved from there: recommended practice in Supabase is to keep a copy of key user information in an own profile / users table in the `public` schema and to sync it with the `auth.users` table via triggers ([source](https://github.com/supabase/supabase/discussions/6363#discussioncomment-2527443)). For column `raw_user_meta_data`, the syncing technique is demonstrated [here](https://database.dev/handle-new-user), with more info [here](https://github.com/supabase/supabase/discussions/6363#discussioncomment-3321211). Repeated and no two-way syncing is needed for this field: the `raw_user_meta_data` column should be understood as providing the initial profile information only once at signup time, and after that, the `public.profile` (or related) table will be the authoritative source of profile information.
            
    *   **How to migrate from a supabase.com hosted project to a self-hosted project?**
        
        *   You can probably use the same instructions for [Migrating and Upgrading Projects](https://supabase.com/docs/guides/platform/migrating-and-upgrading-projects).
            
        *   Migrating the S3 storage objects may or may not work according to the instructions linked above. If not, they can however be downloaded and included in a self-hosted S3 compatible object storage.
            
    *   **How to set a password for an invited user in the Supabase API?**
        
        *   Visit the invite link and copy the URL you are forwarded to afterwards. It will have a format similar to the following:
            
            *   http://admin.climategains.org/login#access\_token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiJhdXRoZW50aWNhdGVkIiwiZXhwIjoxNjc1Nzk4Nzg3LCJzdWIiOiI1NDVhMDUxZC1kZDNhLTRmZGMtOGE0OS03NTNkMzQ2NmY1N2UiLCJlbWFpbCI6ImNnLWFwaS10ZXN0dXNlci0xQGdyci5sYSIsInBob25lIjoiIiwiYXBwX21ldGFkYXRhIjp7InByb3ZpZGVyIjoiZW1haWwiLCJwcm92aWRlcnMiOlsiZW1haWwiXX0sInVzZXJfbWV0YWRhdGEiOnt9LCJyb2xlIjoiYXV0aGVudGljYXRlZCIsImFhbCI6ImFhbDEiLCJhbXIiOlt7Im1ldGhvZCI6Im90cCIsInRpbWVzdGFtcCI6MTY3NTc5NTE4N31dLCJzZXNzaW9uX2lkIjoiZTAwNWY3ZTYtN2MyMi00MjA4LTlkNDYtYjhmZjI1ZWQwZDAwIn0.bf44PCiaqSQfI8U9n\_bvA7fwEEAhDQtjj97aTls\_8PI&expires\_in=3600&refresh\_token=cyfTgyXS0QaP2FjwN-303g&token\_type=bearer&type=invite
                
        *   Extract the `access_token` value from the URL.
            
        *   To set the password, make an API call such as the following, using the extracted `access_token` value (which will also be used to identify the user):
            
            *       curl -X PUT 'https://uvjqnxkfzenbljxcutbx.supabase.co/auth/v1/user' \
                      -H "apikey: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InV2anFueGtmemVuYmxqeGN1dGJ4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2NzUwOTc2NTksImV4cCI6MTk5MDY3MzY1OX0.sUZbGWQ7kUilpQWYp6rcdxS7J4dSq_6y3MhTHcw8Ic4" \
                      -H "Authorization: Bearer access-token-here" \
                      -H "Content-Type: application/json" \
                      -d '{ "password": "your-chosen-password" }'
                
        *   Whenever you want to log in, to get a new access token, make an API call such as the following, using the user's e-mail address and password:
            
            *       curl -X POST 'https://uvjqnxkfzenbljxcutbx.supabase.co/auth/v1/token?grant_type=password' \
                      -H "apikey: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InV2anFueGtmemVuYmxqeGN1dGJ4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2NzUwOTc2NTksImV4cCI6MTk5MDY3MzY1OX0.sUZbGWQ7kUilpQWYp6rcdxS7J4dSq_6y3MhTHcw8Ic4" \
                      -H "Content-Type: application/json" \
                      -d '{
                        "email": "cg-api-testuser-1@grr.la",
                        "password": "your-chosen-password"
                      }'
                
    *   **How to fix that comments and indentation is lost in RLS policies?**
        
        *   This is a [known issue](https://github.com/supabase/supabase/issues/12443) in Supabase.
            
        *   Workaround: move the code to a single function call. Indentation and comments are preserved in functions.
            
*   **Swagger**
    
    *   **How to use Swagger API docs offline?**
        
        *   You can simply save the API docs page using the SingleFile browser extension. It seems to work that way, and will not issue any requests to a server when using this saved version later (checked with Forefox Inspector).
