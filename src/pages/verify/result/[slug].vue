<template>
	<result-view>
		<template #default-view-body>
			<ion-content class="ion-padding">
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
					<h3 class="text-white text-xl font-bold bg-bold">Verification Complete</h3>
				</div>
				<div class="mt-10 mx-10">
					<p class="inline-flex rounded-full bg-yellow-600 py-2 items-center px-3 font-bold">
						<svg
							xmlns="http://www.w3.org/2000/svg"
							fill="none"
							viewBox="0 0 24 24"
							stroke-width="1.5"
							stroke="white"
							class="w-6 h-6 mr-1">
							<path
								stroke-linecap="round"
								stroke-linejoin="round"
								d="M9.813 15.904L9 18.75l-.813-2.846a4.5 4.5 0 00-3.09-3.09L2.25 12l2.846-.813a4.5 4.5 0 003.09-3.09L9 5.25l.813 2.846a4.5 4.5 0 003.09 3.09L15.75 12l-2.846.813a4.5 4.5 0 00-3.09 3.09zM18.259 8.715L18 9.75l-.259-1.035a3.375 3.375 0 00-2.455-2.456L14.25 6l1.036-.259a3.375 3.375 0 002.455-2.456L18 2.25l.259 1.035a3.375 3.375 0 002.456 2.456L21.75 6l-1.035.259a3.375 3.375 0 00-2.456 2.456zM16.894 20.567L16.5 21.75l-.394-1.183a2.25 2.25 0 00-1.423-1.423L13.5 18.75l1.183-.394a2.25 2.25 0 001.423-1.423l.394-1.183.394 1.183a2.25 2.25 0 001.423 1.423l1.183.394-1.183.394a2.25 2.25 0 00-1.423 1.423z" />
						</svg>
						16
					</p>
					<h3 class="font-bold text-xl my-3">Thank you for verifying this action and fighting climate change!</h3>
					<p class="leading-normal">
						<b class="underline">{{ programme.name }}</b> has received your appraisal, and the funds will be released
						after three more positive evaluations. With your help, this project is one step closer to becoming reality.
					</p>
					<p class="leading-normal">
						What's next? You can download the program report in your profile under
						<b class="underline">My Documents</b>. You will be informed of progress and further steps for this project,
						and if you are interested in this area you can boost your knowledge with our
						<b class="underline">tutorials</b>!
					</p>
				</div>
			</ion-content>
		</template>
	</result-view>
</template>
<script setup async>
import { ref, onMounted, onBeforeUnmount } from 'vue';
import { useRoute } from 'vue-router';
import ResultView from '@/core/ResultView.vue';
import useStore from '@/stores/main';

const store = useStore();
const route = useRoute();
const project = store.getProject(route.params.slug);
const programme = store.getProgramme(project.programme_id);
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
