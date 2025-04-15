<script lang="ts">
	import { onMount } from 'svelte';
	import '../app.css';
	import 'iconify-icon';
	import { invalidate } from '$app/navigation';

	let { children, data } = $props();

	let { session, supabase } = $state(data);

	onMount(() => {
		const { data } = supabase.auth.onAuthStateChange((event, newSession) => {
			if (newSession?.expires_at !== session?.expires_at) invalidate('supabase:auth');
		});

		return () => data.subscription.unsubscribe();
	});
</script>

<svelte:head>
	<title>AI-Grapher</title>
</svelte:head>
{@render children()}
