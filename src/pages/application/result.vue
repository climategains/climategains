<template>
	<opp-view>
		<template #default-view-body>
			<ion-content class="ion-padding">
				<div class="bg-black">
					<div class="success banner">
						<svg
							id="successAnimation"
							class="animated mr-2"
							xmlns="http://www.w3.org/2000/svg"
							width="40"
							height="40"
							viewBox="0 0 70 70">
							<path
								id="successAnimationResult"
								fill="#D8D8D8"
								d="M35,60 C21.1928813,60 10,48.8071187 10,35 C10,21.1928813 21.1928813,10 35,10 C48.8071187,10 60,21.1928813 60,35 C60,48.8071187 48.8071187,60 35,60 Z M23.6332378,33.2260427 L22.3667622,34.7739573 L34.1433655,44.40936 L47.776114,27.6305926 L46.223886,26.3694074 L33.8566345,41.59064 L23.6332378,33.2260427 Z" />
							<circle
								id="successAnimationCircle"
								cx="35"
								cy="35"
								r="24"
								stroke="#979797"
								stroke-width="3"
								stroke-linecap="round"
								fill="transparent" />
							<polyline
								id="successAnimationCheck"
								stroke="#979797"
								stroke-width="3"
								points="23 34 34 43 47 27"
								fill="transparent" />
						</svg>
						<h3 class="text-white text-xl font-bold bg-bold">Application Sent</h3>
					</div>

					<div class="w-full flex items-center mt-0 mb-0 bg-white/10">
						<h3 class="text-xl text-white w-full pl-5 my-0 text-center font-bold mx-auto flex items-center py-4">
							<svg
								xmlns="http://www.w3.org/2000/svg"
								fill="none"
								viewBox="0 0 24 24"
								stroke-width="1"
								stroke="currentColor"
								class="w-8 h-8 mr-2">
								<path
									stroke-linecap="round"
									stroke-linejoin="round"
									d="M11.35 3.836c-.065.21-.1.433-.1.664 0 .414.336.75.75.75h4.5a.75.75 0 00.75-.75 2.25 2.25 0 00-.1-.664m-5.8 0A2.251 2.251 0 0113.5 2.25H15c1.012 0 1.867.668 2.15 1.586m-5.8 0c-.376.023-.75.05-1.124.08C9.095 4.01 8.25 4.973 8.25 6.108V8.25m8.9-4.414c.376.023.75.05 1.124.08 1.131.094 1.976 1.057 1.976 2.192V16.5A2.25 2.25 0 0118 18.75h-2.25m-7.5-10.5H4.875c-.621 0-1.125.504-1.125 1.125v11.25c0 .621.504 1.125 1.125 1.125h9.75c.621 0 1.125-.504 1.125-1.125V18.75m-7.5-10.5h6.375c.621 0 1.125.504 1.125 1.125v9.375m-8.25-3l1.5 1.5 3-3.75" />
							</svg>

							Application Status
						</h3>
					</div>

					<div class="font-bold text-md text-white bg-orange-500 py-3 flex items-center justify-start pl-6">
						<svg
							xmlns="http://www.w3.org/2000/svg"
							fill="none"
							viewBox="0 0 24 24"
							stroke-width="1.5"
							stroke="currentColor"
							class="w-4 h-4 mr-2">
							<path
								stroke-linecap="round"
								stroke-linejoin="round"
								d="M16.023 9.348h4.992v-.001M2.985 19.644v-4.992m0 0h4.992m-4.993 0l3.181 3.183a8.25 8.25 0 0013.803-3.7M4.031 9.865a8.25 8.25 0 0113.803-3.7l3.181 3.182m0-4.991v4.99" />
						</svg>

						Under Review · Wait Time: 2 days
					</div>
					<p class="pt-0 pb-1 mt-3 px-6 text-xl text-white">
						Green School Project has received your interest, and validators are now reviewing your video.
					</p>

					<div class="w-full flex items-center mt-0 mb-0 bg-white/10">
						<h3 class="text-xl text-white w-full pl-5 my-0 text-center font-bold mx-auto flex items-center py-4">
							<svg
								xmlns="http://www.w3.org/2000/svg"
								fill="none"
								viewBox="0 0 24 24"
								stroke-width="1"
								stroke="currentColor"
								class="w-8 h-8 mr-2">
								<path
									stroke-linecap="round"
									stroke-linejoin="round"
									d="M11.35 3.836c-.065.21-.1.433-.1.664 0 .414.336.75.75.75h4.5a.75.75 0 00.75-.75 2.25 2.25 0 00-.1-.664m-5.8 0A2.251 2.251 0 0113.5 2.25H15c1.012 0 1.867.668 2.15 1.586m-5.8 0c-.376.023-.75.05-1.124.08C9.095 4.01 8.25 4.973 8.25 6.108V8.25m8.9-4.414c.376.023.75.05 1.124.08 1.131.094 1.976 1.057 1.976 2.192V16.5A2.25 2.25 0 0118 18.75h-2.25m-7.5-10.5H4.875c-.621 0-1.125.504-1.125 1.125v11.25c0 .621.504 1.125 1.125 1.125h9.75c.621 0 1.125-.504 1.125-1.125V18.75m-7.5-10.5h6.375c.621 0 1.125.504 1.125 1.125v9.375m-8.25-3l1.5 1.5 3-3.75" />
							</svg>

							My Contract
						</h3>
					</div>

					<p class="pt-0 pb-1 mt-3 px-6 text-xl text-white">
						You can download the terms and conditions of your contract below. These are also for later consultation in
						your profile settings page under 'My Documents'.

						<button
							class="py-2 px-3 bg-blue-700 text-base text-white border-none rounded-full mt-3 flex items-center justify-center mt-0 mb-3 font-bold">
							<svg
								xmlns="http://www.w3.org/2000/svg"
								fill="none"
								viewBox="0 0 24 24"
								stroke-width="2"
								stroke="currentColor"
								class="w-5 h-5 mr-2">
								<path
									stroke-linecap="round"
									stroke-linejoin="round"
									d="M9 12.75l3 3m0 0l3-3m-3 3v-7.5M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
							</svg>
							Download PDF
						</button>
					</p>

					<div class="w-full flex items-center mt-0 mb-0 bg-white/10">
						<h3 class="text-xl text-white w-full pl-5 my-0 text-center font-bold mx-auto flex items-center py-4">
							<svg
								xmlns="http://www.w3.org/2000/svg"
								fill="none"
								viewBox="0 0 24 24"
								stroke-width="1"
								stroke="currentColor"
								class="w-8 h-8 mr-2">
								<path
									stroke-linecap="round"
									stroke-linejoin="round"
									d="M11.35 3.836c-.065.21-.1.433-.1.664 0 .414.336.75.75.75h4.5a.75.75 0 00.75-.75 2.25 2.25 0 00-.1-.664m-5.8 0A2.251 2.251 0 0113.5 2.25H15c1.012 0 1.867.668 2.15 1.586m-5.8 0c-.376.023-.75.05-1.124.08C9.095 4.01 8.25 4.973 8.25 6.108V8.25m8.9-4.414c.376.023.75.05 1.124.08 1.131.094 1.976 1.057 1.976 2.192V16.5A2.25 2.25 0 0118 18.75h-2.25m-7.5-10.5H4.875c-.621 0-1.125.504-1.125 1.125v11.25c0 .621.504 1.125 1.125 1.125h9.75c.621 0 1.125-.504 1.125-1.125V18.75m-7.5-10.5h6.375c.621 0 1.125.504 1.125 1.125v9.375m-8.25-3l1.5 1.5 3-3.75" />
							</svg>

							Next Steps
						</h3>
					</div>

					<Splide class="pb-0 mt-4" :options="{ autoHeight: true }">
						<SplideSlide>
							<div class="rounded-xl bg-white/10 mx-4 my-0 px-10 mb-2 pt-2 pb-6 flex-col">
								<p class="font-bold mb-3 text-xl py-3 border-b border-white/20 mx-auto text-left">
									Verify your payment settings
								</p>
								<div class="text-left text-xl px-0">
									Verify your payment information in Profile Settings. The first payment (€270) will be transferred into
									this account.
								</div>
								<button
									class="py-2 px-4 mt-4 bg-blue-700 text-base text-white border-none rounded-full flex items-center justify-center mb-3 font-bold">
									My Payment Settings
								</button>
							</div>
						</SplideSlide>
						<SplideSlide>
							<div class="rounded-xl bg-white/10 mx-4 my-0 px-10 mb-2 pt-2 pb-6 flex-col">
								<p class="font-bold mb-3 text-xl py-3 border-b border-white/20 mx-auto text-left">View Actions</p>
								<div class="text-left text-xl px-0">
									You get increasing amounts of money for each step you complete! Once you show us that you have
									completed step 2, you will receive €400. For the final step, you will receive €1000.
								</div>
								<button
									class="py-2 px-4 mt-4 bg-blue-700 text-base text-white border-none rounded-full flex items-center justify-center mb-3 font-bold">
									My Action Steps
								</button>
							</div>
						</SplideSlide>
						<SplideSlide>
							<div class="rounded-xl bg-white/10 mx-4 my-0 px-10 mb-2 pt-2 pb-6 flex-col">
								<p class="font-bold mb-3 text-xl py-3 border-b border-white/20 mx-auto text-left">Suppliers</p>
								<div class="text-left text-xl px-0">
									Check the List of Potential Suppliers that have the materials you need for this task. You can also
									input a new supplier if you already have someone you trust.
								</div>
								<button
									class="py-2 px-4 mt-4 bg-blue-700 text-base text-white border-none rounded-full flex items-center justify-center mb-3 font-bold">
									View Suppliers
								</button>
							</div>
						</SplideSlide>
					</Splide>
				</div>
			</ion-content>
		</template>
	</opp-view>
