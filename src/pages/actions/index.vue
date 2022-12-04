<!-- eslint-disable vuejs-accessibility/click-events-have-key-events -->
<script setup lang="ts">
import OppView from 'core/OppView.vue';
import { useRouter } from 'vue-router';
import { ref } from 'vue';
import useStore from '../../stores/main/index.js';
import icon from '../../components/ui/icon.vue';

import actions from '../../json/actions.json';

const store = useStore();
const router = useRouter();
</script>
<template>
	<opp-view>
		<template #default-view-body>
			<div class="mx-4 mt-14">
				<h1 class="mb-0 p-0">Climate Actions</h1>
				<h3 class="mt-1 mb-4 font-light text-2xl">Opportunity Index</h3>
			</div>
			<ul class="items">
				<li
					v-for="(item, index) in actions.response"
					:key="index"
					@click="() => router.push(`../actions/${item.id}`)"
					@keydown="222">
					<div class="flex items-start">
						<icon :type="item.meta.icon" />
						<div>
							<b class="my-0">{{ item.meta.title }}</b>
							<p class="mt-1">{{ item.meta.location.country }} · {{ item.meta.funding.carbon }}kg CO2/year</p>
						</div>
					</div>
					<div class="rounded-lg ml-2 px-3 border border-white/30 text-white py-2 font-bold text-xs">
						€{{ item.meta.funding.total }}
					</div>
				</li>
			</ul>
		</template>
	</opp-view>
</template>
<style scoped>
.items {
}

.items li {
	@apply flex items-center px-6 py-5 border-white/10 border-b justify-between;
}

.items li p {
	margin: 0;
}

li img {
	width: 40px;
	height: 40px;
	object-fit: cover;
	@apply rounded mr-3;
}

.list_item h4 {
	@apply pb-1 mb-0 m-0 border-b border-white/40;
}
.list_item p {
	@apply m-0 p-0;
}
</style>
