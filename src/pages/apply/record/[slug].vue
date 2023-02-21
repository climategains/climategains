<!-- eslint-disable vuejs-accessibility/click-events-have-key-events -->
<template>
	<ion-page>
		<ion-content class="my-custom-camera-preview-content" :fullscreen="true">
			<div v-if="cameraActive" class="flex h-full flex-col items-stretch stretch">
				<div id="cameraPreview" v-show="!play" class="grow-0 relative">
					<div class="cameraVideoPreview"></div>
				</div>
				<div id="videoPreview" v-if="play" class="w-full grow-0 relative">
					<video ref="videoPlayer" controls autoplay playsinline="true" @pause="play = !play">
						<source :src="getUrl(videoFile.uri)" type="video/mp4" />
					</video>
				</div>
				<div class="video-overlay" v-if="!play" :class="{ active: !recording && video }">
					<div class="record_button mt-10 mb-4">
						<div @click="playVideo()" class="start w-full flex justify-center items-center">
							<svg
								xmlns="http://www.w3.org/2000/svg"
								fill="white"
								viewBox="0 0 24 24"
								stroke-width="0"
								stroke="currentColor"
								class="w-6 h-6 mr-2">
								<path
									stroke-linecap="round"
									stroke-linejoin="round"
									d="M5.25 5.653c0-.856.917-1.398 1.667-.986l11.54 6.348a1.125 1.125 0 010 1.971l-11.54 6.347a1.125 1.125 0 01-1.667-.985V5.653z" />
							</svg>

							<span class="font-bold">Play Video</span>
						</div>
					</div>
					<div class="record_button mb-10">
						<div @click="recordAgain()" class="start w-full flex justify-center items-center">
							<svg
								xmlns="http://www.w3.org/2000/svg"
								fill="none"
								viewBox="0 0 24 24"
								stroke-width="2.5"
								stroke="currentColor"
								class="w-5 h-5 mr-2">
								<path
									stroke-linecap="round"
									stroke-linejoin="round"
									d="M16.023 9.348h4.992v-.001M2.985 19.644v-4.992m0 0h4.992m-4.993 0l3.181 3.183a8.25 8.25 0 0013.803-3.7M4.031 9.865a8.25 8.25 0 0113.803-3.7l3.181 3.182m0-4.991v4.99" />
							</svg>

							<span class="font-bold">Record Again</span>
						</div>
					</div>
				</div>
				<div class="w-full overlay h-5 z-10 flex items-center justify-between py-3 bg-black">
					<div
						class="flex text-white text-xs bg-black rounded-full py-2 px-3 ml-3 items-center justify-center"
						v-if="recording">
						<div class="bg-red-600 mr-2 w-3 h-3 rounded-full"></div>
						<span class="font-bold">{{ recTime(timer) }}</span>
					</div>
					<ion-button
						color="light"
						size="small"
						fill="clear"
						class="image-overlay absolute right-3"
						@click="flipCamera">
						<ion-icon :icon="cameraReverseOutline"></ion-icon>
					</ion-button>
				</div>
				<div class="w-full mt-10 relative grow flex flex-col bg-black">
					<div class="flex items-center justify-center h-full w-full relative">
						<Splide
							v-if="questions"
							ref="splide"
							class="-mt-10 relative w-full"
							:options="{ autoHeight: true, drag: false, pagination: false, arrows: false }">
							<SplideSlide
								v-for="(item, index) in questions"
								:key="index"
								class="slide text-center pt-1 pb-6 px-10 flex items-center justify-center">
								<div class="w-full flex h-full flex-col items-center mx-auto">
									<h1 class="mb-0 text-2xl mb-1">Question {{ index + 1 }} of {{ questions.length }}</h1>
									<p class="text-xl mt-1 mb-3">{{ item.prompt }}</p>

									<div class="record_button" :class="{ active: recording, next: video }">
										<div
											@click="recordVideo()"
											v-if="!recording && !video"
											class="start w-full flex flex-col justify-center items-center">
											<span class="font-bold">Record My Answer</span>
										</div>

										<div
											@click="nextQ(index)"
											v-if="!recording && video && index + 1 < questions.length"
											class="start w-full flex flex-col justify-center items-center">
											<span class="font-bold">Next Question</span>
										</div>
										<div
											@click="finish(index)"
											v-if="!recording && video && index + 1 == questions.length"
											class="start w-full flex flex-col justify-center items-center">
											<span class="font-bold">Send Video for Approval</span>
										</div>
										<div
											class="flex w-full items-center font-bold justify-center"
											@click="recordVideo()"
											v-if="recording && !video">
											<svg
												xmlns="http://www.w3.org/2000/svg"
												viewBox="0 0 24 24"
												fill="currentColor"
												class="w-6 h-6 mr-1">
												<path
													fill-rule="evenodd"
													d="M2.25 12c0-5.385 4.365-9.75 9.75-9.75s9.75 4.365 9.75 9.75-4.365 9.75-9.75 9.75S2.25 17.385 2.25 12zm6-2.438c0-.724.588-1.312 1.313-1.312h4.874c.725 0 1.313.588 1.313 1.313v4.874c0 .725-.588 1.313-1.313 1.313H9.564a1.312 1.312 0 01-1.313-1.313V9.564z"
													clip-rule="evenodd" />
											</svg>
											Stop
										</div>
									</div>
								</div>
							</SplideSlide>
						</Splide>
					</div>
				</div>
			</div>
		</ion-content>
	</ion-page>
