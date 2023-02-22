<script setup lang="ts">
import { ref, onMounted } from 'vue';
import { IonButton, IonModal } from '@ionic/vue';

import { MapboxMap, MapboxMarker } from '@studiometa/vue-mapbox-gl';
import { getResponse, getStep, getStepsFromProjectId } from '@/helpers/api';

import { Splide, SplideSlide } from '@splidejs/vue-splide';
import '@splidejs/vue-splide/css';

import { useRoute, useRouter } from 'vue-router';

import useStore from '@/stores/main';

const splide = ref();

const store = useStore();
const route = useRoute();
const router = useRouter();

const selected = ref('');
const response = ref([]);
const questions = ref([]);

type myObj = {
	[key: string]: any;
};

const step: myObj = ref({});
const project: myObj = ref({});
const programme: myObj = ref({});

const i = ref(0);

function getDate(string) {
	let d = new Date(string);
	return d.toLocaleDateString('en-GB');
}
function getTime(string) {
	let d = new Date(string);
	return d.toLocaleTimeString('en-US');
}

function showModal(string) {
	selected.value = string;
}
async function nextResponse() {
	if (i.value + 1 < response.value.length) {
		i.value = i.value + 1;
	} else {
		router.push(`./result/${project.value.id}`);
	}
	selected.value = null;
}

function entry(index) {
	var q = questions.value[index];
	var obj = {
		question: q,
		response: response.value.filter(x => x.programme_response_id == q.id)[0]
	};
	return obj;
}

