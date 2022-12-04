<template>
	<ion-page id="main-content">
		<ion-menu content-id="main-content">
			<ion-header>
				<ion-toolbar>
					<ion-title>Menu Content</ion-title>
				</ion-toolbar>
			</ion-header>
			<ion-content class="ion-padding">This is the menu content.</ion-content>
		</ion-menu>
		<ion-header>
			<ion-toolbar>
				<ion-buttons slot="start">
					<ion-menu-button></ion-menu-button>
				</ion-buttons>
				<ion-title>Menu</ion-title>
			</ion-toolbar>
		</ion-header>
		<ion-content :fullscreen="true">
			<ion-header collapse="condense">
				<ion-toolbar>
					<ion-title size="large">Tab 2</ion-title>
				</ion-toolbar>
			</ion-header>

			<ExploreContainer name="Tab 2 page" />
		</ion-content>
	</ion-page>
</template>

<script lang="ts">
import { defineComponent } from 'vue';
import { IonPage, IonHeader, IonToolbar, IonButtons, IonMenu, IonMenuButton, IonTitle, IonContent } from '@ionic/vue';
import ExploreContainer from '../components/ExploreContainer.vue';

export default defineComponent({
	name: 'Tab2Page',
	components: {
		ExploreContainer,
		IonHeader,
		IonToolbar,
		IonMenu,
		IonMenuButton,
		IonButtons,
		IonTitle,
		IonContent,
		IonPage
	}
});
</script>
