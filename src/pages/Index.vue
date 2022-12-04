<script setup lang="ts">
import { reactive } from 'vue';
import OppView from 'core/OppView.vue';

import { storeToRefs } from 'pinia';

import { IonButton, IonCard, IonCardHeader, IonCardSubtitle, IonCardContent } from '@ionic/vue';

import useStore from '../stores/main';

import { useRouter } from 'vue-router';

const router = useRouter();
const date = new Date().toLocaleDateString('en-uk', {
	weekday: 'long',
	year: 'numeric',
	month: 'long',
	day: 'numeric'
});
</script>

<template>
	<opp-view>
		<template #default-view-title>
			<div class="text-center">Start</div>
		</template>
		<template #default-view-body>
			<video autoplay muted loop width="320" height="240" class="opacity-90">
				<source src="./video.mp4" type="video/mp4" />
			</video>
			<div class="login_menu">
				<svg
					xmlns="http://www.w3.org/2000/svg"
					fill="none"
					viewBox="0 0 24 24"
					stroke-width="1"
					stroke="currentColor"
					class="w-7 h-7 mr-2">
					<path
						stroke-linecap="round"
						stroke-linejoin="round"
						d="M17.982 18.725A7.488 7.488 0 0012 15.75a7.488 7.488 0 00-5.982 2.975m11.963 0a9 9 0 10-11.963 0m11.963 0A8.966 8.966 0 0112 21a8.966 8.966 0 01-5.982-2.275M15 9.75a3 3 0 11-6 0 3 3 0 016 0z" />
				</svg>
				Sign In
			</div>
			<div class="row welcome-page">
				<ion-card class="shadow-none bg-white/0 text-black w-full mx-auto">
					<ion-card-header>
						<ion-card-subtitle class="text-white text-2xl capitalize border-b font-light border-white/30 pb-3 mb-3">{{
							date
						}}</ion-card-subtitle>
						<ion-card-title class="text-white text-3xl">Welcome to Climate Gains</ion-card-title>
					</ion-card-header>
				</ion-card>

				<ion-card class="shadow-none bg-black/0 text-white w-full mx-auto">
					<div class="actions">
						<div class="action_button" @click="() => router.push('../intro')">I want to complete a climate action</div>
						<div class="action_button" @click="() => router.push('../intro')">I want to verify an action</div>
						<div class="action_button" @click="() => router.push('../intro')">I want to become a supplier</div>
					</div>
				</ion-card>
			</div>
		</template>
	</opp-view>
</template>

<style scoped>
video {
	height: 100vh;
	object-fit: cover;
	width: 100%;
	height: 100%;
	display: inline-block;
	position: absolute;
	top: 0;
}

.login_menu {
	@apply absolute py-2 px-4 text-white text-lg top-0 right-0 flex w-full justify-end items-center bg-white/10;
	font-weight: 500;
	-webkit-backdrop-filter: blur(10px);
	backdrop-filter: blur(10px);
}
.actions {
	width: 100%;
	-webkit-backdrop-filter: blur(20px);
	backdrop-filter: blur(10px);
}
.action_button {
	@apply py-5 bg-white/10 font-bold text-white w-full border-white/20 border-t text-center font-bold  text-xl capitalize;
}

.action_button:last-child {
	@apply border-b;
}
</style>
