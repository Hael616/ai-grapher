<script lang="ts">
	import { goto } from '$app/navigation';

	let { data } = $props();

	let { supabase } = $derived(data);

	const handleSignOut = async () => {
		const { error } = await supabase.auth.signOut();
		if (!error) {
			console.log('successfully logged out');

			goto('/auth/login');
		} else {
			console.log('Tracing error while signing out', error);
		}
	};
</script>

<div class="flex min-h-40 flex-col items-center justify-center gap-5 border">
	<div>Hey</div>
	<button class="w-fit cursor-pointer border px-2" onclick={() => handleSignOut()}>logout</button>
</div>