</template>

<script setup async>
import {
	IonPage,
	IonContent,
	onIonViewWillEnter,
	onIonViewDidEnter,
	onIonViewWillLeave,
	IonButton,
	IonIcon
} from '@ionic/vue';
import { closeOutline, cameraReverseOutline } from 'ionicons/icons';
import { CameraPreview } from '@capacitor-community/camera-preview';
import { Geolocation } from '@capacitor/geolocation';

import { Filesystem, Directory, Encoding } from '@capacitor/filesystem';

import { ref, onMounted, onBeforeUnmount } from 'vue';
import { useRoute, useRouter } from 'vue-router';

import '@splidejs/vue-splide/css';
import { Splide, SplideSlide } from '@splidejs/vue-splide';

import useStore from '@/stores/main/';
import { Capacitor } from '@capacitor/core';

import { supabase } from '@/helpers/api';

const VIDEO_DIR = 'stored-videos';

const cameraOptions = {
	position: 'front',
	height: 400,
	toBack: true,
	parent: 'cameraPreview',
	className: 'cameraVideoPreview'
};

const store = useStore();

const route = useRoute();
const router = useRouter();

const action = store.global.programmes.filter(x => x.id == route.params.slug)[0];
const steps = store.getSteps(action.id).sort((a, b) => a.id - b.id);
const questions = store.global.questions.filter(x => x.programme_step_id === steps[0].id);
const cameraActive = ref(false);
const play = ref(false);
const recording = ref(false);
const video = ref(false);
const videoFile = ref(null);
const timer = ref(0);
const splide = ref();
const videoPlayer = ref();
const responses = ref([]);
function getUrl(value) {
	return Capacitor.convertFileSrc(value);
}

function playVideo() {
	play.value = !play.value;

	if (play.value) {
		videoPlayer.value.load();
		videoPlayer.value.play();
	} else {
		videoPlayer.value.pause();
	}
}

function recTime(time) {
	var minutes = Math.floor(time / 60);
	var seconds = time - minutes * 60;

	function str_pad_left(string, pad, length) {
		return (new Array(length + 1).join(pad) + string).slice(-length);
	}

	return str_pad_left(minutes, '0', 2) + ':' + str_pad_left(seconds, '0', 2);
}

async function saveVideo(path) {
	const fileName = `${new Date().getTime()}.mp4`;

	const savedFile = await Filesystem.copy({
		from: `file://${path}`,
		to: `${VIDEO_DIR}/${fileName}`,
		toDirectory: Directory.Data
	});

	videoFile.value = savedFile;
}

async function recordVideo() {
	recording.value = !recording.value;

	let interval = setInterval(() => {
		if (!recording.value) {
			clearInterval(interval);
			video.value = true;
		} else {
			timer.value++;
			video.value = false;
		}
	}, 1000);
	if (!recording.value) {
		const videoData = await CameraPreview.stopRecordVideo();
		await saveVideo(videoData.videoFilePath);
	} else {
		CameraPreview.startRecordVideo(cameraOptions);
	}
}

const dummyVideos = [
	'https://cloud.vashgreenschools.org/index.php/s/ZpNaL2miYBEJqWd/download/UG1.mp4',
	'https://2050today.org/wp-content/uploads/2020/07/Video-Placeholder.mp4',
	'https://samplelib.com/lib/preview/mp4/sample-5s.mp4',
	'https://cloud.vashgreenschools.org/index.php/s/ZpNaL2miYBEJqWd/download/UG1.mp4',
	'https://2050today.org/wp-content/uploads/2020/07/Video-Placeholder.mp4'
];

function nextQ(index) {
	video.value = false;
	timer.value = 0;
	splide.value.go(index + 1);
	const resp = {
		programme_response_id: questions[index].id,
		url: dummyVideos[index]
	};
	responses.value.push(resp);
}

async function openCamera() {
	cameraActive.value = true;
	await CameraPreview.start(cameraOptions);
}

async function recordAgain() {
	timer.value = 0;
	play.value = false;
	recordVideo();
}

async function flipCamera() {
	await CameraPreview.flip();
}

async function fetchPlace(coordinates) {
	const response = await fetch(
		`https://api.mapbox.com/geocoding/v5/mapbox.places/${coordinates.longitude},${coordinates.latitude}.json?access_token=pk.eyJ1Ijoib3dlbmdvdCIsImEiOiJjbDcyNzFwMGwwaG5lM29uOWI3dTVsM2ZqIn0.4xI9UmoEHiQHFJ8C9mEvNg`
	);

	const place = await response.json();
	console.log(place);
	return place.features[4].place_name;
}