</template>
<script setup async>
import { ref, onMounted, onBeforeUnmount } from 'vue';
import { useRoute } from 'vue-router';
import { IonButton, IonModal } from '@ionic/vue';
import OppView from '../../core/OppView.vue';

import '@splidejs/vue-splide/css';

import { Splide, SplideSlide } from '@splidejs/vue-splide';

onMounted(async () => {});
onBeforeUnmount(() => {});
</script>

<style>
div .splide__arrow {
	display: none !important;
}
.content {
	@apply bg-gray-200;
}
.success {
	align-items: center;
	background-color: #0da468;
	display: flex;
	@apply w-full mx-auto  flex items-center;
	justify-content: center;
}

@keyframes scaleAnimation {
	0% {
		opacity: 0;
		transform: scale(1.5);
	}
	100% {
		opacity: 1;
		transform: scale(1);
	}
}
@-webkit-keyframes drawCircle {
	0% {
		stroke-dashoffset: 151px;
	}
	100% {
		stroke-dashoffset: 0;
	}
}
@keyframes drawCircle {
	0% {
		stroke-dashoffset: 151px;
	}
	100% {
		stroke-dashoffset: 0;
	}
}
@-webkit-keyframes drawCheck {
	0% {
		stroke-dashoffset: 36px;
	}
	100% {
		stroke-dashoffset: 0;
	}
}
@keyframes drawCheck {
	0% {
		stroke-dashoffset: 36px;
	}
	100% {
		stroke-dashoffset: 0;
	}
}
@-webkit-keyframes fadeOut {
	0% {
		opacity: 1;
	}
	100% {
		opacity: 0;
	}
}
@keyframes fadeOut {
	0% {
		opacity: 1;
	}
	100% {
		opacity: 0;
	}
}
@-webkit-keyframes fadeIn {
	0% {
		opacity: 0;
	}
	100% {
		opacity: 1;
	}
}
@keyframes fadeIn {
	0% {
		opacity: 0;
	}
	100% {
		opacity: 1;
	}
}
#successAnimationCircle {
	stroke-dasharray: 151px 151px;
	stroke: #fff;
}

