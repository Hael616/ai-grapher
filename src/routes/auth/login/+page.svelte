<script lang="ts">
	import AuthContext from '$lib/components/auth/AuthContext.svelte';
	import type { AuthFlow } from '$lib/components/auth/utils';
	import Input from '$lib/components/Input.svelte';

	let flow = $state<AuthFlow>('magic-link');
	let loading = $state<boolean>(false);
</script>

<AuthContext
	bind:loading
	bind:flow
	title="Welcome to AI-Grapher"
	showDescription={false}
	showExtras={false}
	theme={{
		form: ' max-w-lg w-full rounded',
		submitButton: 'cursor-pointer',
		fields: 'gap-2'
	}}
>
	<Input
		label="Email address"
		name="email"
		type="email"
		placeholder="Your email address"
		autocomplete="email"
		disabled={loading}
	/>

	{#if flow === 'password'}
		<Input
			label="Password"
			name="password"
			type="password"
			placeholder="Your password"
			autocomplete="password"
			disabled={loading}
		/>
	{/if}
</AuthContext>
