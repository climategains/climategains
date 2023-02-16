<!-- eslint-disable vuejs-accessibility/click-events-have-key-events -->
<script setup lang="ts">
import OppView from 'core/OppView.vue';
import { useRouter } from 'vue-router';
import { onMounted, reactive, ref } from 'vue';
import useStore from '../../stores/main/index.js';
import icon from '../../components/ui/icon.vue';

import actions from '../../json/actions.json';

const state = reactive({
	actions: null
});

async function getActions() {
	const response = await fetch('https://api.climategains.org/api/v1/countries', {
		method: 'GET',
		headers: {
			'x-api-key': 'rpA94jzJjrBh9IclvNKvM34xhHwo282g7qZ6mJ0sKITOBy39',
			'Content-Type': 'application/json; charset=utf-8'
		}
	});
	state.actions = await response.json();
}

const store = useStore();
const router = useRouter();

function changeRole(value) {
	store.role = value;
}

function getIcon(value) {
	if (value === 'Solar Energy') {
		return 'sun';
	}
	if (value === 'Energy Demand') {
		return 'energy';
	}
}

function getFunds(steps) {
	return steps.map(x => x.prefunding).reduce((s, v) => s + (v || 0), 0);
}

var getCountry = new Intl.DisplayNames(['en'], { type: 'region' });

onMounted(async () => {
	await getActions();
});
</script>
<template>
	<opp-view>
		<template #default-view-body>
			<div v-if="store.role == 'validator'">
				<div
					class="inline-block bg-gray-900 text-md rounded-full font-bold px-4 absolute right-5 top-5 py-2"
					@click="changeRole('activist')">
					Switch to Activist
				</div>

				<div class="mx-4 mt-20">
					<h1 class="mb-0 p-0">Climate Actions</h1>
					<h3 class="mt-1 mb-4 font-light text-2xl">Actions Index</h3>
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
			</div>

			<div v-else>
				<div
					class="inline-block bg-gray-900 text-md rounded-full font-bold px-4 absolute right-5 top-5 py-2"
					@click="changeRole('validator')">
					Switch to Validator
				</div>

				<div class="mx-4 mt-20">
					<h1 class="mb-0 p-0">Climate Opportunities</h1>
					<h3 class="mt-1 mb-4 font-light text-2xl">Opportunity Index</h3>
				</div>

				<ul v-if="state.actions" class="items">
					<li
						v-for="(item, index) in state.actions.data"
						:key="index"
						@click="() => router.push(`../programmes/${item.id}`)"
						@keydown="222">
						<div class="flex items-start">
							<icon :type="getIcon(item.defaultSector)" />

							<div>
								<b class="my-0">{{ item.name }}</b>
								<p class="mt-1">{{ getCountry.of(item.countryCode) }} · {{ item.emissionsAvoided }}kg CO2/year</p>
							</div>
						</div>
						<div class="rounded-lg ml-2 px-3 border border-white/30 text-white py-2 font-bold text-xs">
							€{{ getFunds(item.settings.project.steps) }}
						</div>
					</li>
				</ul>
			</div>
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
