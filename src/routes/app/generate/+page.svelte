<script lang="ts">
	import { onMount } from 'svelte';
	import layoutStore from '$lib/components/layout/layout.svelte';

	onMount(() => {
		layoutStore.setPageTitle('Generate');
	});
</script>

<div class="card">
	<h2>Generate</h2>
	<p>This page is under construction, users can generate new images here</p>
</div>