#successAnimationCheck {
	stroke-dasharray: 36px 36px;
	stroke: #fff;
}

#successAnimationResult {
	fill: #fff;
	opacity: 0;
}

#successAnimation.animated {
	-webkit-animation: 1s ease-out 0s 1 both scaleAnimation;
	animation: 1s ease-out 0s 1 both scaleAnimation;
}
#successAnimation.animated #successAnimationCircle {
	-webkit-animation: 1s cubic-bezier(0.77, 0, 0.175, 1) 0s 1 both drawCircle, 0.3s linear 0.9s 1 both fadeOut;
	animation: 1s cubic-bezier(0.77, 0, 0.175, 1) 0s 1 both drawCircle, 0.3s linear 0.9s 1 both fadeOut;
}
#successAnimation.animated #successAnimationCheck {
	-webkit-animation: 1s cubic-bezier(0.77, 0, 0.175, 1) 0s 1 both drawCheck, 0.3s linear 0.9s 1 both fadeOut;
	animation: 1s cubic-bezier(0.77, 0, 0.175, 1) 0s 1 both drawCheck, 0.3s linear 0.9s 1 both fadeOut;
}
#successAnimation.animated #successAnimationResult {
	-webkit-animation: 0.3s linear 0.9s both fadeIn;
	animation: 0.3s linear 0.9s both fadeIn;
}
</style>
