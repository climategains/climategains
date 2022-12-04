import { createRouter, createWebHistory } from '@ionic/vue-router';
// eslint-disable-next-line import/no-unresolved
import routes from '~pages';
console.log(routes);
const router = createRouter({
	history: createWebHistory(import.meta.env.BASE_URL),
	routes,
});

export default router;
