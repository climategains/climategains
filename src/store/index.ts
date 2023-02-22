import { defineStore } from 'pinia';
import { supabase } from '@/helpers/api';

const envkey = import.meta.env.VITE_SUPABASE_URL;
const useStore = defineStore('account', {
	state: () => ({
		key: envkey,
		global: {
			users: null,
			steps: null,
			media: null,
			actions: null,
			programmes: null,
			projects: [],
			questions: null,
			roles: null
		},
		user: {
			account: null,
			session: null
		},
		isAuthenticated: false,
		token: null,
		project: { steps: null },
		projects: null,
		role: 'activist'
	}),
	actions: {
		async initializeApp() {
			this.fetchProgrammes();
			this.fetchProjects();
			this.fetchSteps();
			this.fetchUsers();
			this.fetchQuestions();
			this.fetchMedia();
		},
		async fetchUsers() {
			let { data: profile, error } = await supabase.from('profile').select('*');
			this.global.users = profile;
		},
		async fetchProgrammes() {
			let { data: programme, error } = await supabase.from('programme').select('*');
			this.global.programmes = programme;
		},
		async fetchProjects() {
			let { data: project, error } = await supabase.from('project').select('*');
			this.global.projects = project;
		},
		async fetchQuestions() {
			let { data: programme_response, error } = await supabase.from('programme_response').select('*');
			this.global.questions = programme_response;
		},
		async fetchSteps() {
			let { data: programme_step, error } = await supabase.from('programme_step').select('*');
			this.global.steps = programme_step;
		},
		async fetchMedia() {
			let { data: medium, error } = await supabase.from('medium').select('*');
			this.global.media = medium;
		},
		async fetchRoles() {
			let { data: role, error } = await supabase.from('role').select('*');
			this.global.roles = role;
		},
		async fetchProfiles() {
			let { data: profile_for_all, error } = await supabase.from('profile_for_all').eq('id', id);
			this.global.profiles = profile;
		}
	},
	getters: {
		getProgramme: state => id => {
			return state.global.programmes.filter(x => x.id == id)[0];
		},
		getProject: state => id => {
			return state.global.projects.filter(x => x.id == id)[0];
		},
		getMedia() {
			return id => this.global.media.filter(x => x.programme_id === id);
		},
		getSteps() {
			return id => this.global.steps.filter(x => x.programme_id === id);
		},
		getQuestion() {
			return id => this.global.questions.filter(x => x.id === id);
		},
		getProgrammeQuestions() {
			return id => this.global.questions.filter(x => x.programme_step_id === id);
		},
		getPoster() {
			return id => this.getMedia(id).filter(x => x.role === 'poster')[0];
		},
		getVideo() {
			return id => this.getMedia(id).filter(x => x.role === 'video')[0];
		},
		getGallery() {
			return id => this.getMedia(id).filter(x => x.role === 'gallery_picture');
		},
		getUser() {
			return id => this.global.users.filter(x => x.id === id);
		},
		getUserRoles() {
			return id => this.global.roles.filter(x => x.user_id === id);
		},
		getIncome() {
			return id =>
				this.getSteps(id)
					.map(x => x.funding_amount)
					.reduce((total, item) => total + item);
		},
		getWorktime() {
			return id =>
				this.getSteps(id)
					.map(x => x.worktime)
					.reduce((total, item) => total + item);
		},
		getCurrency() {
			return id => this.getSteps(id)[0].funding_currency;
		}
	}
});

export default useStore;
