<script setup lang="ts">
import { ref, reactive, onMounted } from 'vue';
import { IonModal, IonButtons, IonButton, IonHeader, IonToolbar } from '@ionic/vue';

import '@splidejs/vue-splide/css';

import { Splide, SplideSlide } from '@splidejs/vue-splide';
import { useRouter, useRoute } from 'vue-router';

import accountView from '../../../components/account/index.vue';

import useStore from '../../../stores/main';

const store = useStore();

const modalIsOpen = ref(false);
const showModal = () => {
	modalIsOpen.value = true;
};

const router = useRouter();
const route = useRoute();

const programme = store.getProgramme(route.params.slug);

function getFunds(steps) {
	return steps.map(x => x.prefunding).reduce((s, v) => s + (v || 0), 0);
}

function getHours(steps) {
	return steps.map(x => x.worktime).reduce((s, v) => s + (v || 0), 0);
}

var getCountry = new Intl.DisplayNames(['en'], { type: 'region' });

function signup() {
	if (store.isAuthenticated) {
		router.push(`/apply/record/${programme.id}`);
	} else {
		modalIsOpen.value = true;
	}
}
</script>
<template>
	<base-view>
		<template #default-view-title>
			<!-- <div class="ml-1">{{ $route.params.slug }}</div> -->
			<div class="ml-0">Climate Actions</div>
		</template>
		<template #default-view-body>
			<div class="content_container mt-10" v-if="programme">
				<div class="header_details" :style="{ backgroundImage: `url(${store.getPoster(programme.id).url})` }">
					<h3 class="mx-4">{{ programme.name }}</h3>
				</div>

				<div class="mx-0 mt-0 border-gray-200 leading-relaxed text-lg">
					<p class="mx-4 flex justify-between border-b border-gray-200/20 pb-3">
						<span class="font-bold">Carbon Reduction</span> {{ programme.emissions_avoided }} kg CO2 / year
					</p>
					<p class="mx-4 flex justify-between border-b border-gray-200/20 pb-3">
						<span class="font-bold">Carbon Income</span>
						{{ store.getIncome(programme.id) }} {{ store.getCurrency(programme.id) }}
					</p>

					<p class="mx-4 flex justify-between border-b border-gray-200/20 pb-3">
						<span class="font-bold">Timeline</span> {{ store.getWorktime(programme.id) }} hours
					</p>
					<p class="mx-4 flex justify-between border-b border-gray-200/20 pb-3">
						<span class="font-bold">Location</span>
						<span class="flex items-center"
							>{{ getCountry.of(programme.country_code) }}
							<svg
								xmlns="http://www.w3.org/2000/svg"
								fill="none"
								viewBox="0 0 24 24"
								stroke-width="1.5"
								stroke="currentColor"
								class="w-6 h-6 ml-2">
								<path stroke-linecap="round" stroke-linejoin="round" d="M8.25 4.5l7.5 7.5-7.5 7.5" />
							</svg>
						</span>
					</p>
					<p class="flex justify-between px-6"><span class="font-bold">Funding</span> {{ programme.funding_source }}</p>
					<div class="w-full flex items-center mt-0 mb-0 bg-white/10">
						<h3 class="text-xl text-white w-full pl-5 my-0 text-center font-bold mx-auto flex items-center py-4">
							<svg
								xmlns="http://www.w3.org/2000/svg"
								fill="none"
								viewBox="0 0 24 24"
								stroke-width="1"
								stroke="currentColor"
								class="w-8 h-8 mr-2">
								<path
									stroke-linecap="round"
									stroke-linejoin="round"
									d="M11.35 3.836c-.065.21-.1.433-.1.664 0 .414.336.75.75.75h4.5a.75.75 0 00.75-.75 2.25 2.25 0 00-.1-.664m-5.8 0A2.251 2.251 0 0113.5 2.25H15c1.012 0 1.867.668 2.15 1.586m-5.8 0c-.376.023-.75.05-1.124.08C9.095 4.01 8.25 4.973 8.25 6.108V8.25m8.9-4.414c.376.023.75.05 1.124.08 1.131.094 1.976 1.057 1.976 2.192V16.5A2.25 2.25 0 0118 18.75h-2.25m-7.5-10.5H4.875c-.621 0-1.125.504-1.125 1.125v11.25c0 .621.504 1.125 1.125 1.125h9.75c.621 0 1.125-.504 1.125-1.125V18.75m-7.5-10.5h6.375c.621 0 1.125.504 1.125 1.125v9.375m-8.25-3l1.5 1.5 3-3.75" />
							</svg>

							Steps
						</h3>
					</div>
					<Splide :options="{ autoHeight: true }">
						<SplideSlide v-for="(item, index) in store.getSteps(programme.id)" :key="index">
							<div class="rounded-xl bg-white/10 mx-4 my-3 px-10 mb-2 py-3 flex items-center justify-center flex-col">
								<div class="rounded-2xl mt-3 mx-auto inline-flex overflow-hidden border-none">
									<span class="text-md font-bold bg-blue-800 text-white px-3 py-2">Step {{ index + 1 }}</span>
									<span class="px-3 text-md py-2 bg-gray-100/10">{{ item.worktime }} Hours</span>
								</div>
								<p class="font-bold text-xl py-2 border-b border-t border-white/20 px-2 mb-0">
									<span>{{ item.name }}</span>
								</p>
								<p class="text-center" my-0>{{ item.description }}</p>
								<div class="text-center px-10">
									<p class="mt-0 mb-0 block font-bold text-center underline">Materials needed</p>
									<p class="my-0" v-for="(s, i) in item.supplies" :key="i">{{ s }}</p>
									<p class="font-bold underline mb-0">Technical support</p>
									<p v-if="item.tech_support" class="my-0">Available</p>
									<p v-else class="my-0">No</p>
									<p class="font-bold underline mb-0">Risks</p>
									<p class="my-0" v-for="(s, i) in item.risks" :key="i">{{ s }}</p>
								</div>
							</div>
						</SplideSlide>
					</Splide>
					<div class="w-full flex items-center">
						<h3
							class="text-xl text-white bg-white/10 w-full pl-5 py-4 my-0 text-center font-bold mx-auto flex items-center border-b border-white/20">
							<svg
								xmlns="http://www.w3.org/2000/svg"
								fill="none"
								viewBox="0 0 24 24"
								stroke-width="1"
								stroke="white"
								class="w-8 h-8 mr-2">
								<path stroke-linecap="round" stroke-linejoin="round" d="M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
								<path
									stroke-linecap="round"
									stroke-linejoin="round"
									d="M15.91 11.672a.375.375 0 010 .656l-5.603 3.113a.375.375 0 01-.557-.328V8.887c0-.286.307-.466.557-.327l5.603 3.112z" />
							</svg>

							Video Description
						</h3>
					</div>
					<div class="w-full flex flex-col relative flex items-center justify-center">
						<video class="h-auto w-full" controls :src="store.getVideo(programme.id).url" />
						<p class="italic w-full my-0 bg-white/20 py-3 text-center">{{ store.getVideo(programme.id).caption }}</p>
					</div>
					<div class="w-full flex items-center mt-0">
						<h3
							class="text-xl text-white bg-white/10 w-full pl-5 py-4 my-0 text-center font-bold mx-auto flex items-center border-b border-white/20">
							<svg
								xmlns="http://www.w3.org/2000/svg"
								fill="none"
								viewBox="0 0 24 24"
								stroke-width="1"
								stroke="currentColor"
								class="w-8 h-8 mr-3">
								<path
									stroke-linecap="round"
									stroke-linejoin="round"
									d="M2.25 15.75l5.159-5.159a2.25 2.25 0 013.182 0l5.159 5.159m-1.5-1.5l1.409-1.409a2.25 2.25 0 013.182 0l2.909 2.909m-18 3.75h16.5a1.5 1.5 0 001.5-1.5V6a1.5 1.5 0 00-1.5-1.5H3.75A1.5 1.5 0 002.25 6v12a1.5 1.5 0 001.5 1.5zm10.5-11.25h.008v.008h-.008V8.25zm.375 0a.375.375 0 11-.75 0 .375.375 0 01.75 0z" />
							</svg>

							Gallery
						</h3>
					</div>

					<Splide :options="{ autoHeight: true }">
						<SplideSlide class="slide" v-for="(item, key) in store.getGallery(programme.id)">
							<img :src="item.url" />
						</SplideSlide>
					</Splide>

					<div
						class="w-full text-center flex items-center justify-center text-xl font-bold bg-blue-600 py-4 capitalize"
						@click="signup()">
						Sign up for Action
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
					</div>

					<ion-modal :fullscreen="true" class="" :is-open="modalIsOpen" @did-dismiss="modalIsOpen = false">
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
						<ion-content class="px-6">
							<div class="px-6">
								<accountView
									:callback="`/apply/record/${programme.id}`"
									@on-close="modalIsOpen = false"
									@modalCancel="modalIsOpen = false" />
							</div>
						</ion-content>
					</ion-modal>
				</div>
			</div>
		</template>
	</base-view>
