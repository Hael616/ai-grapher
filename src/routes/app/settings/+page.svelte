<script lang="ts">
	import { onMount } from 'svelte';
	import layoutStore from '$lib/components/layout/layout.svelte';

	onMount(() => {
		layoutStore.setPageTitle('Settings');
	});
</script>

<div class="space-y-5">
	<div class="card">
		<h2>Settings</h2>
		<p>
			Here you can manage your account settings, including your email, password, and profile
			information.
		</p>
	</div>
	<div class="card">
		<h3>Account</h3>
		<p>
			Here you can manage your account settings, including your email, password, and profile
			information.
		</p>
	</div>
</div>
