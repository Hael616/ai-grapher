<script lang="ts">
	import AuthContext from '$lib/components/auth/AuthContext.svelte';
	import type { AuthFlow } from '$lib/components/auth/utils';
	import Input from '$lib/components/Input.svelte';

	let flow = $state<AuthFlow>('password');
	let loading = $state<boolean>(false);
</script>

<AuthContext
	bind:loading
	bind:flow
	title="Sign in"
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
		disabled={loading}
	/>

	{#if flow === 'password'}
		<Input
			label="Password"
			name="password"
			type="password"
			placeholder="Your assword"
			required
			autocomplete="password"
			disabled={loading}
		/>
	{/if}
</AuthContext>
