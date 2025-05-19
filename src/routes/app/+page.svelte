<script lang="ts">
	import { goto } from '$app/navigation';
	import { debug, trace, warn } from '$lib/utils/logger.js';

	let { data } = $props();

	let { supabase } = $derived(data);

	const handleSignOut = async () => {
		const { error } = await supabase.auth.signOut();

		if (error) {
			warn('Error while signing out', error);
			return;
		}

		goto('/auth/login');
	};
</script>

<div class="flex min-h-40 flex-col items-center justify-center gap-5 border">
	<div>Hey</div>
	<button class="button button-primary" onclick={handleSignOut}>logout</button>
</div>
