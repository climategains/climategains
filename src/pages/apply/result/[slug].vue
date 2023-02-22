<template>
	<result-view>
		<template #default-view-body>
			<ion-content class="ion-padding">
				<div class="bg-black">
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

						Your Application is Under Review
					</div>
					<p class="pt-0 mb-2 mt-3 px-6 text-xl text-white">
						We have received your interest, and validators are now reviewing your video.
					</p>

					<ul class="px-4">
						<li class="inline-flex w-full py-3 border-b border-white/20 justify-between">
							<span class="font-bold">Project Name</span><span> {{ project.name }}</span>
						</li>
						<li class="inline-flex w-full py-3 border-b border-white/20 justify-between">
							<span class="font-bold">Project ID</span><span> {{ project.id }}</span>
						</li>
						<li class="inline-flex w-full py-3 border-b border-white/20 justify-between">
							<span class="font-bold"> Programme</span><span> {{ programme.name }}</span>
						</li>
						<li class="inline-flex w-full py-3 border-b border-white/20 justify-between">
							<span class="font-bold">Sector</span><span> {{ programme.default_sector }}</span>
						</li>
						<li class="inline-flex w-full py-3 border-b border-white/20 justify-between">
							<span class="font-bold">Date Submitted</span><span> {{ project.created }}</span>
						</li>
					</ul>
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
				<div class="modal">
					<div class="success banner">
						<svg viewBox="0 0 26 26" class="mr-3" xmlns="http://www.w3.org/2000/svg">
							<g
								stroke="currentColor"
								stroke-width="2"
								fill="none"
								fill-rule="evenodd"
								stroke-linecap="round"
								stroke-linejoin="round">
								<path
									class="circle"
									d="M13 1C6.372583 1 1 6.372583 1 13s5.372583 12 12 12 12-5.372583 12-12S19.627417 1 13 1z" />
								<path class="tick" d="M6.5 13.5L10 17 l8.808621-8.308621" />
							</g>
						</svg>
						<h3 class="my-0 text-white text-lg font-bold bg-bold">Application Submitted</h3>
					</div>
				</div>
			</ion-content>
		</template>
	</result-view>
</template>
<script setup async>
import { ref, onMounted, onBeforeUnmount } from 'vue';
import { useRoute } from 'vue-router';
import useStore from '@/stores/main';
import ResultView from '@/core/ResultView.vue';

const store = useStore();

const route = useRoute();

const project = store.getProject(route.params.slug);

const programme = store.getProgramme(project.programme_id);

onBeforeUnmount(() => {});
</script>

<style>
.modal {
	position: absolute;
	display: none;
	top: 0;
	width: 100%;
	height: 100%;
}
div .splide__arrow {
	display: none !important;
}
.content {
	@apply bg-gray-200;
}
.success {
	align-items: center;
	background-color: #00a362;
	width: 80%;
	height: 60px;

	@apply mx-auto rounded-lg items-center justify-center flex  justify-center items-center;
}

svg {
	display: block;
	height: 23px;
	width: 23px;
	color: #fff;
	/* SVG path use currentColor to inherit this */
}

.circle {
	stroke-dasharray: 76;
	stroke-dashoffset: 76;
	-webkit-animation: draw 0.5s forwards;
	animation: draw 0.5s forwards;
}

.tick {
	stroke-dasharray: 18;
	stroke-dashoffset: 18;
	-webkit-animation: draw 0.5s forwards 0.5s;
	animation: draw 0.5s forwards 0.5s;
}

@-webkit-keyframes draw {
	to {
		stroke-dashoffset: 0;
	}
}

@keyframes draw {
	to {
		stroke-dashoffset: 0;
	}
}
</style>