async function createResponse(item, position, stepId) {
	console.log(item);
	console.log(position);
	console.log(stepId);
	const { data, error } = await supabase
		.from('response')
		.insert([
			{
				creator: store.user.account.id,
				programme_response_id: item.programme_response_id,
				step_id: stepId,
				url: item.url,
				geo_lat: position.coords.latitude || '',
				geo_long: position.coords.longitude || ''
			}
		])
		.select();

	console.log(error);
	console.log(data);
	return data;
}

async function createStep(id) {
	const { data, error } = await supabase
		.from('step')
		.insert([{ project_id: id, programme_step_id: steps[0].id, submitter: store.user.account.id }])
		.select();

	console.log(error);
	console.log(data);
	return data;
}

function profile() {
	if (store.user.account) {
		return store.getUser(store.user.account.id)[0];
	} else return false;
}

async function createProject() {
	const projectId = `${store.user.account.id}-${Date.now()}`;
	const position = await Geolocation.getCurrentPosition();
	const place = await fetchPlace(position.coords);
	const projectName = action.name.split(' ')[0] + '-' + profile().fullname.toLowerCase().replace(' ', '-');
	const { data, error } = await supabase
		.from('project')
		.insert([
			{
				programme_id: action.id,
				name: projectName,
				geo_lat: position.coords.latitude,
				geo_long: position.coords.longitude,
				location_name: place
			}
		])
		.select();
	const project_id = data[0].id;
	const step = await createStep(project_id);
	const stepId = step[0].id;

	for (let i = 0; i < responses.value.length; i++) {
		createResponse(responses.value[i], position, stepId);
	}

	console.log(data);
	console.log(error);
	console.log(step);
	await store.fetchProjects();
	await store.fetchSteps();
	await store.fetchRoles();
	router.push(`/apply/result/${data[0].id}`);
}

// const result = await CameraPreview.capture(cameraOptions);
// const base64PictureData = result.value;
async function finish(index) {
	const resp = {
		programme_response_id: questions[index].id,
		url: dummyVideos[index]
	};
	responses.value.push(resp);
	await createProject();
}

onIonViewWillEnter(() => {
	openCamera();
	timer.value = 0;
	video.value = false;

	Filesystem.readdir({
		path: VIDEO_DIR,
		directory: Directory.Data
	}).then(
		result => {
			console.log(result.files);
		},
		async err => {
			// Folder does not yet exists!
			await Filesystem.mkdir({
				path: VIDEO_DIR,
				directory: Directory.Data
			});
		}
	);
});

onIonViewWillLeave(() => {
	splide.value.go(0);
	cameraActive.value = false;
	timer.value = 0;
	video.value = false;
	CameraPreview.stop();
});
</script>

<style scoped>
.record_button {
	@apply button inline-flex items-stretch justify-center mx-auto block rounded-full text-white bg-white/10;
	bottom: 10px;
	width: 220px;
	overflow: hidden;
	height: 50px;
	transition: all 0.3s ease;
}

.record_button.next {
	@apply bg-green-600 px-3;
}

.record_button .start {
	opacity: 1;
	transition: opacity 2.75s ease;
	overflow: hidden;
	white-space: nowrap;
}

.record_button.active {
	@apply bg-red-600 mx-auto;
	width: 120px;
	transition: all 0.7s ease;
}

.record_button.active .start {
	display: none;
	opacity: 0;
	transition: opacity 0.75s ease;
}
/* .my-custom-camera-preview-content {
	--background: transparent;
} */
#cameraPreview {
	width: 100%;
	height: 400px;
	position: relative;
	z-index: 10;
}

#videoPreview {
	width: 100%;
	height: 400px;
	position: relative;
	z-index: 10;
}

#videoPreview video {
	@apply absolute w-full h-full top-0 left-0;
	object-fit: cover !important;
}

.video-overlay {
	@apply w-full z-20 bg-black/80 absolute top-0 flex flex-col items-center justify-center;
	height: 400px;
	opacity: 0;
	transform: scale(0.8);
}

.video-overlay.active {
	opacity: 1;
	transform: scale(1);
	transition: all 0.18s ease-out;
}

.icons {
	position: relative;
}
.overlay {
	@apply w-full bg-gray-600 py-0 relative;
	width: 100%;
	z-index: 20;
}
.image-overlay {
	margin: 0;
	width: 46px;
	height: 46px;
}
#flashCamera {
	position: absolute;
	right: 1%;
	--ionicon-stroke-width: 36px;
}
#flipCamera {
	position: absolute;
	bottom: 3%;
	right: 3%;
	--ionicon-stroke-width: 46px;
}
#closeCamera {
	position: absolute;
	left: 1%;
	--ionicon-stroke-width: 46px;
}
#cameraCapture {
	position: absolute;
	left: 50%;
	bottom: 3%;
	--ionicon-stroke-width: 46px;
}
ion-icon {
	font-size: 64px;
	color: white;
}
</style>
