<script setup lang="ts">
import { IonContent, IonButtons, IonBackButton, IonPage, IonIcon, IonHeader, IonTitle, IonToolbar } from '@ionic/vue';
import { arrowForward } from 'ionicons/icons';
import { useRouter } from 'vue-router';

const router = useRouter();
</script>

<template>
	<ion-page>
		<slot name="default-head-view"> </slot>
		<ion-header class="ion-no-border">
			<div class="nav_forward flex items-center justify-start" @click="() => router.push('/account/')">
				<p class="ml-6 mr-2">My Account</p>
				<ion-icon :icon="arrowForward" />
			</div>
		</ion-header>

		<ion-content fullscreen>
			<slot name="default-view-body"></slot>
		</ion-content>
	</ion-page>
</template>

<style>
.nav_forward {
	@apply text-lg font-bold mr-6;
	font-family: Helvetica, Arial, sans-serif;
}
ion-toolbar {
	--box-shadow: none !important;
}
</style>
