<script lang="ts">
	import AuthContext from '$lib/components/auth/AuthContext.svelte';
	import Input from '$lib/components/Input.svelte';

	let loading = $state<boolean>(false);
</script>

<AuthContext
	title="Forgot password"
	flow="forgot-password"
	bind:loading
	showExtras={false}
	showSocials={false}
	theme={{
		form: ' max-w-lg w-full rounded shadow-md',
		submitButton: 'cursor-pointer',
		fields: 'gap-2'
	}}
	description="Enter your email address"
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

	{#snippet extras()}
		<a href="login" class="flex items-center-safe gap-1 text-sm text-gray-500 hover:underline">
			<iconify-icon icon="ion:arrow-back" width="15" height="15"></iconify-icon>
			Back to log in
		</a>
	{/snippet}
</AuthContext>
