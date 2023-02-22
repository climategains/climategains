<script setup lang="ts">
import { IonApp, IonRouterOutlet } from '@ionic/vue';
import '@splidejs/vue-splide/css/core';
import useStore from './stores/main';

const store = useStore();

store.fetchProgrammes();
store.fetchProjects();
store.fetchSteps();
store.fetchUsers();
store.fetchQuestions();
store.fetchMedia();
</script>

<template>
	<ion-app>
		<ion-router-outlet />
	</ion-app>
</template>
<style>
body {
	background: rgba(40, 40, 40, 0.9) !important;
}
#app {
	position: relative;
	height: 90vh;
	border-radius: 20px;
	display: block;
	max-width: 450px;
	margin: 50px auto;
}
</style>
