import { createApp } from 'vue';

import { createPinia } from 'pinia';

import { IonicVue } from '@ionic/vue';

import App from './App.vue';

import router from './router';

import 'core';

import VueSplide from '@splidejs/vue-splide';

import BaseView from './core/BaseView.vue';

import OppView from './core/BaseView.vue';

const app = createApp(App).use(createPinia()).use(IonicVue).use(VueSplide).use(router);

app.component('BaseView', BaseView);

app.component('OppView', OppView);



router.isReady().then(() => {
	app.mount('#app');
});
