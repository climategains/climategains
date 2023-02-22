<script lang="ts">
import { IonRouterOutlet, IonPage, IonTabBar, IonTabButton, IonTabs, IonContent, IonToolbar } from '@ionic/vue';

import { personCircleSharp, earthOutline, search, homeOutline } from 'ionicons/icons';
import { IonIcon } from '@ionic/vue';
import { defineComponent } from 'vue';
export default defineComponent({
	components: { IonIcon, IonRouterOutlet, IonPage, IonTabBar, IonTabButton, IonTabs, IonContent, IonToolbar },
	setup() {
		return {
			personCircleSharp,
			earthOutline,
			search,
			homeOutline
		};
	}
});
</script>
<template>
	<IonPage>
		<IonContent>
			<slot name="default-view-body"></slot>
		</IonContent>
		<IonToolbar>
			<IonTabs>
				<IonRouterOutlet></IonRouterOutlet>
				<IonTabBar slot="bottom">
					<IonTabButton tab="home" href="./">
						<IonIcon :icon="homeOutline"></IonIcon>
					</IonTabButton>

					<IonTabButton tab="list" href="/list">
						<IonIcon :icon="earthOutline"></IonIcon>
					</IonTabButton>

					<IonTabButton tab="account" href="/account">
						<IonIcon :icon="personCircleSharp"></IonIcon>
					</IonTabButton>

					<IonTabButton tab="search" href="/search">
						<IonIcon :icon="search"></IonIcon>
					</IonTabButton>
				</IonTabBar>
			</IonTabs>
		</IonToolbar>
	</IonPage>
</template>
