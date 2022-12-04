<script setup lang="ts">
import { useRouter } from 'vue-router';

const router = useRouter();
</script>

<template>
	<ion-header>
		<ion-toolbar class="px-1">
			<ion-buttons slot="end">
				<ion-button @click="$emit('on-close')" class="text-white">&#10005;</ion-button>
			</ion-buttons>
			<ion-title>Sign In</ion-title>
		</ion-toolbar>
	</ion-header>
	<ion-content class="px-2 text-center">
		<div class="flex items-center flex-col h-full justify-center">
			<h2 class="pr-3 border-b pb-2 text-center pl-0 mx-4 border-gray-200">
				To record a video, you first have to sign in
			</h2>
			<input class="w-3/4 mx-4 p-4 rounded border border-gray-100 text-md font-bold" placeholder="Your email address" />
			<input class="w-3/4 mx-4 p-4 rounded border border-gray-100 text-md font-bold" placeholder="Password" />
			<button class="bg-blue-500 text-white p-4 py-2 mt-4 text-xl">Sign In</button>
		</div>
	</ion-content>
</template>
