<template>
	<main>
		<div class="alignment-line hide"></div>
		<div class="alignment-line line-2 hide"></div>
		<div class="content-loading-container">
			<span class="loading-square loading-square-4"></span>
			<span class="loading-square loading-square-3"></span>
			<span class="loading-square loading-square-2"></span>
			<span class="loading-square loading-square-1"></span>
		</div>
	</main>
</template>

<script setup>
const props = defineProps(['time']);
</script>

<style scoped>
.content-loading-container {
	display: flex;
	justify-content: center;
	align-items: center;
	position: relative;
	transform: rotate(45deg);
}
.content-loading-container .loading-square {
	position: relative;
}
.content-loading-container .loading-square::before {
	content: '';
	width: 30px;
	height: 30px;
	position: absolute;
	background: #56b2e0;
	-webkit-animation-name: app-mount-loading-square-2;
	animation-name: app-mount-loading-square-2;
	-webkit-animation-duration: 3.5s;
	animation-duration: 3.5s;
	-webkit-animation-timing-function: cubic-bezier(0.22, 0.61, 0.36, 1);
	animation-timing-function: cubic-bezier(0.22, 0.61, 0.36, 1);
	-webkit-animation-iteration-count: infinite;
	animation-iteration-count: infinite;
	transform: translateX(60px);
}
.content-loading-container .loading-square::after {
	content: '';
	width: 30px;
	height: 30px;
	position: absolute;
	background: #56e0b8;
	-webkit-animation-name: app-mount-loading-square-1;
	animation-name: app-mount-loading-square-1;
	-webkit-animation-duration: 3.5s;
	animation-duration: 3.5s;
	-webkit-animation-timing-function: cubic-bezier(0.22, 0.61, 0.36, 1);
	animation-timing-function: cubic-bezier(0.22, 0.61, 0.36, 1);
	-webkit-animation-iteration-count: infinite;
	animation-iteration-count: infinite;
}
.content-loading-container .loading-square.loading-square-1 {
	transform: rotate(-90deg);
}
.content-loading-container .loading-square.loading-square-1::before {
	-webkit-animation-delay: -7s;
	animation-delay: -7s;
}
.content-loading-container .loading-square.loading-square-1::after {
	-webkit-animation-delay: -0.375s;
	animation-delay: -0.375s;
}
.content-loading-container .loading-square.loading-square-2 {
	transform: rotate(-180deg);
}
.content-loading-container .loading-square.loading-square-2::before {
	-webkit-animation-delay: -14s;
	animation-delay: -14s;
}
.content-loading-container .loading-square.loading-square-2::after {
	-webkit-animation-delay: -1.25s;
	animation-delay: -1.25s;
}
.content-loading-container .loading-square.loading-square-3 {
	transform: rotate(-270deg);
}
.content-loading-container .loading-square.loading-square-3::before {
	-webkit-animation-delay: -21s;
	animation-delay: -21s;
}
.content-loading-container .loading-square.loading-square-3::after {
	-webkit-animation-delay: -2.125s;
	animation-delay: -2.125s;
}
.content-loading-container .loading-square.loading-square-4 {
	transform: rotate(-360deg);
}
.content-loading-container .loading-square.loading-square-4::before {
	-webkit-animation-delay: -28s;
	animation-delay: -28s;
}
.content-loading-container .loading-square.loading-square-4::after {
	-webkit-animation-delay: -3s;
	animation-delay: -3s;
}
.content-loading-container .loading-square.loading-square-1 {
	left: 2.8571428571px;
	top: -2.8571428571px;
}
.content-loading-container .loading-square.loading-square-2 {
	left: -2.8571428571px;
	top: -2.8571428571px;
}
.content-loading-container .loading-square.loading-square-3 {
	left: -2.8571428571px;
	top: 2.8571428571px;
}
.content-loading-container .loading-square.loading-square-4 {
	left: 2.8571428571px;
	top: 2.8571428571px;
}

