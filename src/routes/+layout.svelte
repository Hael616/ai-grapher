<script lang="ts">
	import { onMount } from 'svelte';
	import '../app.css';
	import 'iconify-icon';
	import { invalidate } from '$app/navigation';
	import Seo from '$lib/components/Seo.svelte';

	let { children, data } = $props();

	let { session, supabase } = $state(data);

	onMount(() => {
		const { data } = supabase.auth.onAuthStateChange((event, newSession) => {
			if (newSession?.expires_at !== session?.expires_at) {
				invalidate('supabase:auth');
			}
		});

		return () => data.subscription.unsubscribe();
	});
</script>

<Seo
	title="AI-Grapher"
	description="AI-Grapher is a tool that helps you create beautiful product shots for your ecommerce store."
/>

{@render children()}
