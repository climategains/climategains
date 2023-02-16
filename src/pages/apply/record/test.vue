<template>
	<base-view>
		<template #default-view-title> Climate Action </template>
		<template #default-view-body>
			<ion-header>
				<ion-toolbar>
					<ion-title>Vue Video Capture</ion-title>
				</ion-toolbar>
			</ion-header>
			<ion-content class="ion-padding">
				<ion-button @click="takeVideo">Take Videos</ion-button>
				<p>{{ test }}</p>
			</ion-content>
		</template>
	</base-view>
</template>
<script setup async>
import { ref } from 'vue';
import { VideoCapturePlus } from '@ionic-native/video-capture-plus';
let test = ref('hello');
async function takeVideo() {
	const options = {
		limit: 1,
		landscapeOverlay: 'https://via.placeholder.com/350x150',
		portraitOverlay: 'https://via.placeholder.com/350x150'
	};
	const video = await VideoCapturePlus.captureVideo(options);
	test.value = video;
}
</script>

<style>
#app {
	font-family: Avenir, Helvetica, Arial, sans-serif;
	-webkit-font-smoothing: antialiased;
	-moz-osx-font-smoothing: grayscale;
	text-align: center;
	color: #2c3e50;
	margin-top: 60px;
}
</style>
