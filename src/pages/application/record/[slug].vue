<template>
	<ion-page>
		<ion-content class="my-custom-camera-preview-content" :fullscreen="true">
			<div class="flex h-full flex-col items-stretch stretch">
				<div v-if="cameraActive" id="cameraPreview" class="grow-0 relative cameraPreview"></div>
				<div class="w-full overlay h-5 z-10 flex items-center justify-between py-3">
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
				<div class="w-full relative grow flex flex-col">
					<div class="flex items-center justify-center h-full w-full relative">
						<Splide
							ref="splide"
							v-if="questions"
							class="-mt-10 relative w-full"
							:options="{ autoHeight: true, drag: false, pagination: false, arrows: false }">
							<SplideSlide
								class="slide text-center pt-1 pb-6 px-10 flex items-center justify-center"
								v-for="(item, index) in questions"
								:key="index">
								<div class="w-full flex h-full flex-col items-center mx-auto">
									<h1 class="mb-0 text-2xl mb-1">{{ item.title[0].text }}</h1>
									<p class="text-xl mt-1 mb-3">{{ item.description[0].text }}</p>
									<div class="record_button" :class="{ active: recording }">
										<div
											@click="recordVideo()"
											v-if="!recording && !video"
											class="start w-full flex flex-col justify-center items-center">
											<span class="font-bold">Record My Answer</span>
											<!-- <span class="text-xs text-white/70">Maximum length is 2 minutes</span> -->
										</div>
										<div
											@click="nextQ(index)"
											v-if="!recording && video && index + 1 < questions.length"
											class="start w-full flex flex-col justify-center items-center">
											<span class="font-bold">Next Question</span>
										</div>
										<div
											@click="finish()"
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
import { IonPage, IonContent, IonButton, IonIcon } from '@ionic/vue';
import { closeOutline, cameraReverseOutline } from 'ionicons/icons';
import { CameraPreview } from '@capacitor-community/camera-preview';

import { ref, onMounted, onBeforeUnmount } from 'Vue';
import { useRoute, useRouter } from 'vue-router';

import '@splidejs/vue-splide/css';
import { Splide, SplideSlide } from '@splidejs/vue-splide';

const route = useRoute();
const router = useRouter();

const cameraActive = ref(false);
const qIndex = ref(1);
const recording = ref(false);
const video = ref(false);
const action = ref(null);
const questions = ref(null);
const timer = ref(0);
const splide = ref();

function recTime(time) {
	var minutes = Math.floor(time / 60);
	var seconds = time - minutes * 60;

	function str_pad_left(string, pad, length) {
		return (new Array(length + 1).join(pad) + string).slice(-length);
	}

	return str_pad_left(minutes, '0', 2) + ':' + str_pad_left(seconds, '0', 2);
}

function recordVideo() {
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
}

function nextQ(index) {
	video.value = false;
	timer.value = 0;
	splide.value.go(index + 1);
}

async function openCamera() {
	cameraActive.value = true;
	const cameraPreviewPictureOptions = {
		position: 'front',
		height: 400,
		parent: 'cameraPreview',
		className: 'cameraPreview'
	};
	await CameraPreview.start(cameraPreviewPictureOptions);
}
async function stopCamera() {
	await CameraPreview.stop();
	cameraActive.value = false;
}

async function finish() {
	await CameraPreview.stop();
	cameraActive.value = false;
	router.push(`../result`);
}
async function flipCamera() {
	await CameraPreview.flip();
}

async function getActions() {
	const response = await fetch('https://api.climategains.org/api/v1/countries', {
		method: 'GET',
		headers: {
			'x-api-key': 'rpA94jzJjrBh9IclvNKvM34xhHwo282g7qZ6mJ0sKITOBy39',
			'Content-Type': 'application/json; charset=utf-8'
		}
	});
	const actions = await response.json();
	// const act = actions.data.filter(x => x.id === route.params.slug)[0];
	const act = actions.data.filter(x => x.id === '638f6a7d5020beaf162c3b17')[0];
	action.value = act;
	questions.value = act.settings.project.steps[0].content;
}

onMounted(async () => {
	await getActions();
	await openCamera();
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
.my-custom-camera-preview-content {
	--background: transparent;
}
#cameraPreview {
	width: 100%;
	height: 400px;
	position: relative;
	z-index: 10;
}

.icons {
	position: relative;
}
.overlay {
	@apply w-full bg-white/30 py-0 relative;
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
