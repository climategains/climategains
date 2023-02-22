<script setup lang="ts">
import { reactive, ref } from 'vue';

import { IonButton, IonModal, IonButtons, IonCard, IonCardHeader, IonCardSubtitle, IonCardContent } from '@ionic/vue';

import useStore from '../stores/main';

import { useRouter } from 'vue-router';

const router = useRouter();
const store = useStore();

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
	<tab-view>
		<template #default-view-title>
			<div class="text-center">Start</div>
		</template>
		<template #default-view-body>
			<div class="h-full absolute top-0 w-full overflow-hidden">
				<img class="w-full top-60 absolute h-full" src="../assets/3.jpg" />
				<div class="w-full mt-4 flex items-center justify-between" @click="() => router.push('../account')">
					<img class="ml-4" style="height: 31px" src="../assets/logo_white_alt.png" />
					<div class="flex text-lg font-bold items-center mr-6">
						<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor" class="w-6 h-6 mr-2">
							<path
								fill-rule="evenodd"
								d="M18.685 19.097A9.723 9.723 0 0021.75 12c0-5.385-4.365-9.75-9.75-9.75S2.25 6.615 2.25 12a9.723 9.723 0 003.065 7.097A9.716 9.716 0 0012 21.75a9.716 9.716 0 006.685-2.653zm-12.54-1.285A7.486 7.486 0 0112 15a7.486 7.486 0 015.855 2.812A8.224 8.224 0 0112 20.25a8.224 8.224 0 01-5.855-2.438zM15.75 9a3.75 3.75 0 11-7.5 0 3.75 3.75 0 017.5 0z"
								clip-rule="evenodd" />
						</svg>

						Sign In
					</div>
				</div>
				<div class="mt-20 pl-2 shadow-none bg-white/0 text-black w-full mx-auto">
					<ion-card-header>
						<ion-card-subtitle class="text-white text-2xl capitalize font-light border-white/30">{{
							date
						}}</ion-card-subtitle>
					</ion-card-header>
				</div>

				<div class="actions flex mx-auto flex-col">
					<div
						class="bg-black/20 py-3 px-6 text-white inline-block w-full border-white/20 border-b"
						@click="() => router.push('../guide/activist')">
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
					<div
						class="bg-black/20 py-3 px-6 text-white inline-block w-full"
						@click="() => router.push('../guide/validator')">
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
	</tab-view>
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
