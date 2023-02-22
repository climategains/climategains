<script setup async lang="ts">
import { reactive, ref, onMounted } from 'vue';

import { Capacitor } from '@capacitor/core';

import { Filesystem, Directory, Encoding } from '@capacitor/filesystem';
import { onIonViewWillEnter, onIonViewWillLeave } from '@ionic/vue';

const files = ref(null);
const vidIndex = ref(3);

const videoPlayer = ref();

async function loadFiles() {
	const dir = Filesystem.readdir({
		path: '',
		directory: Directory.Cache
	});
	files.value = await dir;
	videoPlayer.value.load();
}

function getUrl(value) {
	return Capacitor.convertFileSrc(value);
}

function switchVid(value) {
	switch (value) {
		case 'next':
			vidIndex.value++;
			videoPlayer.value.load();
			break;
		case 'back':
			vidIndex.value--;
			videoPlayer.value.load();
			break;
		default:
		// code block
	}
}

onIonViewWillLeave(() => {
	files.value = null;
});

onIonViewWillEnter(() => {
	loadFiles();
});
</script>

<template>
	<tab-view>
		<template #default-view-title>
			<div class="text-center">Start</div>
		</template>
		<template #default-view-body>
			<div>
				<h2>ijskksadj</h2>
				<div class="w-full h-full absolute flex flex-col" v-if="files && files.files">
					<video
						ref="videoPlayer"
						v-if="files.files[vidIndex] && files.files[vidIndex].uri"
						width="220"
						height="240"
						controls>
						<source :src="getUrl(files.files[vidIndex].uri)" type="video/mp4" />
					</video>
					{{ files.files[vidIndex] }}
					<div class="bg-blue text-white p-3" @click="switchVid('back')">Back</div>
					<div class="bg-blue text-white p-3" @click="switchVid('next')">Next</div>
				</div>
			</div>
		</template>
	</tab-view>
</template>

<style scoped>
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
