<script lang="ts">
	import { onMount } from 'svelte';
	import layoutStore from '$lib/components/layout/layout.svelte';

	onMount(() => {
		layoutStore.setPageTitle('My Projects');
	});
</script>
