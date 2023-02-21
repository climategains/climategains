<script setup lang="ts">
import { IonContent, IonButtons, IonBackButton, IonPage, IonHeader, IonTitle, IonToolbar } from '@ionic/vue';
</script>

<template>
	<ion-page>
		<slot name="default-head-view"> </slot>
		<ion-header class="ion-no-border">
			<ion-toolbar>
				<ion-buttons slot="start">
					<ion-back-button default-href="home" color="white" type="medium"></ion-back-button>
				</ion-buttons>
				<ion-title>
					<slot name="default-view-title"></slot>
				</ion-title>
			</ion-toolbar>
		</ion-header>

		<ion-content fullscreen>
			<slot name="default-view-body"></slot>
		</ion-content>
	</ion-page>
</template>

<style>
ion-toolbar {
	--box-shadow: none !important;
}
</style>
