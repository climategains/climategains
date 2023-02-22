<script setup lang="ts">
import { ref, onMounted } from 'vue';
import { getResponse, getStepsFromProjectId } from '@/helpers/api';
import { getDate, getTime } from '@/helpers/parsers';

import accountView from '@/components/account/index.vue';

import { useRoute, useRouter } from 'vue-router';

import { MapboxMap, MapboxMarker } from '@studiometa/vue-mapbox-gl';

import useStore from '@/store';

const store = useStore();

const route = useRoute();
const router = useRouter();

const modalIsOpen = ref(false);

const project = store.getProject(route.params.slug);
const programme = store.getProgramme(project.programme_id);
const programme_steps = store.global.steps
	.filter(x => x.programme_id === project.programme_id)
	.sort((a, b) => a.order - b.order);
const project_steps = ref([]);

function isSubmitted(id) {
	if (project_steps.value.filter(x => x.programme_step_id === id)) {
		return project_steps.value.filter(x => x.programme_step_id === id)[0];
	} else {
		return false;
	}
}

function signup() {
	if (store.isAuthenticated) {
		router.push(`/verify/${project.id}`);
	} else {
		modalIsOpen.value = true;
	}
}

onMounted(async () => {
	project_steps.value = await getStepsFromProjectId(route.params.slug);
});
</script>
<template>
	<page-view>
		<template #default-view-title>
			<!-- <div class="ml-1">{{ $route.params.slug }}</div> -->
			<div class="ml-0">Climate Actions</div>
		</template>
		<template #default-view-body>
			<div v-if="project" class="content_container mt-10">
				<div class="header_details">
					<MapboxMap
						style="height: 380px; width: 100%; position: relative"
						zoom="8"
						access-token="pk.eyJ1Ijoib3dlbmdvdCIsImEiOiJjbDcyNzE2aDcwMjBuNDBud3F1MGthdnh0In0.XFuCpgmPbk862HekmvKDlw"
						map-style="mapbox://styles/mapbox/streets-v12
