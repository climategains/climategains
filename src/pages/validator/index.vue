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
		<template #default-view-title>Climate Gains</template>
		<template #default-view-body>
			<div class="flex flex-col justify-center items-center">
				<div class="intro"></div>
				<div class="bg-white w-full text-center">
					<h1 class="text-black text-2xl px-3 py-3 my-0">Become a Validator</h1>
				</div>
				<p class="text-xl text-center mt-3 px-6 pr-12">
					Climate Gains connects local communities to pre-funded climate projects, putting the money in the hands of
					those doing the work and making climate action accessible to everyone.
				</p>
			</div>

			<div class="col-4 mx-auto text-center mt-1">
				<div class="action_button" @click="() => router.push('../validator/1')">Next</div>
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
