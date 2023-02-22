<script setup lang="ts">
import { ref, reactive, watch } from 'vue';
import '@splidejs/vue-splide/css';
import { Splide, SplideSlide } from '@splidejs/vue-splide';

import useStore from '@/store';

import { IonModal } from '@ionic/vue';
import { useRouter } from 'vue-router';

import { supabase } from '@/helpers/api';

import createAccount from './create.vue';

const router = useRouter();
const store = useStore();
const splide = ref();

const props = defineProps(['callback']);
const emit = defineEmits(['modal-cancel']);

const modalIsOpen = ref(false);
const showModal = () => {
	modalIsOpen.value = true;
};

const accountState = ref('index');

const state = reactive({
	email: '',
	password: ''
});

function changeState(value) {
	accountState.value = value;
	splide.value.go(1);
}

function goTo(value) {
	splide.value.go(value);
}

async function login() {
	try {
		const { data, error } = await supabase.auth.signInWithPassword({
			email: state.email,
			password: state.password
		});
		if (error) throw error;
		store.fetchUsers();
		store.user.account = data.user;
		store.user.session = data.session;
		store.isAuthenticated = true;
	} catch (error) {
		window.alert(error.error_description || error.message);
	}
}

watch(
	() => store.isAuthenticated,
	newValue => {
		if (props.callback) {
			router.push(`${props.callback}`);
			emit('modal-cancel', true);
		}
	}
);
</script>

<template>
	<div class="flex items-start flex-col justify-start">
		<Splide ref="splide" class="w-full" :options="{ autoHeight: true, arrows: false, pagination: false, drag: false }">
			<SplideSlide class="slide w-full">
				<div class="w-full">
					<div class="button_el w-full border-b text-center py-3 border-white/20" @click="changeState('login')">
						<svg
							xmlns="http://www.w3.org/2000/svg"
							fill="none"
							viewBox="0 0 24 24"
							stroke-width="1.5"
							stroke="currentColor"
							class="w-6 h-6">
							<path
								stroke-linecap="round"
								stroke-linejoin="round"
								d="M15.75 9V5.25A2.25 2.25 0 0013.5 3h-6a2.25 2.25 0 00-2.25 2.25v13.5A2.25 2.25 0 007.5 21h6a2.25 2.25 0 002.25-2.25V15m3 0l3-3m0 0l-3-3m3 3H9" />
						</svg>
						Sign In
					</div>
					<div class="button_el" @click="showModal()">
						<svg
							xmlns="http://www.w3.org/2000/svg"
							fill="none"
							viewBox="0 0 24 24"
							stroke-width="1.5"
							stroke="currentColor"
							class="w-6 h-6">
							<path
								stroke-linecap="round"
								stroke-linejoin="round"
								d="M19 7.5v3m0 0v3m0-3h3m-3 0h-3m-2.25-4.125a3.375 3.375 0 11-6.75 0 3.375 3.375 0 016.75 0zM4 19.235v-.11a6.375 6.375 0 0112.75 0v.109A12.318 12.318 0 0110.374 21c-2.331 0-4.512-.645-6.374-1.766z" />
						</svg>
						Create Account
					</div>
				</div>
			</SplideSlide>
			<SplideSlide class="slide">
				<div @click="goTo(0)" class="text-left font-light border-b flex items-center border-white/70 py-3 mb-1 text-lg">
					<svg
						xmlns="http://www.w3.org/2000/svg"
						fill="none"
						viewBox="0 0 24 24"
						stroke-width="1.5"
						stroke="currentColor"
						class="w-4 h-4 mr-2">
						<path stroke-linecap="round" stroke-linejoin="round" d="M10.5 19.5L3 12m0 0l7.5-7.5M3 12h18" />
					</svg>
					Go Back
				</div>
				<div class="flex flex-col" v-show="accountState === 'login'">
					<input class="" placeholder="Your Email" v-model="state.email" />
					<input placeholder="Your Password" v-model="state.password" type="password" />
					<div
						class="bg-blue-500 text-center py-3 text-center flex items-center justify-center w-full rounded-full font-bold mt-3"
						@click="login()">
						Login
					</div>
				</div>
			</SplideSlide>
		</Splide>
	</div>
	<ion-modal :is-open="modalIsOpen" @did-dismiss="modalIsOpen = false">
		<ion-header>
			<ion-toolbar>
				<ion-buttons slot="start">
					<div class="pl-4 flex items-center text-xl" @click="modalIsOpen = false">
						<svg
							xmlns="http://www.w3.org/2000/svg"
							fill="none"
							viewBox="0 0 24 24"
							stroke-width="3"
							stroke="currentColor"
							class="w-5 h-5 mr-8">
							<path stroke-linecap="round" stroke-linejoin="round" d="M10.5 19.5L3 12m0 0l7.5-7.5M3 12h18" />
						</svg>
						Back
					</div>
				</ion-buttons>
			</ion-toolbar>
		</ion-header>

		<div class="inline-block bg-blue/10 px-10">
			<createAccount />
		</div>
	</ion-modal>
</template>
<style scoped>
.button_el {
	@apply py-4 text-xl items-center flex w-full;
}

input {
	@apply py-3  text-lg text-white border-none;
	outline: none;
	background: none !important;
	border-bottom: 1px solid rgba(255, 255, 255, 0.3);
}
.button_el svg {
	@apply mr-2;
}

.slide {
	width: 100%;
}
</style>