"
						:center="[project.geo_long, project.geo_lat]">
						<MapboxMarker :lng-lat="[project.geo_long, project.geo_lat]">
							<p class="bg-green-500 absolute w-3 h-3 rounded-full"></p
						></MapboxMarker>
					</MapboxMap>
				</div>
				<div class="flex justify-between items-center border-b py-3 border-white/30">
					<h3 class="px-6 text-2xl my-0">{{ project.name }}</h3>
					<span class="mr-6 flex items-center bg-white/20 rounded-full py-2 text-white text-xs px-6 font-bold">
						<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor" class="w-3 h-3 mr-2">
							<path
								fill-rule="evenodd"
								d="M6.32 2.577a49.255 49.255 0 0111.36 0c1.497.174 2.57 1.46 2.57 2.93V21a.75.75 0 01-1.085.67L12 18.089l-7.165 3.583A.75.75 0 013.75 21V5.507c0-1.47 1.073-2.756 2.57-2.93z"
								clip-rule="evenodd" />
						</svg>

						Bookmark
					</span>
				</div>

				<div class="mx-0 mt-0 border-gray-200" v-if="project_steps[0]">
					<div class="list_item">
						<span class="font-bold">Carbon Reduction</span>
						<span class="font-light">{{ programme.emissions_avoided }} kg CO2 / year</span>
					</div>
					<div class="list_item">
						<span class="font-bold">Carbon Income</span>
						<span class="font-light">{{ store.getIncome(programme.id) }} {{ store.getCurrency(programme.id) }}</span>
					</div>
					<div class="list_item">
						<span class="font-bold">User</span>
						<span class="font-light">{{ store.getUser(project_steps[0].submitter)[0].fullname }}</span>
					</div>
					<div class="list_item">
						<span class="font-bold">Organization</span>
						<span class="font-light">{{ store.getUser(project_steps[0].submitter)[0].organization }}</span>
					</div>
					<div class="list_item">
						<span class="font-bold">Timeline</span>
						<span class="font-light">{{ store.getWorktime(programme.id) }} hours</span>
					</div>

					<div class="list_item">
						<span class="font-bold">Programme</span>
						<span class="flex items-center font-light">{{ programme.name }} </span>
					</div>
					<div class="list_item">
						<span class="font-bold">Location</span>
						<span class="flex items-center font-light">{{ project.location_name }} </span>
					</div>
					<div class="list_item">
						<span class="font-bold">Funding provided by </span>
						<span class="flex items-center font-light">{{ programme.funding_source }}</span>
					</div>
				</div>

				<div class="w-full flex items-center mt-0 mb-0 bg-gray-900">
					<h3
						class="text-lg text-white border-white/10 border-b w-full pl-6 my-0 text-center font-bold mx-auto flex items-center py-3">
						<svg
							xmlns="http://www.w3.org/2000/svg"
							fill="none"
							viewBox="0 0 24 24"
							stroke-width="2"
							stroke="currentColor"
							class="w-6 h-6 mr-3">
							<path
								stroke-linecap="round"
								stroke-linejoin="round"
								d="M11.35 3.836c-.065.21-.1.433-.1.664 0 .414.336.75.75.75h4.5a.75.75 0 00.75-.75 2.25 2.25 0 00-.1-.664m-5.8 0A2.251 2.251 0 0113.5 2.25H15c1.012 0 1.867.668 2.15 1.586m-5.8 0c-.376.023-.75.05-1.124.08C9.095 4.01 8.25 4.973 8.25 6.108V8.25m8.9-4.414c.376.023.75.05 1.124.08 1.131.094 1.976 1.057 1.976 2.192V16.5A2.25 2.25 0 0118 18.75h-2.25m-7.5-10.5H4.875c-.621 0-1.125.504-1.125 1.125v11.25c0 .621.504 1.125 1.125 1.125h9.75c.621 0 1.125-.504 1.125-1.125V18.75m-7.5-10.5h6.375c.621 0 1.125.504 1.125 1.125v9.375m-8.25-3l1.5 1.5 3-3.75" />
						</svg>

						Current Status
					</h3>
				</div>

				<div v-if="project_steps[0]" class="flex px-4 mt-3 flex-col items-center justify-center">
					<div v-for="(item, index) in programme_steps" :key="index">
						<div v-if="isSubmitted(item.id)">
							<div class="rounded-lg relative mb-3 overflow-hidden bg-green-800" @click="signup()">
								<div class="px-3">
									<h3 class="mb-0 flex items-center">
										<span class="bg-white text-green-800 text-xs rounded-lg mr-3 p-2">Step {{ item.order / 100 }}</span
										>{{ item.name }}
									</h3>
									<p class="mt-2">{{ item.description }}</p>
									<p class="flex justify-between border-y border-white/20 py-2 my-0">
										<span class="font-bold">Submission date</span> {{ getDate(isSubmitted(item.id).submitted) }} at
										{{ getTime(isSubmitted(item.id).submitted) }}
									</p>

									<p class="flex justify-between border-white/20 py-2 my-0">
										<span class="font-bold">Submitted by</span>
										{{ store.getUser(isSubmitted(item.id).submitter)[0].fullname }}
									</p>

									<div v-if="isSubmitted(item.id).validation_status !== null">
										<p>
											Validation status {{ isSubmitted(item.id).validation_status }} on
											{{ isSubmitted(item.id).validation_updated }}
										</p>
										<p>Validated by {{ isSubmitted(item.id).validator }}</p>
									</div>
								</div>
								<div v-if="isSubmitted(item.id).paid">
									<p>Paid by {{ isSubmitted(item.id).paid_by }}</p>
								</div>
								<div class="flex items-center justify-center mt-2 font-bold bg-black/20 w-full py-3">
									Verify this step
									<svg
										xmlns="http://www.w3.org/2000/svg"
										viewBox="0 0 24 24"
										fill="currentColor"
										class="w-5 h-5 ml-2 mt-1">
										<path
											fill-rule="evenodd"
											d="M12 2.25c-5.385 0-9.75 4.365-9.75 9.75s4.365 9.75 9.75 9.75 9.75-4.365 9.75-9.75S17.385 2.25 12 2.25zm4.28 10.28a.75.75 0 000-1.06l-3-3a.75.75 0 10-1.06 1.06l1.72 1.72H8.25a.75.75 0 000 1.5h5.69l-1.72 1.72a.75.75 0 101.06 1.06l3-3z"
											clip-rule="evenodd" />
									</svg>
								</div>
							</div>
						</div>
						<div class="rounded-lg relative mb-3 overflow-hidden bg-black border p-3" v-else>
							<h3 class="my-0 flex items-center">
								<span class="bg-white text-black text-xs rounded-lg mr-3 p-2">Step {{ item.order / 100 }}</span
								>{{ item.name }}
							</h3>
							<p class="mt-2 mb-0">{{ item.description }}</p>
						</div>
					</div>
				</div>

				<!-- <div class="w-full flex items-center mt-0 mb-0 bg-gray-900">
					<h3
						class="text-lg text-white border-white/10 border-b border-t w-full pl-6 my-0 text-center font-bold mx-auto flex items-center py-3">
						<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor" class="w-6 h-6 mr-3">
							<path
								fill-rule="evenodd"
								d="M1.5 6a2.25 2.25 0 012.25-2.25h16.5A2.25 2.25 0 0122.5 6v12a2.25 2.25 0 01-2.25 2.25H3.75A2.25 2.25 0 011.5 18V6zM3 16.06V18c0 .414.336.75.75.75h16.5A.75.75 0 0021 18v-1.94l-2.69-2.689a1.5 1.5 0 00-2.12 0l-.88.879.97.97a.75.75 0 11-1.06 1.06l-5.16-5.159a1.5 1.5 0 00-2.12 0L3 16.061zm10.125-7.81a1.125 1.125 0 112.25 0 1.125 1.125 0 01-2.25 0z"
								clip-rule="evenodd" />
						</svg>

						Photos
					</h3>
				</div>

				<div class="gallery">
					<img v-for="(item, index) in action.metadata.media.gallery" :src="item.url" :key="index"/>
{{ store.global.media }}
				</div> -->

				<ion-modal fullscreen="true" class="" :is-open="modalIsOpen" @did-dismiss="modalIsOpen = false">
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
					<ion-content>
						<div class="px-6 mt-10">
							<h1 class="text-3xl text-left mb-0">Welcome To Climate Gains</h1>
							<p class="text-left text-xl">
								In order to go further you'll need to create an account or login to your existing account.
							</p>
							<accountView
								class="mx-10"
								:callback="`/verify/${project.id}`"
								@on-close="modalIsOpen = false"
								@modalCancel="modalIsOpen = false" />
						</div>
					</ion-content>
				</ion-modal>
			</div>
		</template>
	</page-view>
</template>
<style scoped>
.content_container {
	position: absolute;
	top: -50px;
	@apply w-full h-full;
}

.gallery img {
	width: 33.33%;
	float: left;
	height: 120px;
	object-fit: cover;
}
.list_item {
	@apply border-b border-white/20 py-4 px-6 flex items-center justify-between;
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
	height: 30%;
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

.step {
	@apply mx-auto w-full border border-white/50  mb-0 rounded-lg;
}
.step.active {
	@apply bg-green-700 border-none;
}
.step_index {
	@apply bg-white text-gray-600 border border-white justify-center mr-3  rounded-lg px-3 py-1 text-xs font-bold h-4 items-center flex;
}

.step.active .step_index {
	@apply bg-white text-green-800;
}
</style>
