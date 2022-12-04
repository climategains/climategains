<script setup async lang="ts">
import { GoogleMap } from '@capacitor/google-maps';
import { onMounted } from 'vue';

const createMap = async () => {
	// eslint-disable-next-line @typescript-eslint/no-non-null-assertion
	const mapRef = document.getElementById('map')!;

	// eslint-disable
	const newMap = await GoogleMap.create({
		id: 'my-map', // Unique identifier for this map instance
		element: mapRef, // reference to the capacitor-google-map
		apiKey: 'AIzaSyDQ8DKueP1FZPFDMIGmpchHoEDRLC_9ejI', // Your Google Maps API Key
		config: {
			center: {
				// The initial position to be rendered by the map
				lat: 33.6,
				lng: -117.9
			},
			zoom: 8 // The initial zoom level to be rendered by the map
		}
	});

	await newMap.addMarker({
		coordinate: {
			lat: 33.6,
			lng: -117.9
		}
	});
};

onMounted(async () => {
	createMap();
});
</script>
<template>
	<ion-header>
		<ion-toolbar class="px-1">
			<ion-buttons slot="end">
				<ion-button @click="$emit('on-close')">&#10005;</ion-button>
			</ion-buttons>
			<ion-title>Sign In</ion-title>
		</ion-toolbar>
	</ion-header>
	<ion-content class="px-2 text-center">
		<capacitor-google-map id="map"></capacitor-google-map>
	</ion-content>
</template>
<style>
capacitor-google-map {
	display: inline-block;
	width: 100%;
	height: 100%;
}
</style>
