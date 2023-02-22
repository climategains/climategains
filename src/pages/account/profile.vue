<script setup lang="ts">
import { ref } from 'vue';
import { getDate, getTime } from '@/helpers/parsers';
import useStore from '@/store';

const store = useStore();

function profile() {
	if (store.user.account) {
		return store.getUser(store.user.account.id)[0];
	} else return false;
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
							stroke-linejoin="round"
							d="M17.982 18.725A7.488 7.488 0 0012 15.75a7.488 7.488 0 00-5.982 2.975m11.963 0a9 9 0 10-11.963 0m11.963 0A8.966 8.966 0 0112 21a8.966 8.966 0 01-5.982-2.275M15 9.75a3 3 0 11-6 0 3 3 0 016 0z" />
					</svg>

					My Profile
				</h3>
			</div>
			<div class="mx-0 mt-0 border-gray-200 leading-relaxed text-lg">
				<p class="mx-4 flex justify-between border-b border-gray-200/20 pb-3" v-if="profile() && profile().fullname">
					<span class="font-bold">Full Name</span> {{ profile().fullname }}
				</p>
				<p
					class="mx-4 flex justify-between border-b border-gray-200/20 pb-3"
					v-if="profile() && profile().organization">
					<span class="font-bold">Organization</span> {{ profile().organization }}
				</p>
				<p class="mx-4 flex justify-between border-b border-gray-200/20 pb-3">
					<span class="font-bold flex-0 w-full">Account ID</span> {{ store.user.account.id }}
				</p>
				<p class="mx-4 flex justify-between border-b border-gray-200/20 pb-3">
					<span class="font-bold">Account Email</span> {{ store.user.account.email }}
				</p>
				<p class="mx-4 flex justify-between border-b border-gray-200/20 pb-3">
					<span class="font-bold">Account Created</span> {{ getDate(store.user.account.confirmed_at) }}
				</p>
				<p class="mx-4 flex justify-between border-b border-gray-200/20 pb-3">
					<span class="font-bold">Last Sign In</span> {{ getDate(store.user.account.last_sign_in_at) }} at
					{{ getTime(store.user.account.last_sign_in_at) }}
				</p>
			</div>
		</template>
	</page-view>
</template>