onMounted(async () => {
	step.value = await getStepsFromProjectId(route.params.slug);
	response.value = await getResponse(step.value[0].id);

	project.value = store.getProject(step.value[0].project_id);
	programme.value = store.getProgramme(project.value.programme_id);
	questions.value = store.global.questions
		.filter(x => x.programme_step_id === programme.value.id)
		.sort((a, b) => a.order - b.order);
});
selected.value = 'welcome';
</script>
<template>
	<page-view>
		<template #default-view-title>
			<!-- <div class="ml-1">{{ $route.params.slug }}</div> -->
			<div class="ml-0">Climate Actions</div>
		</template>
		<template #default-view-body>
			<div v-if="questions[i] && response[i]">
				<div class="w-full flex flex-col items-start">
					<video class="w-full" playsinline="true" controls :src="entry(i).response.url"></video>
				</div>
				<div class="py-3 w-full text-center border-b border-white/20 bg-white/10">
					<div class="mx-4">
						<h3 class="text-xl my-0 py-0 font-bold">Response to Question {{ i + 1 }} of {{ response.length }}</h3>

						<span class="text-lg">{{ entry(i).question.prompt }}</span>
					</div>
				</div>
			</div>
			<div class="flex justify-between items-center">
				<div class="action_button font-bold bg-green-700" @click="showModal('verify')">
					<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" class="w-5 h-5 mr-2">
						<path
							fill-rule="evenodd"
							d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.857-9.809a.75.75 0 00-1.214-.882l-3.483 4.79-1.88-1.88a.75.75 0 10-1.06 1.061l2.5 2.5a.75.75 0 001.137-.089l4-5.5z"
							clip-rule="evenodd" />
					</svg>
					Verify Response
				</div>

				<div class="action_button font-bold bg-red-700" @click="showModal('flag')">
					<svg
						xmlns="http://www.w3.org/2000/svg"
						fill="none"
						viewBox="0 0 24 24"
						stroke-width="3"
						stroke="currentColor"
						class="w-4 h-4 mr-2">
						<path
							stroke-linecap="round"
							stroke-linejoin="round"
							d="M3 3v1.5M3 21v-6m0 0l2.77-.693a9 9 0 016.208.682l.108.054a9 9 0 006.086.71l3.114-.732a48.524 48.524 0 01-.005-10.499l-3.11.732a9 9 0 01-6.085-.711l-.108-.054a9 9 0 00-6.208-.682L3 4.5M3 15V4.5" />
					</svg>
					Flag Response
				</div>
			</div>
			<div class="flex justify-between items-center">
				<div class="action_button bg-white/10 border-b border-white/10" @click="showModal('verify')">Ask an Expert</div>

				<div class="action_button bg-white/10 border-l border-b border-white/10" @click="showModal('flag')">
					Send a Question
				</div>
			</div>
			<div class="mx-0 pb-10" v-if="step && response[i]">
				<div class="list_item">
					<b>Uploaded by</b>
					<div class="flex items-center">
						<span class="font-light">{{ store.getUser(entry(i).response.creator)[0].fullname }}</span>
						<svg
							xmlns="http://www.w3.org/2000/svg"
							fill="none"
							viewBox="0 0 24 20"
							stroke-width="1"
							stroke="currentColor"
							class="w-5 h-5 ml-1">
							<path stroke-linecap="round" stroke-linejoin="round" d="M8.25 4.5l7.5 7.5-7.5 7.5" />
						</svg>
					</div>
				</div>
				<div class="list_item">
					<b>Date of recording</b>
					<span class="font-light"
						>{{ getDate(entry(i).response.created) }} at {{ getTime(entry(i).response.created) }}</span
					>
				</div>
				<div class="list_item">
					<b>Location of recording</b>

					{{ project.location_name }}
					<!-- <div class="flex items-center font-light" @click="showModal('map')">
						{{ action.metadata.location.locationName }},
						{{ getCountry.of(action.metadata.location.countryCode) }}
						<svg
							xmlns="http://www.w3.org/2000/svg"
							fill="none"
							viewBox="0 0 24 20"
							stroke-width="1"
							stroke="currentColor"
							class="w-5 h-5 ml-1">
							<path stroke-linecap="round" stroke-linejoin="round" d="M8.25 4.5l7.5 7.5-7.5 7.5" />
						</svg>
					</div> -->
				</div>
				<div class="list_item">
					<b>Programme</b>
					<span class="flex font-light items-center">
						{{ programme.name }}
						<svg
							xmlns="http://www.w3.org/2000/svg"
							fill="none"
							viewBox="0 0 24 21"
							stroke-width="1"
							stroke="currentColor"
							class="w-5 h-5 ml-1">
							<path stroke-linecap="round" stroke-linejoin="round" d="M8.25 4.5l7.5 7.5-7.5 7.5" />
						</svg>
					</span>
				</div>
			</div>
			<ion-modal :fullscreen="true" :is-open="selected !== null" v-if="step && response[i]">
				<ion-header>
					<ion-toolbar>
						<ion-buttons slot="start">
							<div class="pl-4 flex items-center text-lg font-bold" @click="selected = null">
								<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="white" class="w-6 h-6 mr-2">
									<path
										fill-rule="evenodd"
										d="M12 2.25c-5.385 0-9.75 4.365-9.75 9.75s4.365 9.75 9.75 9.75 9.75-4.365 9.75-9.75S17.385 2.25 12 2.25zm-1.72 6.97a.75.75 0 10-1.06 1.06L10.94 12l-1.72 1.72a.75.75 0 101.06 1.06L12 13.06l1.72 1.72a.75.75 0 101.06-1.06L13.06 12l1.72-1.72a.75.75 0 10-1.06-1.06L12 10.94l-1.72-1.72z"
										clip-rule="evenodd" />
								</svg>

								Cancel
							</div>
						</ion-buttons>
					</ion-toolbar>
				</ion-header>
				<ion-content>
					<!-- <div v-if="selected == 'map'">
						<div class="mx-6">
							<h3 class="mb-1 underline mt-1">Recording Coordinates</h3>
							<p class="mt-0">
								<b>Longitude</b> {{ action.metadata.location.long }} <b class="ml-2">Lattitude</b>
								{{ action.metadata.location.lat }}
							</p>
						</div>
						<MapboxMap
							style="height: 500px; width: 100%; position: relative"
							zoom="10"
							access-token="pk.eyJ1Ijoib3dlbmdvdCIsImEiOiJjbDcyNzE2aDcwMjBuNDBud3F1MGthdnh0In0.XFuCpgmPbk862HekmvKDlw"
							map-style="mapbox://styles/mapbox/streets-v12
