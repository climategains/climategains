<script setup lang="ts">
import { useRouter } from 'vue-router';
import { ref, reactive } from 'vue';
import { alertController } from '@ionic/vue';
import { apiSignUp } from '@/helpers/api';

import '@splidejs/vue-splide/css';
import { Splide, SplideSlide } from '@splidejs/vue-splide';

const splide = ref();
const error = ref();
const router = useRouter();

async function presentAlert(values) {
	const alert = await alertController.create({
		header: 'We are missing some information',
		message: values,
		buttons: ['OK']
	});

	await alert.present();
}

const state = reactive({
	organization: '',
	firstname: '',
	lastname: '',
	email: '',
	role: 'developer',
	password: '',
	timezone: '',
	language: 'en'
});

state.timezone = Intl.DateTimeFormat().resolvedOptions().timeZone;

async function submit() {
	const user = JSON.parse(JSON.stringify(state));
	if (!user.email || !user.firstname || !user.lastname) {
		presentAlert('Please complete all required fields to sign up');
	} else {
		var response = await apiSignUp(user);
	}

	if (response.user) {
		splide.value.go(1);
	} else {
		presentAlert(response);
	}
}
</script>

<template>
	<div class="account_create">
		<h1 class="mb-2">Create your account</h1>
		{{ error }}
		<Splide ref="splide" class="w-full" :options="{ autoHeight: true, arrows: false, pagination: false, drag: false }">
			<SplideSlide class="slide w-full">
				<div class="flex flex-col">
					<input placeholder="Your First Name" v-model="state.firstname" />
					<input placeholder="Your Last Name" v-model="state.lastname" />

					<input placeholder="Your Email" v-model="state.email" />
					<div class="w-full text-left">
						<input class="w-full" id="password" v-model="state.password" placeholder="Your Password" type="password" />
						<label for="password" class="text-xs text-left text-white/60">
							Your password must be alphanumeric and contain uppercase and lowercase letters.
						</label>
					</div>
					<input v-model="state.organization" placeholder="Your Organization / Company" />

					<div @click="submit()" class="bg-blue-500 p-3 mx-10 text-center rounded-full font-bold mt-3">Sign Up</div>
				</div>
			</SplideSlide>
			<SplideSlide class="slide w-full"
				><div>
					<h1 class="text-xl font-bold bg-green-500/20 p-4 rounded-xl">Welcome onboard!</h1>
					<p class="text-xl">In order to use your account you must check your inbox for a confirmation email.</p>
					<p class="text-xl">Once confirmed you can log in to the application.</p>
				</div></SplideSlide
			>
		</Splide>
	</div>
</template>
<style scoped>
input {
	@apply py-3  text-lg text-white border-none;
	outline: none;
	background: none;
	border-bottom: 1px solid rgba(255, 255, 255, 0.3);
}
.account_create {
	font-family: Helvetica, sans-serif;
	@apply mb-10;
}
</style>
