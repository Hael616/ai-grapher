<script lang="ts">
	import AppNavbar from '$lib/components/AppNavbar.svelte';

	let { children } = $props();
</script>

<AppNavbar />
{@render children()}
