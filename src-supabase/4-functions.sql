--
-- Project-defined functions
-- Including their use as triggers in tables.
--

CREATE OR REPLACE FUNCTION public.can_implement(my_project_id bigint) RETURNS boolean 
    LANGUAGE plpgsql AS 
$$BEGIN
    SELECT EXISTS (
        SELECT role.user_id
        FROM project
            JOIN role ON project.id = role.project_id
        WHERE 
            project.id = my_project_id AND 
            (role.manager OR role.activist) AND 
            role.user_id = auth.uid()
    );
END;$$;


CREATE OR REPLACE FUNCTION public.can_pay(my_project_id bigint) RETURNS boolean
    LANGUAGE plpgsql AS 
$$BEGIN
    /* Determine if the current user should be able to edit payment 
     * information for a project step. Allowed only if the user is a 
     * manager of the project's programme. */
    SELECT EXISTS (
        SELECT role.user_id
        FROM project
            JOIN programme on project.programme_id = programme.id
            JOIN role ON programme.id = role.programme_id
        WHERE 
            project.id = my_project_id AND 
            role.manager AND 
            role.user_id = auth.uid()
    );
END;$$;


CREATE OR REPLACE FUNCTION public.can_validate(my_project_id bigint) RETURNS boolean
    LANGUAGE plpgsql AS
$$BEGIN
    SELECT EXISTS (
        SELECT role.user_id
        FROM project
            JOIN role ON project.id = role.project_id
        WHERE 
            project.id = my_project_id AND 
            role.validator AND 
            role.user_id = auth.uid()
    -- TODO: Extend this implementation so that validators of the project's programme are also 
    -- considered as able to validate the project. Then adapt the COMMENT on view step_for_validation
    -- accordingly.
    );
END;$$;


CREATE OR REPLACE FUNCTION public.insert_project_mgr() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER AS 
$$BEGIN
    /* AFTER INSERT trigger for table project */
    /* Creates a manager role for the user who created the project.*/
    /* Privileged function, protect from direct execution. See:
    *  https://dba.stackexchange.com/a/264001 
    *  https://stackoverflow.com/a/72140046 */
    INSERT 
        INTO public.role ("project_id", "user_id", "manager")
        VALUES (NEW.id, auth.uid(), true);
    RETURN NEW;
END;$$;

CREATE OR REPLACE TRIGGER insert_project_mgr AFTER INSERT ON public.project 
    FOR EACH ROW EXECUTE FUNCTION public.insert_project_mgr();


CREATE OR REPLACE FUNCTION public.project_for_response(my_response_id bigint) RETURNS bigint
    LANGUAGE plpgsql AS
$$BEGIN
    SELECT step.project_id
        FROM response JOIN step ON step.id = response.step_id
        WHERE response.id = my_response_id;
END;$$;
