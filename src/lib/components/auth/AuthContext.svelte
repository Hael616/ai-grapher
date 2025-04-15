<script lang="ts">
	import { enhance } from '$app/forms';
	import type { SubmitFunction } from '@sveltejs/kit';

	import { slide } from 'svelte/transition';
	import { twMerge } from 'tailwind-merge';
	import type { AuthContextProps, AuthFlow } from './utils';

	// Props with defaults
	let {
		title,
		children,
		extras,
		flow = $bindable('password' as AuthFlow),
		redirectTo = '/dashboard',
		socialProviders = ['google', 'github', 'apple'],
		theme = {}, // Default empty theme object
		loading = $bindable(false),
		showSocials = true,
		showExtras = true,
		description = ''
	}: AuthContextProps = $props();

	// Destructure theme with defaults
	const {
		container = '',
		form = '',
		header = '',
		heading = '',
		descriptionClass = '',
		fields = '',
		submitButton = '',
		link = '',
		socialButton = '',
		error = '',
		success = '',
		divider = '',
		alternate = ''
	} = theme;

	let errorMessage = $state('');
	let successMessage = $state('');
	let uid = $props.id();

	// Use a single function to handle auth method changes
	const changeAuthMethod = (newFlow: AuthFlow) => {
		errorMessage = '';
		successMessage = '';
		flow = newFlow;

		if (['google', 'github', 'apple'].includes(newFlow)) {
			handleSocialWithSupabase(newFlow as AuthFlow);
		}
	};

	// Handle form submission
	const handleSubmit: SubmitFunction = ({ formData }) => {
		loading = true;
		errorMessage = '';
		successMessage = '';
		formData.set('flow', flow);
		formData.set('redirectTo', redirectTo);

		// For social providers, handle differently
		if (flow === 'google' || flow === 'github') {
			// This would call Supabase's social auth
			handleSocialWithSupabase(flow);
			return ({ update }) => {
				update();
				loading = false;
			};
		}

		// Normal form submission for password/magic-link
		return async ({ update, result }) => {
			update();

			try {
				if (result.type === 'success') {
					successMessage = result.data?.message || 'Success!';
				} else {
					errorMessage = result.data?.message || 'Something went wrong';
				}
			} finally {
				loading = false;
			}
		};
	};

	// Handle authentication with Supabase (placeholder)
	const handleSocialWithSupabase = async (provider: AuthFlow) => {
		try {
			// Placeholder for Supabase integration
			// In a real implementation, you would call Supabase here
			console.log(`Authenticating with ${provider}`);

			// Mock auth delay
			await new Promise((resolve) => setTimeout(resolve, 1000));

			// Success would redirect via Supabase
			successMessage = `${provider} authentication initiated`;
		} catch (err) {
			errorMessage = 'Failed to authenticate';
			console.error(err);
		} finally {
			loading = false;
		}
	};

	// Determine the action text based on the title
	const actionText = title === 'Sign in' ? 'Sign up' : 'Sign in';
	const actionUrl = title === 'Sign in' ? '/auth/signup' : '/auth/login';
</script>

<div
	id="context-{uid}"
	class={twMerge('flex h-full w-full items-center justify-center', container)}
>
	<form
		id="form-{uid}"
		class={twMerge('flex w-full max-w-md flex-col gap-6 p-6', form)}
		method="POST"
		autocomplete="off"
		use:enhance={handleSubmit}
		aria-label={`${title} form`}
	>
		<div class={twMerge('grid w-full grid-cols-1 justify-items-center gap-2', header)}>
			<h1 class={twMerge('m-0 text-2xl font-medium', heading)}>{title}</h1>
			<p class={twMerge('m-0 text-center text-sm text-gray-600', descriptionClass)}>
				{#if description}
					{description}
				{:else if flow === 'password' || flow === 'magic-link'}
					{flow === 'password'
						? `${title} with email and password`
						: `${title} via magic link with your email`}
				{:else}
					{title} with {flow}
				{/if}
			</p>

			{#if errorMessage}
				<div
					class={twMerge('mt-2 w-full rounded bg-red-100 p-3 text-sm text-red-800', error)}
					role="alert"
					transition:slide
				>
					{errorMessage}
				</div>
			{/if}

			{#if successMessage}
				<div
					class={twMerge('mt-2 w-full rounded bg-green-100 p-3 text-sm text-green-800', success)}
					role="status"
					transition:slide
				>
					{successMessage}
				</div>
			{/if}
		</div>

		<div class={twMerge('grid w-full grid-cols-1 gap-4', fields)}>
			{@render children()}
		</div>

		<div class="flex w-full flex-col items-center gap-4">
			<!-- Regular form submit button for password/magic-link flow -->
			{#if flow === 'password' || flow === 'magic-link' || flow === 'forgot-password' || flow === 'reset-password'}
				<button
					type="submit"
					class={twMerge(
						'flex min-w-40 items-center justify-center rounded bg-blue-200 px-4 py-2 text-base font-medium transition-colors hover:bg-blue-300 disabled:cursor-not-allowed',
						submitButton
					)}
					disabled={loading}
					aria-busy={loading}
				>
					{#if loading}
						<span class="flex items-center justify-center">
							<span class="sr-only">Loading</span>
							<iconify-icon icon="svg-spinners:blocks-shuffle-2" width="24" height="24"
							></iconify-icon>
						</span>
					{:else}
						{flow.includes('password') ? title : 'Send magic link'}
					{/if}
				</button>

				{#if showExtras}
					<button
						type="button"
						class={twMerge(
							'cursor-pointer border-none bg-transparent p-0 text-sm hover:underline',
							link
						)}
						onclick={() => changeAuthMethod(flow === 'password' ? 'magic-link' : 'password')}
					>
						{flow === 'password' ? `${title} with magic link instead` : `${title} with password`}
					</button>
				{/if}
			{/if}

			{#if showSocials && socialProviders.length > 0}
				<div class={twMerge('my-2 flex w-full items-center', divider)}>
					<div class="h-px flex-1 bg-gray-200"></div>
					<span class="px-3 text-sm text-gray-500">or</span>
					<div class="h-px flex-1 bg-gray-200"></div>
				</div>

				<div class="flex w-full items-center justify-center gap-2">
					{#each socialProviders as provider}
						<button
							type="button"
							class={twMerge(
								"{loading && 'pointer-events-none'} flex w-fit cursor-pointer items-center justify-center gap-2 rounded border border-gray-200 bg-white px-4 py-2.5 text-sm transition-colors hover:bg-gray-50 disabled:cursor-not-allowed",
								socialButton
							)}
							onclick={() => changeAuthMethod(provider as AuthFlow)}
							disabled={loading}
						>
							<iconify-icon icon="mdi:{provider}" width="20" height="20"></iconify-icon>
							<span class="sr-only"
								>Continue with {provider.charAt(0).toUpperCase() + provider.slice(1)}</span
							>
						</button>
					{/each}
				</div>
			{/if}

			{#if extras}
				{@render extras()}
			{:else if showExtras}
				<div class={twMerge('mt-2 flex flex-col items-center gap-2', alternate)}>
					<span class="text-sm text-gray-500">or</span>
					<a href={actionUrl} class="text-sm hover:underline">{actionText}</a>
				</div>
			{/if}
		</div>
	</form>
</div>

<style>
	/* Screen reader only utility class */
	.sr-only {
		position: absolute;
		width: 1px;
		height: 1px;
		padding: 0;
		margin: -1px;
		overflow: hidden;
		clip: rect(0, 0, 0, 0);
		white-space: nowrap;
		border-width: 0;
	}
</style>
