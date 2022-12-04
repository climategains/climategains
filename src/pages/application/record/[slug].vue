<template>
	<base-view>
		<template #default-view-title> Climate Action </template>
		<template #default-view-body>
			<ion-content class="ion-padding">
				<div class="videoContainer" v-if="loaded">
					<video class="video" :srcObject="stream" width="400" height="600" autoplay></video>
					<div class="controls">
						<div class="record" @click="recordVideo()" :class="{ active: recording }"></div>

						<Transition name="slide-fade">
							<span class="timer" v-show="recording">{{ recTime(timer) }} </span>
						</Transition>
					</div>
				</div>
				<div class="px-4">
					<div class="mx-6 text-center" v-if="qIndex - 1 < questions.length">
						<h1 class="mb-0">Question {{ qIndex }}/{{ action.application.questions.length }}</h1>
						<p class="font-light text-2xl mt-2 mb-3">{{ questions[qIndex - 1].text }}</p>
					</div>

					<div v-else class="mx-0 text-center">
						<h1 class="mb-0">Security Question</h1>
						<p class="font-light text-2xl mt-2 mb-3">
							Repeat this phrase: the quick young fox jumps over the lazy dog.
						</p>
						<p class="italic mt-0">By sending, you agree to the <u>terms and conditions</u>.</p>
					</div>

					<div class="flex items-center justify-center mt-3">
						<div class="px-4 py-2 border border-white rounded-lg" v-if="qIndex - 1 < questions.length" @click="nextQ()">
							Next
						</div>

						<RouterLink class="button action" v-else to="../result">Send Video for Approval</RouterLink>
					</div>
				</div>
			</ion-content>
		</template>
	</base-view>
</template>
<script setup async>
import { ref, onMounted, onBeforeUnmount } from 'vue';
import { useRoute } from 'vue-router';
import actions from '../../../json/actions.json';

const route = useRoute();

const path = route.params.slug;

const action = actions.response.filter(x => x.id === route.params.slug)[0];

const questions = action.application.questions;
const qIndex = ref(1);

const stream = ref(null);
const next = ref(false);
const recording = ref(false);
const timer = ref(0);
const loaded = ref(false);
const constraints = {
	audio: false,
	video: {
		width: 720,
		height: 1080,
		facingMode: 'environment'
	}
};

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
			next.value = true;
		} else {
			timer.value++;
		}
	}, 1000);
}

function nextQ() {
	recording.value = false;
	qIndex.value++;
}

onMounted(async () => {
	qIndex.value = 1;
	loaded.value = true;
	stream.value = await navigator.mediaDevices.getUserMedia(constraints);
});
onBeforeUnmount(() => {
	qIndex.value = 1;
	stream.value.getTracks().forEach(track => track.stop());
	stream.value = null;
	next.value = false;
	timer.value = 0;
	loaded.value = false;
});
</script>

<style>
.record {
	@apply bg-red-600 h-10 w-10;
	border-radius: 100%;
	transition: all 0.3s ease-out;
}
.record.active {
	@apply h-6 w-6 border-2 border-white/10;
	border-radius: 3px;
}

.button {
	border: none;
	padding: 0;
	margin: 0;
	text-decoration: none;
}
.button.action:hover,
.button.action.active {
	cursor: pointer;
}
.button.action {
	@apply rounded-full bg-gray-200 text-lg px-6 py-3 flex items-center font-bold text-black;
}

.button.action.active {
	@apply bg-black;
}
.slide-fade-enter-active {
	transition: all 0.3s ease-out;
}

.slide-fade-leave-active {
	transition: all 0.3s cubic-bezier(1, 0.5, 0.8, 1);
}

.slide-fade-enter-from,
.slide-fade-leave-to {
	transform: translateX(20px);
	opacity: 0;
}

.timer {
	@apply rounded-full bg-black/20 px-4 py-2 ml-3 text-white font-bold;
}

.ion-padding {
	position: relative;
}
/* function */
@keyframes ripple {
	from {
		transform: scale(1);
	}
	to {
		transform: scale(1.02);
	}
}
.video {
	height: 100% !important;
	width: 100%;
	top: 0;
	position: absolute;
	left: 0;
	z-index: -1;
	object-fit: cover;
}
.videoContainer {
	width: 100%;
	height: 400px;
	position: relative;
}
.videoContainer .controls {
	@apply py-4 justify-center items-center;
	position: absolute;
	z-index: 100;
	bottom: 0px;
	display: flex;
	backdrop-filter: blur(10px);
	-webkit-backdrop-filter: blur(10px);
	background: rgba(82, 82, 82, 0.3);
	width: 100%;
}
</style>
