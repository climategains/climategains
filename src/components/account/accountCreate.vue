<script setup lang="ts">
import { useRouter } from 'vue-router';
import { ref, reactive } from 'vue';
import { alertController } from '@ionic/vue';

import '@splidejs/vue-splide/css';
import { Splide, SplideSlide } from '@splidejs/vue-splide';

const splide = ref();

const router = useRouter();
const resp = ref(null);
const presentAlert = async () => {
	const alert = await alertController.create({
		header: 'We are missing some information',
		message: resp.value.message,
		buttons: ['OK']
	});

	await alert.present();
};

const state = reactive({
	company: '',
	title: 'string',
	firstname: '',
	lastname: '',
	email: '',
	role: 'developer',
	mobile: '',
	password: '',
	timezone: '',
	language: 'en'
});

state.timezone = Intl.DateTimeFormat().resolvedOptions().timeZone;

function submit() {
	fetch('https://api.climategains.org/api/v1/auth/signup', {
		method: 'POST',
		headers: {
			'x-api-key': 'rpA94jzJjrBh9IclvNKvM34xhHwo282g7qZ6mJ0sKITOBy39',
			'Content-Type': 'application/json; charset=utf-8'
		},
		body: `${JSON.stringify(state)}`
	})
		.then(res => res.json())
		.then(response => {
			resp.value = response;
			if (response.statusCode == '400') {
				presentAlert();
			}
			if (response.statusCode == '201') {
				splide.value.go(1);
			}
		});
}
</script>

<template>
	<ion-content class="px-2 text-center">
		<h1>Create your account</h1>
		<!-- <p class="w-2/3 inline-block">{{ resp.statusCode == '201' }}</p> -->
		<Splide ref="splide" class="w-full" :options="{ autoHeight: true, arrows: false, pagination: false, drag: false }">
			<SplideSlide class="slide w-full">
				<div class="flex flex-col px-10">
					<input placeholder="Your First Name" v-model="state.firstname" />
					<input placeholder="Your Last Name" v-model="state.lastname" />
					<div class="w-full text-left">
						<input id="mobile" class="w-full" placeholder="Your Mobile Number" v-model="state.mobile" />
						<label for="mobile" class="text-xs text-left text-white/60"
							>Please include your country code in the format +XX</label
						>
					</div>
					<input placeholder="Your Email" v-model="state.email" />
					<div class="w-full text-left">
						<input class="w-full" id="password" v-model="state.password" placeholder="Your Password" type="password" />
						<label for="password" class="text-xs text-left text-white/60">
							Your password must be alphanumeric and contain uppercase and lowercase letters.
						</label>
					</div>
					<input v-model="state.company" placeholder="Your Company" />

					<div @click="submit()" class="bg-blue-500 p-2 rounded-full font-bold mt-3 py-2">Sign Up</div>
				</div>
			</SplideSlide>
			<SplideSlide class="slide w-full"
				><div class="px-10">
					<h1 class="text-xl font-bold bg-green-500/20 p-4 rounded-xl">Welcome onboard!</h1>
					<p class="text-xl">In order to use your account you must check your inbox for a confirmation email.</p>
					<p class="text-xl">Once confirmed you can log in to the application.</p>
				</div></SplideSlide
			>
		</Splide>
	</ion-content>
</template>
<style scoped>
input {
	@apply py-3 bg-black text-lg text-white border-none;
	outline: none;
	border-bottom: 1px solid rgba(255, 255, 255, 0.3);
}
</style>
