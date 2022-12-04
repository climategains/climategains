<template>
	<div class="icon" :class="props.type">
		<component :is="svgIcon" />
	</div>
</template>

<script setup>
const props = defineProps(['type']);
import { defineAsyncComponent } from 'vue';
// simple usage
const svgIcon = defineAsyncComponent(() => import(`./glyphs/${props.type}.vue`));
</script>

<style scoped>
.icon {
	@apply bg-black rounded-full flex justify-center shrink-0 mr-4 items-center w-10 h-10;
}
.tree,
.leaf {
	@apply bg-green-600;
}
.sun {
	@apply bg-yellow-600;
}
.gas {
	@apply bg-blue-600;
}
</style>
