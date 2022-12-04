<script setup lang="ts">
import {
	IonRouterOutlet,
	IonPage,
	IonTabBar,
	IonTabButton,
	IonTabs,
	IonButtons,
	IonBackButton,
	IonHeader,
	IonContent,
	IonTitle,
	IonToolbar
} from '@ionic/vue';
import { personCircle, flame, home, search } from 'ionicons/icons';
import { ref } from 'vue';

const header = ref(false);
</script>

<template>
	<ion-page>
		<ion-content>
			<slot name="default-view-body"></slot>
		</ion-content>
		<ion-toolbar>
			<ion-tabs>
				<ion-router-outlet></ion-router-outlet>
				<ion-tab-bar slot="bottom">
					<ion-tab-button tab="home" href="./">
						<ion-icon :icon="home"></ion-icon>
					</ion-tab-button>

					<ion-tab-button tab="actions" href="/actions">
						<ion-icon :icon="flame"></ion-icon>
					</ion-tab-button>

					<ion-tab-button tab="account" href="/account">
						<ion-icon :icon="personCircle"></ion-icon>
					</ion-tab-button>

					<ion-tab-button tab="search" href="/search">
						<ion-icon :icon="search"></ion-icon>
					</ion-tab-button>
				</ion-tab-bar>
			</ion-tabs>
		</ion-toolbar>
	</ion-page>
</template>