@-webkit-keyframes app-mount-loading-square-2 {
	0% {
		transform: translateX(69.6px);
		opacity: 0;
	}
	9% {
		transform: translateX(69.6px);
		opacity: 0;
	}
	32% {
		transform: translateX(0);
		opacity: 0.8;
	}
	100% {
		transform: translateX(0);
		opacity: 0;
	}
}

@keyframes app-mount-loading-square-2 {
	0% {
		transform: translateX(69.6px);
		opacity: 0;
	}
	9% {
		transform: translateX(69.6px);
		opacity: 0;
	}
	32% {
		transform: translateX(0);
		opacity: 0.8;
	}
	100% {
		transform: translateX(0);
		opacity: 0;
	}
}
@-webkit-keyframes app-mount-loading-square-1 {
	0% {
		transform: translateX(0);
		opacity: 1;
	}
	25% {
		transform: translateX(-39.6px);
		opacity: 1;
	}
	25.01% {
		opacity: 0;
	}
	100% {
		transform: translateX(-69.6px);
		opacity: 0;
	}
}
@keyframes app-mount-loading-square-1 {
	0% {
		transform: translateX(0);
		opacity: 1;
	}
	25% {
		transform: translateX(-39.6px);
		opacity: 1;
	}
	25.01% {
		opacity: 0;
	}
	100% {
		transform: translateX(-69.6px);
		opacity: 0;
	}
}
main {
	background: #fff;
	width: 100vw;
	height: 100vh;
	display: flex;
	justify-content: center;
	align-items: center;
	overflow: hidden;
}
</style>

<!-- <style lang="scss" scoped>
$time: 3.5;
$size: 30px;
$animationPrimaryColor: #56e0b8;
$animationSecondaryColor: #56b2e0;

.content-loading-container {
	display: flex;
	justify-content: center;
	align-items: center;
	position: relative;
	transform: rotate(45deg);

	.loading-square {
		position: relative;

		&::before {
			content: '';
			width: $size;
			height: $size;
			position: absolute;
			background: $animationSecondaryColor;
			animation-name: app-mount-loading-square-2;
			animation-duration: $time + s;
			animation-timing-function: cubic-bezier(0.22, 0.61, 0.36, 1);
			animation-iteration-count: infinite;
			transform: translateX($size * 2);
		}

		&::after {
			content: '';
			width: $size;
			height: $size;
			position: absolute;
			background: $animationPrimaryColor;
			animation-name: app-mount-loading-square-1;
			animation-duration: $time + s;
			animation-timing-function: cubic-bezier(0.22, 0.61, 0.36, 1);
			animation-iteration-count: infinite;
		}

		@for $i from 1 through 4 {
			&.loading-square-#{$i} {
				transform: rotate(-90 * $i + deg);

				&::before {
					animation-delay: -($time / 0.5) * $i + s;
				}

				&::after {
					animation-delay: -($time / 4) * $i + ($time / 7) + s;
				}
			}
		}

		&.loading-square-1 {
			left: $size / 10.5;
			top: -$size / 10.5;
		}
		&.loading-square-2 {
			left: -$size / 10.5;
			top: -$size / 10.5;
		}
		&.loading-square-3 {
			left: -$size / 10.5;
			top: $size / 10.5;
		}
		&.loading-square-4 {
			left: $size / 10.5;
			top: $size / 10.5;
		}
	}
}

@keyframes app-mount-loading-square-2 {
	0% {
		transform: translateX($size * 2.32);
		opacity: 0;
	}
	9% {
		transform: translateX($size * 2.32);
		opacity: 0;
	}
	32% {
		transform: translateX(0);
		opacity: 0.8;
	}

	100% {
		transform: translateX(0);
		opacity: 0;
	}
}

@keyframes app-mount-loading-square-1 {
	0% {
		transform: translateX(0);
		opacity: 1;
	}
	25% {
		transform: translateX(-($size * 1.32));
		opacity: 1;
	}
	25.01% {
		opacity: 0;
	}
	100% {
		transform: translateX(-($size * 2.32));
		opacity: 0;
	}
}

// Boilerplate

main {
	background: #fff;
	width: 100%;
	height: 100%;
	display: flex;
	justify-content: center;
	align-items: center;
	overflow: hidden;
}
</style> -->