</template>
<style scoped>
ion-modal {
	--height: 100%;
}
.content_container {
	position: absolute;
	top: -50px;
	@apply w-full h-full;
}

.header_details {
	height: 380px;
	background-repeat: no-repeat !important;
	background-size: cover !important;
	background-position: 50% 50px !important;
	display: flex;
	flex-direction: column;
	justify-content: flex-end;
	align-items: center;
	@apply relative inline-block w-full flex flex-col;
}

.header_details * {
	z-index: 9999;
}

.header_details h3 {
	position: relative;
	@apply font-bold inline-block  text-white text-3xl border-b border-white/20 pb-4 mb-0;
	z-index: 9999;
}

.header_details:after {
	content: '';
	height: 100%;
	bottom: 0;
	left: 0;
	@apply w-full absolute;
	background: linear-gradient(to bottom, rgba(0, 0, 0, 0), rgba(0, 0, 0, 1));
}

.counter {
	@apply bg-black text-white rounded-full inline-flex items-center justify-center p-2 mr-2 w-4 h-4;
}

div /deep/ .splide__arrow {
	display: none !important;
}

div /deep/ .splide__arrow--next {
	background: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' fill='black' viewBox='0 0 24 24' stroke-width='1.5' stroke='white' class='w-6 h-6'%3E%3Cpath stroke-linecap='round' stroke-linejoin='round' d='M8.25 4.5l7.5 7.5-7.5 7.5' /%3E%3C/svg%3E%0A")
		#000 no-repeat center center !important;
	background-size: 12px !important;
}

div /deep/ .splide__arrow--prev {
	background: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' fill='none' viewBox='0 0 24 24' stroke-width='1.5' stroke='white' class='w-6 h-6'%3E%3Cpath stroke-linecap='round' stroke-linejoin='round' d='M15.75 19.5L8.25 12l7.5-7.5' /%3E%3C/svg%3E%0A")
		#000 no-repeat 40% 50% !important;
	background-size: 12px !important;
}

div /deep/ .splide__arrow svg {
	display: none !important;
}

.slide img {
	height: 400px;
	object-fit: cover;
}
</style>
