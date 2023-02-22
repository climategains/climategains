<script setup async lang="ts">
import { ref } from 'vue';

import useStore from '@/store';
import { useRouter } from 'vue-router';

import icon from '@/components/ui/icon.vue';

const store = useStore();
const router = useRouter();

store.fetchProjects();

const userRoles = store.getUserRoles(store.user.account.id);

function getIcon(value) {
	if (value === 'Solar Energy') {
		return 'sun';
	}
	if (value === 'Energy Demand') {
		return 'energy';
	}
}
</script>
<template>
	<page-view>
		<template #default-view-title>
			<div class="ml-1">My Account</div>
		</template>
		<template #default-view-body>
			<div class="w-full flex items-center mt-0 mb-0 bg-white/10">
				<h3 class="text-xl text-white w-full pl-5 my-0 text-center font-bold mx-auto flex items-center py-4">
					<svg
						xmlns="http://www.w3.org/2000/svg"
						fill="none"
						viewBox="0 0 24 24"
						stroke-width="1.5"
						stroke="currentColor"
						class="w-6 h-6 mr-2">
						<path
							stroke-linecap="round"
							d="M15.75 10.5l4.72-4.72a.75.75 0 011.28.53v11.38a.75.75 0 01-1.28.53l-4.72-4.72M4.5 18.75h9a2.25 2.25 0 002.25-2.25v-9a2.25 2.25 0 00-2.25-2.25h-9A2.25 2.25 0 002.25 7.5v9a2.25 2.25 0 002.25 2.25z" />
					</svg>

					Your Applications
				</h3>
			</div>
			<div class="mx-3 mt-0 border-gray-200 leading-relaxed text-lg" v-if="userRoles">
				<div
					v-for="(item, index) in userRoles.filter(x => x.project_id !== null)"
					:key="index"
					@click="() => router.push(`./projects/${store.getProject(item.project_id).id}`)"
					class="flex flex-col relative justify-between rounded-xl bg-white/10 pb-16 overflow-hidden my-3">
					<div class="flex px-3 bg-white/5 py-3 items-center font-bold">
						<icon :type="getIcon(store.getProgramme(store.getProject(item.project_id).programme_id).default_sector)" />
						<h4 class="text-base my-0">
							{{ store.getProgramme(store.getProject(item.project_id).programme_id).name }}
						</h4>
					</div>
					<div class="mx-3 mb-2">
						<p class="mb-0">
							<span class="font-bold">Project Name</span><br />
							{{ store.getProject(item.project_id).name }}
						</p>

						<p class="my-0">
							<span class="font-bold"> Submitted on</span><br />
							{{ store.getProject(item.project_id).created }}
						</p>
					</div>
					<div
						class="w-full flex items-center justify-center bg-orange/20 px-3 py-3 text-base font-bold absolute bottom-0">
						<span class="-ml-8">View Application</span>
						<svg
							xmlns="http://www.w3.org/2000/svg"
							fill="none"
							viewBox="0 0 24 24"
							stroke-width="3"
							stroke="white"
							class="w-4 h-4 ml-1">
							<path stroke-linecap="round" stroke-linejoin="round" d="M8.25 4.5l7.5 7.5-7.5 7.5" />
						</svg>
					</div>
				</div>
			</div>
		</template>
	</page-view>
</template>
