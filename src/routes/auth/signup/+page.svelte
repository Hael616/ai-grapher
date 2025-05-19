<script lang="ts">
	import AuthContext from '$lib/components/auth/AuthContext.svelte';
	import type { AuthFlow } from '$lib/components/auth/utils';
	import Input from '$lib/components/Input.svelte';
	import type { PageProps } from './$types';

	let { form }: PageProps = $props();

	let flow = $state<AuthFlow>('password');
	let loading = $state<boolean>(false);
</script>

<svelte:head>
	<title>Sign up</title>
	<meta name="description" content="Create a new account" />
</svelte:head>

<AuthContext
	title="Sign up"
	bind:flow
	bind:loading
	theme={{
		form: ' max-w-lg w-full rounded shadow-md',
		submitButton: 'cursor-pointer',
		fields: 'gap-2'
	}}
>
	<Input
		label="Email address"
		name="email"
		type="email"
		placeholder="Your email address"
		required
		autocomplete="email"
	/>

	{#if flow === 'password'}
		<Input
			label="Password"
			name="password"
			type="password"
			placeholder="Create a password"
			required
			autocomplete="new-password"
		/>

		<Input
			label="Confirm password"
			name="confirmPassword"
			type="password"
			placeholder="Confirm your password"
			required
			autocomplete="new-password"
		/>
	{/if}
</AuthContext>
