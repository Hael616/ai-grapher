<script lang="ts">
	import { enhance } from '$app/forms';
	import { page } from '$app/state';
	import type { SubmitFunction } from '@sveltejs/kit';

	import { slide } from 'svelte/transition';
	import { twMerge } from 'tailwind-merge';
	import type { AuthContextProps, AuthFlow } from './utils';
	import type { Provider } from '@supabase/supabase-js';
	import { createBrowserClient } from '@supabase/ssr';
	import { PUBLIC_SUPABASE_ANON_KEY, PUBLIC_SUPABASE_URL } from '$env/static/public';
	import { debug, warn } from '../../utils/logger';

	// Props with defaults
	let {
		title,
		children,
		extras,
		flow = $bindable('password' as AuthFlow),
		redirectTo = `${page.url.origin}/app`,
		socialProviders = ['google'],
		theme = {}, // Default empty theme object
		loading = $bindable(false),
		showSocials = true,
		showExtras = true,
		description = '',
		showDescription = true
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
					// @ts-ignore
					errorMessage = result.status === 400 ? result.data?.message : 'Something went wrong';
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
			const supabase = createBrowserClient(PUBLIC_SUPABASE_URL, PUBLIC_SUPABASE_ANON_KEY);

			const { data, error } = await supabase.auth.signInWithOAuth({
				provider: provider as Provider,
				options: {
					redirectTo
				}
			});

			if (error) {
				throw error;
			}
		} catch (err) {
			warn('signInWithOAuth failed', err);
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

<div class="page-container">
	<form
		id="form-{uid}"
		class={twMerge('md:card card-sm', theme.form)}
		method="POST"
		autocomplete="off"
		use:enhance={handleSubmit}
		aria-label={`${title} form`}
	>
		<div class="card-content">
			<h1 class="heading-xl">{title}</h1>
			{#if showDescription}
				<p class="text-subtle">
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
			{/if}

			{#if errorMessage}
				<div class="form-error">
					<div class="icon-circle-error h-8 w-8">
						<iconify-icon icon="mdi:alert-circle" width="20" height="20" class="text-red-600"
						></iconify-icon>
					</div>
					<p class="m-0 text-red-800">{errorMessage}</p>
				</div>
			{/if}

			{#if successMessage}
				<div
					class="flex w-full items-center gap-3 rounded bg-green-100 p-3 text-sm text-green-800"
					role="status"
					transition:slide
				>
					<div class="icon-circle-success h-8 w-8">
						<iconify-icon icon="mdi:check-circle" width="20" height="20" class="text-green-600"
						></iconify-icon>
					</div>
					<p class="m-0 text-green-800">{successMessage}</p>
				</div>
			{/if}

			<div class={twMerge('w-full space-y-4', theme.fields)}>
				{@render children()}
			</div>

			<div class="flex w-full flex-col items-center gap-4">
				<!-- Regular form submit button for password/magic-link flow -->
				{#if flow === 'password' || flow === 'magic-link' || flow === 'forgot-password' || flow === 'reset-password'}
					<button
						type="submit"
						class={twMerge('button-soft button w-full', theme.submitButton)}
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
							{flow.includes('password') ? 'Sign in' : 'Send magic link'}
						{/if}
					</button>

					{#if flow === 'magic-link'}
						<p class="form-hint">We'll send you a magic link to sign in password-free</p>
					{/if}

					{#if showExtras}
						<button
							type="button"
							class="text-subtle hover:text-foreground cursor-pointer border-none bg-transparent p-0 hover:underline"
							onclick={() => changeAuthMethod(flow === 'password' ? 'magic-link' : 'password')}
						>
							{flow === 'password' ? `${title} with magic link instead` : `${title} with password`}
						</button>
					{/if}
				{/if}

				{#if showSocials && socialProviders.length > 0}
					<div class="my-4 flex w-full items-center gap-3">
						<div class="h-px flex-1 bg-gray-200"></div>
						<div class="form-divider">
							<span class="text-subtle">or</span>
						</div>
						<div class="h-px flex-1 bg-gray-200"></div>
					</div>

					<div class="actions-group w-full justify-center">
						{#each socialProviders as provider}
							<button
								type="button"
								class={twMerge(
									'button-outline-soft button',
									socialProviders.length > 1 ? 'w-fit' : 'w-full',
									theme.socialButton
								)}
								onclick={() => changeAuthMethod(provider as AuthFlow)}
								disabled={loading}
							>
								<iconify-icon icon="mdi:{provider}" width="20" height="20"></iconify-icon>
								<span class={socialProviders.length > 1 ? 'sr-only' : ''}
									>Continue with {provider.charAt(0).toUpperCase() + provider.slice(1)}</span
								>
							</button>
						{/each}
					</div>
				{/if}

				{#if extras}
					{@render extras()}
				{:else if showExtras}
					<div class="mt-4 flex flex-col items-center gap-2">
						<span class="text-subtle">or</span>
						<a href={actionUrl} class="text-subtle hover:text-foreground hover:underline"
							>{actionText}</a
						>
					</div>
				{/if}
			</div>
		</div>
	</form>
</div>
