<script setup lang="ts">
import { ref } from 'vue';

import { IonButton, IonModal } from '@ionic/vue';

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
	<page-view>
		<template #default-view-title> Climate Gains </template>
		<template #default-view-body>
			<div class="flex flex-col justify-center items-center">
				<div class="intro"></div>
				<div class="bg-white w-full text-center">
					<h1 class="text-black text-2xl px-3 py-3 my-0">Become an Activist</h1>
				</div>
				<p class="text-xl text-center mt-3 px-10 pr-12">
					Climate Gains cuts out the middleman, putting the money in the hands of those doing the action and making it
					more accessible to those who don't have money to invest before being refunded.
				</p>
			</div>

			<div class="col-4 mx-auto text-center mt-1">
				<div class="action_button" @click="() => router.push('./activist/1')">Next</div>
			</div>
		</template>
	</page-view>
</template>
<style scoped>
.action_button {
	@apply py-2 flex items-center justify-center bg-blue-600 rounded-full text-white w-full border-white/20 border-t text-center font-bold  text-lg capitalize;
}
.action_button:hover {
	@apply bg-blue-700;
	cursor: pointer;
}
.intro {
	height: 270px;
	width: 100%;
	background-image: url('bg_1.jpg');
	background-size: cover !important;
}
</style>
