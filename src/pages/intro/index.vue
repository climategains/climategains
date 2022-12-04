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
		<template #default-view-title> Climate Action </template>
		<template #default-view-body>
			<div class="flex flex-col justify-center items-center">
				<div class="intro">
					<div class="mx-auto leading-relaxed">
						<h1 class="text-center w-full leading-tight bg-white text-black text-2xl mx-auto flex px-3 py-3">
							Welcome to Climate Gains
						</h1>
					</div>
				</div>
				<p class="text-2xl text-center mt-10 px-6 pr-12 font-light">
					Climate Gains cuts out the middleman, putting the money in the hands of those doing the action and making it
					more accessible to those who don't have money to invest before being refunded.
				</p>
			</div>

			<div class="col-4 mx-auto text-center mt-1">
				<div class="action_button" @click="() => router.push('../intro/1')">Next</div>
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
.intro {
	height: 270px;
	width: 100%;

	display: flex;
	align-items: end;
	justify-content: flex-end;
	background-image: url('bg_1.jpg');
	background-size: cover !important;
}
.intro h1 {
	box-decoration-break: clone;
	-webkit-box-decoration-break: clone;
	display: inline;
}
</style>