"
							:center="[action.metadata.location.long, action.metadata.location.lat]">
							<MapboxMarker :lng-lat="[action.metadata.location.long, action.metadata.location.lat]">
								<p class="bg-blue-500 absolute w-3 h-3 rounded-full"></p
							></MapboxMarker>
						</MapboxMap>
					</div> -->
					<div class="mx-10 text-white" v-if="selected == 'welcome'">
						<h3 class="text-center text-2xl flex items-center leading-tight justify-start my-0 font-bold">
							<svg
								xmlns="http://www.w3.org/2000/svg"
								fill="none"
								viewBox="0 0 22 24"
								stroke-width="1"
								stroke="currentColor"
								class="w-18 h-18 -mr-6">
								<path
									stroke-linecap="round"
									stroke-linejoin="round"
									d="M11.35 3.836c-.065.21-.1.433-.1.664 0 .414.336.75.75.75h4.5a.75.75 0 00.75-.75 2.25 2.25 0 00-.1-.664m-5.8 0A2.251 2.251 0 0113.5 2.25H15c1.012 0 1.867.668 2.15 1.586m-5.8 0c-.376.023-.75.05-1.124.08C9.095 4.01 8.25 4.973 8.25 6.108V8.25m8.9-4.414c.376.023.75.05 1.124.08 1.131.094 1.976 1.057 1.976 2.192V16.5A2.25 2.25 0 0118 18.75h-2.25m-7.5-10.5H4.875c-.621 0-1.125.504-1.125 1.125v11.25c0 .621.504 1.125 1.125 1.125h9.75c.621 0 1.125-.504 1.125-1.125V18.75m-7.5-10.5h6.375c.621 0 1.125.504 1.125 1.125v9.375m-8.25-3l1.5 1.5 3-3.75" />
							</svg>
							What to look for in the applicant's response
						</h3>
						<ul class="checklist">
							<li>Verify the date of the video with the information provided by the activisit</li>
							<li>
								<p>
									Does the activist have the necessary technical background to carry the project out, and if not, are
									they working with someone who does?
								</p>
								<p class="mb-1">
									If you're not sure, you can tap <u class="font-bold">ask an expert</u> and send a video question to
									someone in the field.
								</p>
							</li>
							<li>Is there anything that seems suspicious? If so, flag the video.</li>
							<li>
								Would you like clarifications on anything the activist is saying or doing? It so, you can tap
								<u class="font-bold">send a question</u> to send a video back to them.
							</li>
						</ul>
						<div
							class="w-full flex mt-1 py-3 text-center text-white font-bold bg-white/10 justify-center items-center"
							@click="selected = null">
							Continue
							<svg
								xmlns="http://www.w3.org/2000/svg"
								fill="none"
								viewBox="0 0 24 24"
								stroke-width="2"
								stroke="currentColor"
								class="w-4 h-4 ml-2 mt-1">
								<path stroke-linecap="round" stroke-linejoin="round" d="M13.5 4.5L21 12m0 0l-7.5 7.5M21 12H3" />
							</svg>
						</div>
					</div>

					<div class="mx-10 text-white" v-if="selected == 'verify'">
						<h3 class="text-left text-2xl flex items-center leading-tight justify-start my-0 font-bold">
							Before you proceed, please confirm the following..
						</h3>
						<ul class="checklist">
							<li>I have checked the location, date and time of the recording.</li>
							<li>The identity of the responder corresponds to the activist's account credentials.</li>
							<li>
								I have assesed the activist's experience and background based on the contents of their response and
								conclude that they have the experience and access to expertise required to bring the task to completion.
							</li>
							<li>
								When necessary I have contacted the activist for further context missing in the response. In case of any
								doubt I have contacted an expert to assist me.
							</li>
						</ul>

						<div class="w-full mt-2 py-3 text-center text-white font-bold bg-green-600" @click="selected = 'verified'">
							Confirm
						</div>
					</div>

					<div class="mx-10 h-full flex flex-col items-center justify-center" v-if="selected == 'verified'">
						<div class="bg-gray-900 py-4 px-3 w-full text-center -mt-10 py-3 rounded-2xl">
							<span class="font-bold"> Video {{ i + 1 }} of {{ response.length }} Verified</span>
						</div>
						<div class="mt-10 w-full mx-10">
							<div class="flex justify-between py-3 border-b border-t border-white/20">
								<b>Verified by</b><span>{{ store.user.account.email }} </span>
							</div>
							<div class="flex justify-between py-3 border-b border-white/20">
								<b>Verification date</b><span>{{ getDate(Date()) }} at {{ getTime(Date()) }}</span>
							</div>
							<div class="mt-10 bg-green-700 py-4 rounded-xl font-bold text-center" @click="nextResponse()">
								<span v-if="i + 1 < response.length"> Proceed to Video {{ i + 2 }}</span>
								<span v-else>Complete verification</span>
							</div>
						</div>
					</div>
					<div class="mx-10 text-white" v-if="selected == 'flag'">
						<h3 class="text-left text-xl flex items-center leading-tight justify-start my-0 font-bold">
							Please describe the issue(s) you have encountered below.
						</h3>
						<div class="bg-white/10 mt-6 flex items-stretch">
							<textarea class="border-none flex-grow outline-none p-6 text-lg h-40"></textarea>
						</div>

						<div class="w-full mt-4 py-3 text-center text-white font-bold bg-red-600">Flag Video</div>
					</div>
				</ion-content>
			</ion-modal>
		</template>
	</page-view>
