<script lang="ts">
	import { enhance } from '$app/forms';
	import { page } from '$app/state';
	import type { SubmitFunction } from '@sveltejs/kit';

	import { slide } from 'svelte/transition';
	import { twMerge } from 'tailwind-merge';
	import type { AuthContextProps, AuthFlow } from './utils';
	import type { Provider } from '@supabase/supabase-js';
	import { warn } from '$lib/utils/logger';

	const { supabase } = page.data;

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

	// Handle authentication with Supabase
	const handleSocialWithSupabase = async (provider: AuthFlow) => {
		try {
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

<div class="flex min-h-screen items-center justify-center p-4">
	<div class="w-full max-w-md">
		<form
			id="form-{uid}"
			class={twMerge('card', theme.form)}
			method="POST"
			autocomplete="off"
			use:enhance={handleSubmit}
			aria-label={`${title} form`}
		>
			<div class="space-y-6">
				<div class="text-center">
					<h1 class="text-foreground text-2xl font-bold tracking-tight">{title}</h1>
					{#if showDescription}
						<p class="text-foreground-muted mt-2 text-sm">
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
				</div>

				{#if errorMessage}
					<div class="form-error">
						<div class="flex items-center gap-3">
							<iconify-icon icon="mdi:alert-circle" width="20" height="20" class="text-error" />
							<p class="text-sm">{errorMessage}</p>
						</div>
					</div>
				{/if}

				{#if successMessage}
					<div class="form-success" role="status" transition:slide>
						<div class="flex items-center gap-3">
							<iconify-icon icon="mdi:check-circle" width="20" height="20" class="text-success" />
							<p class="text-sm">{successMessage}</p>
						</div>
					</div>
				{/if}

				<div class={twMerge('space-y-4', theme.fields)}>
					{@render children()}
				</div>

				<div class="space-y-4">
					{#if flow === 'password' || flow === 'magic-link' || flow === 'forgot-password' || flow === 'reset-password'}
						<button
							type="submit"
							class={twMerge('button button-primary w-full', theme.submitButton)}
							disabled={loading}
							aria-busy={loading}
						>
							{#if loading}
								<span class="flex items-center justify-center">
									<span class="sr-only">Loading</span>
									<iconify-icon icon="svg-spinners:blocks-shuffle-2" width="24" height="24" />
								</span>
							{:else}
								{flow.includes('password') ? 'Sign in' : 'Send magic link'}
							{/if}
						</button>

						{#if flow === 'magic-link'}
							<p class="text-foreground-muted text-center text-sm">
								We'll send you a magic link to sign in password-free
							</p>
						{/if}

						{#if showExtras}
							<button
								type="button"
								class="button button-ghost w-full"
								onclick={() => changeAuthMethod(flow === 'password' ? 'magic-link' : 'password')}
							>
								{flow === 'password'
									? `${title} with magic link instead`
									: `${title} with password`}
							</button>
						{/if}
					{/if}

					{#if showSocials && socialProviders.length > 0}
						<div class="form-divider">
							<span class="text-foreground-muted text-sm">or</span>
						</div>

						<div class="grid gap-3">
							{#each socialProviders as provider}
								<button
									type="button"
									class={twMerge('button button-outline-soft', theme.socialButton)}
									onclick={() => changeAuthMethod(provider as AuthFlow)}
									disabled={loading}
								>
									<iconify-icon icon="mdi:{provider}" width="20" height="20"></iconify-icon>
									<span>Continue with {provider.charAt(0).toUpperCase() + provider.slice(1)}</span>
								</button>
							{/each}
						</div>
					{/if}

					{#if extras}
						{@render extras()}
					{:else if showExtras}
						<div class="text-center">
							<p class="text-foreground-muted text-sm">
								Don't have an account?
								<a href={actionUrl} class="text-primary hover:text-primary/90 font-medium">
									{actionText}
								</a>
							</p>
						</div>
					{/if}
				</div>
			</div>
		</form>
	</div>
</div>
