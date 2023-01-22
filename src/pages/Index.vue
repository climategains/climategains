<script setup lang="ts">
import { reactive, ref } from 'vue';
import OppView from 'core/OppView.vue';
import AboutComponent from 'components/about/AboutComponent.vue';

import { storeToRefs } from 'pinia';

import { IonButton, IonModal, IonButtons, IonCard, IonCardHeader, IonCardSubtitle, IonCardContent } from '@ionic/vue';

import useStore from '../stores/main';

import { useRouter } from 'vue-router';

const router = useRouter();
const date = new Date().toLocaleDateString('en-uk', {
	weekday: 'long',
	year: 'numeric',
	month: 'long',
	day: 'numeric'
});

const modalIsOpen = ref(false);
const showModal = () => {
	modalIsOpen.value = true;
};
</script>

<template>
	<opp-view>
		<template #default-view-title>
			<div class="text-center">Start</div>
		</template>
		<template #default-view-body>
			<div class="h-full absolute top-0 w-full overflow-hidden">
				<img class="w-full top-60 absolute h-full" src="../assets/3.jpg" />

				<div class="login_menu" @click="() => router.push('../account')">
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
				<div class="mt-20 pl-1 shadow-none bg-white/0 text-black w-full mx-auto">
					<ion-card-header>
						<ion-card-subtitle class="text-white text-2xl capitalize font-light border-white/30">{{
							date
						}}</ion-card-subtitle>
						<ion-card-title class="text-white text-2xl">Welcome to Climate Gains</ion-card-title>
					</ion-card-header>
				</div>

				<div class="actions flex mx-auto flex-col">
					<div
						class="bg-black/20 py-3 px-6 text-white inline-block w-full border-white/20 border-b"
						@click="() => router.push('../activist')">
						<h3 class="mt-0 mb-2 flex items-center">
							Create a Climate Action
							<svg
								xmlns="http://www.w3.org/2000/svg"
								fill="none"
								viewBox="0 0 24 24"
								stroke-width="1.5"
								stroke="currentColor"
								class="w-6 h-6 ml-2">
								<path
									stroke-linecap="round"
									stroke-linejoin="round"
									d="M12.75 15l3-3m0 0l-3-3m3 3h-7.5M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
							</svg>
						</h3>
						<p class="my-0 pr-4">View climate opportunities and start your own community based climate action.</p>
					</div>
					<div class="bg-black/20 py-3 px-6 text-white inline-block w-full" @click="() => router.push('../validator')">
						<h3 class="mt-0 mb-2 flex items-center">
							Validate a Climate Action
							<svg
								xmlns="http://www.w3.org/2000/svg"
								fill="none"
								viewBox="0 0 24 24"
								stroke-width="1.5"
								stroke="currentColor"
								class="w-6 h-6 ml-2">
								<path
									stroke-linecap="round"
									stroke-linejoin="round"
									d="M12.75 15l3-3m0 0l-3-3m3 3h-7.5M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
							</svg>
						</h3>
						<p class="my-0 pr-10">
							Become a community validator by verifying existing climate actions and earning rewards.
						</p>
					</div>
				</div>
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
	@apply absolute py-2 px-4 text-white text-lg top-2 right-2 flex w-full justify-end items-center;
	font-weight: 500;
	backdrop-filter: blur(10px);
}
.actions {
	-webkit-backdrop-filter: blur(20px);
	backdrop-filter: blur(10px);

	@apply relative mx-auto w-full inline-block;
	width: 100%;
}
.action_button {
	@apply py-5 bg-black/20 font-bold text-white w-full border-white/20 border-b text-center font-bold  text-xl;
}

.action_button:last-child {
	@apply border-b;
}
</style>
