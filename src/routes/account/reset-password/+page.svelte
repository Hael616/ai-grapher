<script lang="ts">
	import { page } from '$app/state';

	import AuthContext from '$lib/components/auth/AuthContext.svelte';
	import Input from '$lib/components/Input.svelte';

	let loading = $state<boolean>(false);
</script>

<svelte:head>
	<title>Reset password | AI-Grapher</title>
</svelte:head>

<AuthContext
	title="Reset password"
	flow="reset-password"
	bind:loading
	showExtras={false}
	showSocials={false}
	theme={{
		form: ' max-w-lg w-full rounded shadow-md',
		submitButton: 'cursor-pointer',
		fields: 'gap-2'
	}}
	description="Reset your password"
>
	<Input
		label="Password"
		name="password"
		type="password"
		placeholder="Your password"
		required
		autocomplete="password"
		disabled={loading}
	/>
	<Input
		label="Confirm password"
		name="confirmPassword"
		type="password"
		placeholder="Confirm password"
		required
		autocomplete="password"
		disabled={loading}
	/>
</AuthContext>