</template>
<style scoped>
.list_item {
	@apply border-b border-white/20 py-4 px-4 flex items-center justify-between;
}

ul.checklist li {
	@apply border-b py-4 border-white/40 leading-normal;
}

ul.checklist li:last-child {
	border: none;
}

ul.checklist li p {
	@apply mt-0;
}

.action_button {
	@apply h-14 flex items-center justify-center;
	width: 50%;
}
.counter {
	@apply bg-black text-white rounded-full inline-flex items-center justify-center p-2 mr-2 w-4 h-4;
}

.step {
	@apply mx-auto w-3/4 bg-gray-800 py-4 px-10 mb-0 rounded-2xl;
}
.step.active {
	@apply bg-green-600;
	padding-bottom: 60px;
}
.step_index {
	@apply bg-none border border-white justify-center mr-3 text-white rounded-lg px-3 py-1 text-xs font-bold h-4 items-center flex;
}

.step.active .step_index {
	@apply text-white text-white;
}

.success {
	align-items: center;
	background-color: #0da468;
	display: flex;
	@apply w-full mx-auto  flex items-center;
	justify-content: center;
}

@keyframes scaleAnimation {
	0% {
		opacity: 0;
		transform: scale(1.5);
	}
	100% {
		opacity: 1;
		transform: scale(1);
	}
}
@-webkit-keyframes drawCircle {
	0% {
		stroke-dashoffset: 151px;
	}
	100% {
		stroke-dashoffset: 0;
	}
}
@keyframes drawCircle {
	0% {
		stroke-dashoffset: 151px;
	}
	100% {
		stroke-dashoffset: 0;
	}
}
@-webkit-keyframes drawCheck {
	0% {
		stroke-dashoffset: 36px;
	}
	100% {
		stroke-dashoffset: 0;
	}
}
@keyframes drawCheck {
	0% {
		stroke-dashoffset: 36px;
	}
	100% {
		stroke-dashoffset: 0;
	}
}
@-webkit-keyframes fadeOut {
	0% {
		opacity: 1;
	}
	100% {
		opacity: 0;
	}
}
@keyframes fadeOut {
	0% {
		opacity: 1;
	}
	100% {
		opacity: 0;
	}
}
@-webkit-keyframes fadeIn {
	0% {
		opacity: 0;
	}
	100% {
		opacity: 1;
	}
}
@keyframes fadeIn {
	0% {
		opacity: 0;
	}
	100% {
		opacity: 1;
	}
}
#successAnimationCircle {
	stroke-dasharray: 151px 151px;
	stroke: #fff;
}

#successAnimationCheck {
	stroke-dasharray: 36px 36px;
	stroke: #fff;
}

#successAnimationResult {
	fill: #fff;
	opacity: 0;
}

#successAnimation.animated {
	-webkit-animation: 1s ease-out 0s 1 both scaleAnimation;
	animation: 1s ease-out 0s 1 both scaleAnimation;
}
#successAnimation.animated #successAnimationCircle {
	-webkit-animation: 1s cubic-bezier(0.77, 0, 0.175, 1) 0s 1 both drawCircle, 0.3s linear 0.9s 1 both fadeOut;
	animation: 1s cubic-bezier(0.77, 0, 0.175, 1) 0s 1 both drawCircle, 0.3s linear 0.9s 1 both fadeOut;
}
#successAnimation.animated #successAnimationCheck {
	-webkit-animation: 1s cubic-bezier(0.77, 0, 0.175, 1) 0s 1 both drawCheck, 0.3s linear 0.9s 1 both fadeOut;
	animation: 1s cubic-bezier(0.77, 0, 0.175, 1) 0s 1 both drawCheck, 0.3s linear 0.9s 1 both fadeOut;
}
#successAnimation.animated #successAnimationResult {
	-webkit-animation: 0.3s linear 0.9s both fadeIn;
	animation: 0.3s linear 0.9s both fadeIn;
}
</style>
