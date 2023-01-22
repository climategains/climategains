<script setup lang="ts">
import { ref } from 'vue';

import { IonButton, IonModal } from '@ionic/vue';

import AboutComponent from 'components/about/AboutComponent.vue';
import { Swiper, SwiperSlide } from 'swiper/vue';

// Import Swiper styles
import 'swiper/css';

import { useRouter } from 'vue-router';

const router = useRouter();

const modalIsOpen = ref(false);
const showModal = () => {
	modalIsOpen.value = true;
};
</script>
<template>
	<base-view>
		<template #default-view-title> Become an Activist </template>
		<template #default-view-body>
			<!-- <swiper
    :slides-per-view="1"
    :space-between="50"
  >
    <swiper-slide>Slide 1</swiper-slide>
    <swiper-slide>Slide 2</swiper-slide>
    <swiper-slide>Slide 3</swiper-slide>
    ...
  </swiper> -->

			<div class="px-4 pt-4">
				<h1 class="text-center mt-3 text-3xl">By joining us you..</h1>

				<ul class="text-xl font-light leading-tight">
					<li class="advantage">
						<svg
							class="w-6 bg-blue-600 p-3 rounded-full h-6 mr-6"
							xmlns="http://www.w3.org/2000/svg"
							viewBox="0 0 329 202">
							<g fill="#fff" fill-rule="nonzero">
								<path
									d="m303 119-66 19c1 7 0 14-3 20-4 6-10 11-16 13-8 2-15 1-21-2l-38-22 3-6 38 21c5 3 10 4 15 2s10-5 12-9l2-8c1-7-2-14-8-17l-92-52s-9-6-22-2L1 106H0l20 71 68-19 63 39c11 7 25 3 28 2l135-38c9-3 17-15 13-28-2-10-13-17-24-14Z" />
								<path
									d="M302 0c-111 13-79 83-68 103l29-47-3-17 6 13c6-8 13-16 18-20 0 0-17 28-30 53l20-1-23 7-7 16C352 99 302 0 302 0Z" />
								<path
									d="M161 21c75 9 53 56 45 69l-19-31 2-11-4 8c-4-6-8-11-12-13l20 35h-14l16 5 4 11c-72-7-38-73-38-73Z" />
							</g>
						</svg>

						<p>Can generate an income through positive actions</p>
					</li>
					<li class="advantage">
						<svg
							width="306px"
							height="241px"
							class="w-6 bg-purple-700 p-3 rounded-full h-6 mr-6"
							viewBox="0 0 306 241"
							version="1.1"
							xmlns="http://www.w3.org/2000/svg"
							xmlns:xlink="http://www.w3.org/1999/xlink">
							<g id="Page-1" stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
								<g id="noun-home-1507312" transform="translate(0.680000, 0.280000)" fill="#fff" fill-rule="nonzero">
									<path
										d="M151.76,0 L2.84217094e-14,101.92 L12.879,120.959 L43.117,100.799 L43.117,240.239 L262.637,240.239 L262.640906,101.919 L292.320906,121.521 L305.199906,101.919 L151.76,0 Z M192.08,157.36 C185.9198,168.001 155.682,196.559 153.439,199.36 C150.0796,196.0006 120.4,168.001 114.798,157.919 C114.798,157.919 99.118,138.88 114.798,124.88 C114.798,124.88 137.196,105.841 153.439,131.5988 C169.677,105.8368 192.08,124.88 192.08,124.88 C207.76,138.88 192.08,157.36 192.08,157.36 Z"
										id="Shape"></path>
								</g>
							</g>
						</svg>

						<p>Improve the quality of life and resiliency of your community</p>
					</li>
					<!-- <li class="advantage">
						<svg class="w-12 h-12 mr-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 549 550">
							<g fill="#000" fill-rule="nonzero">
								<path
									d="M275 549c-13 0-23-12-32-23-5-6-11-14-15-15s-13 5-21 9c-12 6-25 14-37 9-13-5-17-20-20-33-3-8-5-18-9-21-3-2-14-1-22 0-14 2-29 4-38-6-9-9-8-24-6-38 1-8 2-18 0-22-2-3-12-6-20-8-14-4-28-8-33-20s2-25 9-38c3-8 9-17 8-21s-9-11-15-15c-11-9-23-19-23-32s12-23 23-32c6-5 14-11 15-15 1-5-5-13-9-21-6-12-14-25-9-37 5-13 20-17 33-20 8-3 18-5 21-9 2-3 1-14 0-22-2-14-4-29 6-38 9-9 24-8 38-6 8 1 18 2 22 0 3-2 6-12 8-20 4-14 8-28 20-33s25 2 38 9c8 3 17 9 21 8s11-9 15-15c9-11 19-23 32-23s23 12 32 23c5 6 11 14 15 15s13-5 21-9c12-6 25-14 37-9 13 5 17 20 20 33 3 8 5 18 9 21 3 2 14 1 22 0 14-2 29-4 38 6 9 9 8 24 6 38-1 8-2 18 0 22 2 3 12 6 20 8 14 4 28 8 33 20s-2 25-9 38c-4 6-9 16-8 20 0 4 9 11 15 16 11 8 23 18 23 31 0 14-12 23-23 32-6 5-15 12-15 15-1 4 4 14 8 21 7 13 14 25 9 38-5 12-19 16-33 20-7 2-18 5-20 8-2 4-1 14 0 22 2 14 3 29-6 38-10 10-24 8-38 6-8-1-19-2-22 0-4 3-6 13-9 21-3 14-7 28-20 33-12 5-25-3-37-9-7-4-16-9-21-9-4 1-11 9-15 15-9 12-19 24-32 24Zm-48-57h5c11 3 19 13 27 23 5 6 12 15 16 15s12-9 16-15c8-10 16-20 27-23 11-2 23 4 34 11 6 3 17 9 20 8 4-2 7-13 9-21 4-12 8-25 17-31s22-5 35-3c7 0 20 2 22-1 3-2 1-15 1-22-2-13-3-26 3-35 6-10 19-13 31-17 8-2 19-5 21-9 1-3-5-14-8-20-6-11-13-23-11-34 3-11 13-19 23-27 6-5 15-12 15-16s-9-12-15-16c-10-8-20-16-23-27-2-11 4-23 11-34 3-6 9-17 8-20-2-4-13-7-21-9-12-4-25-8-31-17s-5-22-3-35c0-7 2-20-1-22-2-3-15-1-22-1-13 2-26 3-35-3-10-6-13-19-17-31-2-8-5-19-9-21-3-1-14 5-20 8-11 6-23 13-34 11-11-3-19-13-27-23-5-6-12-15-16-15s-12 9-16 15c-8 10-16 20-27 23-11 2-23-4-34-11-6-3-17-9-20-8-4 2-7 13-9 21-4 12-8 25-17 31s-22 5-35 3c-7 0-20-2-22 1-3 2-1 15-1 22 2 13 3 26-3 35-6 10-19 13-31 17-8 2-19 5-21 9-1 3 5 14 8 20 6 11 13 23 11 34-3 11-13 19-23 27-6 5-15 12-15 16s9 12 15 16c10 8 20 16 23 27 2 11-4 23-11 34-3 6-9 17-8 20 2 4 13 7 21 9 12 4 25 8 31 17s5 22 3 35c0 7-2 20 1 22 2 3 15 1 22 1 13-2 26-3 35 3 10 6 13 19 17 31 2 8 5 19 9 21 3 1 14-5 20-8 9-6 19-11 29-11Z" />
								<path
									stroke="black"
									stroke-width="6px"
									d="m442 238-68 44v3l-2 8-1 9-23-19-55-43c-7-5-17-6-28-2 0 0-9 3-15 7l-40 27c-7 4-16 2-21-4-4-7-3-13-2-14l94-60c10-7 35 10 48 18l4 3 66-44-8-12-58 37c-18-11-36-21-50-18l-15-13c-15-12-39-3-62 9l-32-25-5 15 35 29 4-2c13-7 41-21 50-13l9 7-89 57c-9 6-11 21-3 34l1 2 3 3c8 8 19 15 29 11l52-34s17-10 25-5l83 66c4 3 4 9 2 13-4 4-10 5-15 1l-81-64-10 13 91 71c3 3 4 8 1 12s-8 4-12 1l-6-4-2-2-79-64-10 13 80 63c3 3 4 9 1 12-3 4-9 5-13 2l-35-28-36-29-9 13 36 28c3 3 4 9 1 13-3 3-9 4-13 1l-28-22-61-49c-10-8-11-30-12-45l-1-9v-3l-43-34-7 14 35 28v4c1 15 2 35 11 49-10 8-12 22-5 32 3 4 6 7 10 9-5 8-5 17 0 25l1 1c5 7 14 11 22 10a25 25 0 0 0 38 19l19-13v1l10-7 2 3c11 8 27 6 35-4l4-8 17 14c11 8 27 6 35-4 3-4 4-7 5-11 9 1 17-1 23-8l1-1c5-8 6-17 2-25 4-2 8-4 12-8 6-8 6-18 2-26l4-20v-4l63-41-11-13ZM160 341c-3-4-2-9 2-12l2-1 16 13-6 3c-4 3-11 2-14-3Zm22 36c-4 3-9 2-12-2s-1-9 3-12l19-12 14 11-24 15Zm27 23c-5 3-10 2-12-3-3-4-2-9 2-12l20-13 2 2 13 10-25 16Z" />
							</g>
						</svg>
						<p>Make your community more resilient</p>
					</li> -->
					<li class="advantage">
						<svg
							class="w-6 bg-green-600 p-3 rounded-full h-6 mr-6"
							xmlns="http://www.w3.org/2000/svg"
							viewBox="0 0 319 256">
							<g fill="#fff" fill-rule="nonzero">
								<path
									d="m294 176-64 18v1c2 6 1 13-3 19-3 6-9 10-15 13-7 1-14 1-21-3l-37-20 4-7 37 21c4 3 9 4 14 2s9-5 12-9l2-7c1-7-2-13-8-17l-89-49s-10-7-22-3L1 164H0l20 68 64-18 62 38c11 6 25 3 27 2l132-38c9-2 17-14 13-26-3-11-14-17-24-14ZM230 0a74 74 0 1 0 0 148 74 74 0 0 0 0-148Zm-28 114c-3 3-5 7-6 11-7-5-14-12-19-19 4-2 9-4 15-9 7-6 9-12 9-17-2-7-10-9-10-9l-1-1 5-5c6-4 9-8 10-13 0-9-9-16-9-16l-8-7a60 60 0 0 1 55-14c-3 1-5 2-6 4-4 3-5 8-4 13 1 6 3 10 8 13l6 1c-12 2-29 8-29 20 0 3 2 6 4 8 9 8 31 6 35 6h1s9-2 12 4c3 9 12 11 17 11-4 12-12 22-23 30-2-4-4-7-7-8h-3c-1-5-3-9-6-11-2-2-4-3-7-2-5 0-10 3-12 12-5-4-11-5-12-5-6-1-12 0-15 3Z" />
							</g>
						</svg>

						<p>Improve global living conditions now and for our planet's future</p>
					</li>
				</ul>
			</div>

			<ion-modal :is-open="modalIsOpen" @did-dismiss="modalIsOpen = false">
				<about-component @on-close="modalIsOpen = false" />
			</ion-modal>

			<div class="col-4 mx-auto text-center mt-3">
				<div class="action_button" @click="() => router.push('../activist/2')">Next</div>
			</div>
		</template>
	</base-view>
</template>
<style scoped>
.action_button {
	@apply py-2 bg-blue-600 rounded-full text-white w-full border-white/20 border-t text-center font-bold  text-lg capitalize;
}
.action_button:hover {
	@apply bg-blue-700;
	cursor: pointer;
}
.advantage {
	@apply flex justify-start items-center font-normal text-lg border-b p-6 pr-0 pb-4    border-gray-100/20 pl-0 pr-0;
}
.advantage p {
	@apply my-0 font-normal text-xl;
}

.advantage svg {
	@apply my-0;
	flex-shrink: 0;
}
.advantage:last-child {
	border: none;
}
</style>
