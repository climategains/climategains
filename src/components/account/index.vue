<script setup lang="ts">
import { ref, reactive } from 'vue';
import '@splidejs/vue-splide/css';
import { Splide, SplideSlide } from '@splidejs/vue-splide';

import useStore from '../../stores/main';
import { storeToRefs } from 'pinia';

import { IonButton, IonModal } from '@ionic/vue';
import { useRouter } from 'vue-router';

import createAccount from './accountCreate.vue';

const router = useRouter();

const props = defineProps(['callback']);
const emit = defineEmits(['modal-cancel']);
const modalIsOpen = ref(false);
const showModal = () => {
	modalIsOpen.value = true;
};
const accountState = ref('index');
const splide = ref();
const store = useStore();

function changeState(value) {
	accountState.value = value;
	splide.value.go(1);
}

function goTo(value) {
	splide.value.go(value);
}

const state = reactive({
	email: null,
	password: null,
	tokenId: null,
	user: null
});

function getProjects() {
	fetch('https://api.climategains.org/api/v1/projects', {
		method: 'GET',
		headers: {
			authorization: `Bearer ${store.token}`,
			'x-api-key': 'rpA94jzJjrBh9IclvNKvM34xhHwo282g7qZ6mJ0sKITOBy39',
			'Content-Type': 'application/json; charset=utf-8'
		}
	})
		.then(res => res.json())
		.then(response => {
			store.projects = response;
		});
}

function authUser(token) {
	fetch('https://api.climategains.org/api/v1/auth/authenticate', {
		method: 'POST',
		headers: {
			authorization: `Bearer ${token}`,
			'x-api-key': 'rpA94jzJjrBh9IclvNKvM34xhHwo282g7qZ6mJ0sKITOBy39',
			'Content-Type': 'application/json'
		},
		body: '{ "otp": "123456" }'
	})
		.then(res => res.json())
		.then(response => {
			store.token = token;
			store.user = response;
			getProjects();

			if (props.callback) {
				router.push(`../${props.callback}`);
				emit('modal-cancel', true);
			}
		});
}

function login() {
	fetch('https://api.climategains.org/api/v1/auth/login', {
		method: 'POST',
		headers: {
			'x-api-key': 'rpA94jzJjrBh9IclvNKvM34xhHwo282g7qZ6mJ0sKITOBy39',
			'Content-Type': 'application/json; charset=utf-8'
		},
		body: `{"email":"${state.email}","password":"${state.password}"}`
	}).then(response => {
		state.tokenId = response.headers.get('x-token-id');
		authUser(state.tokenId);
	});
}
</script>

<template>
	<ion-content class="px-2 text-center">
		<div class="flex items-start flex-col justify-start px-10 mt-10">
			<h1 class="text-3xl text-left mb-0">Welcome To Climate Gains</h1>
			<p class="text-left text-xl">
				In order to go further you'll need to create an account or login to your existing account.
			</p>
			<Splide
				ref="splide"
				class="w-full"
				:options="{ autoHeight: true, arrows: false, pagination: false, drag: false }">
				<SplideSlide class="slide w-full">
					<div class="w-full">
						<div class="button_el w-full border-b border-white/20" @click="changeState('login')">
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
					<div
						@click="goTo(0)"
						class="text-left font-light border-b flex items-center border-white/70 py-3 mb-1 text-lg">
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
						<div class="bg-blue-500 p-2 rounded-full font-bold mt-3 py-2" @click="login()">Login</div>
					</div>
				</SplideSlide>
			</Splide>
		</div>
		<ion-modal :is-open="modalIsOpen" @did-dismiss="modalIsOpen = false"> <createAccount /> </ion-modal>
	</ion-content>
</template>
<style scoped>
.button_el {
	@apply py-4 text-xl items-center flex w-full;
}

input {
	@apply py-3 bg-black text-lg text-white border-none;
	outline: none;
	border-bottom: 1px solid rgba(255, 255, 255, 0.3);
}
.button_el svg {
	@apply mr-2;
}

.slide {
	width: 100%;
}
</style>
