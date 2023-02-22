import { createClient } from '@supabase/supabase-js';

const supabaseUrl = import.meta.env.VITE_SUPABASE_URL;
const supabaseAnonKey = import.meta.env.VITE_SUPABASE_ANON_KEY;

const supabase = createClient(supabaseUrl, supabaseAnonKey);

async function apiSelect(table, filter, query) {
	try {
        if (filter !== undefined) {
            var { data, error, status } = await supabase.from(table).select('*').eq(filter, query);
        } else {
            var { data, error, status } = await supabase.from(table).select('*');
        }
	} catch (error) {
		alert(error.message);
	} finally {
        if (error && status !== 406) throw error;
        console.log(data)

		if (data) return data;
      }
}

async function apiSignUp(payload) {
	try {
        var { data: user, error } = await supabase.auth.signUp({ 
            email: payload.email, 
            password: payload.password, 
            options: { 
              data: { 
                fullname: payload.firstname + " " + payload.lastname,
                organization: payload.organization,
                ui_language: 'en'
              }
            }
          })
	} catch (error) {
		alert(error);
	} finally {
        if (error) return error;
		if (user) return user;
    }
}



async function getResponse(id) {
    return apiSelect('response', 'step_id', id)
}



async function getStep(id) {
    return apiSelect('step', 'id', id)
}

async function getStepsFromProjectId(id) {
    return apiSelect('step', 'project_id', id)
}

export { 
    supabase,
    apiSignUp,
    getResponse,
    getStep,
    getStepsFromProjectId
};