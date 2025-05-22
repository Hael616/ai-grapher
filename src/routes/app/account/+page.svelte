<script lang="ts">
	import { layoutStore } from '$lib/components/layout/layout.svelte';
	import { page } from '$app/state';
	import Modal from '$lib/components/ui/Modal.svelte';
	import Input from '$lib/components/Input.svelte';
	import { showToast } from '$lib/utils/toast';
	import type { AuthError } from '@supabase/supabase-js';

	const { session, supabase } = page.data;

	const user = $derived(session?.user);

	// Set page title
	layoutStore.pageTitle = 'Account Settings';

	let showDeleteAccountModal = $state(false);
	let showChangePasswordModal = $state(false);
	let loading = $state(false);

	// Get auth provider
	const authProvider = $derived.by(() => {
		if (!user?.app_metadata?.provider) return 'Email/Password';
		return user.app_metadata.provider.charAt(0).toUpperCase() + user.app_metadata.provider.slice(1);
	});

	// Get available auth methods
	const availableAuthMethods = $derived.by(() => {
		const methods = new Set<string>();

		// Check for email/password
		if (user?.app_metadata?.provider === 'email') {
			methods.add('Email/Password');
		}

		// Check for magic link
		if (user?.app_metadata?.provider === 'magic-link') {
			methods.add('Magic Link');
		}

		// Check for OAuth providers
		if (user?.app_metadata?.provider === 'google') {
			methods.add('Google');
		}

		return Array.from(methods);
	});

	// Handle password change
	async function handlePasswordChange(event: SubmitEvent) {
		event.preventDefault();
		loading = true;

		const formData = new FormData(event.target as HTMLFormElement);
		const password = formData.get('password') as string;
		const confirmPassword = formData.get('confirmPassword') as string;

		if (password !== confirmPassword) {
			showToast({
				message: 'Passwords do not match',
				type: 'error'
			});
			loading = false;
			return;
		}

		try {
			const { error } = await supabase.auth.updateUser({ password });
			if (error) throw error;

			showToast({
				message: 'Password updated successfully',
				type: 'success'
			});
			showChangePasswordModal = false;
		} catch (error) {
			const authError = error as AuthError;
			showToast({
				message: authError.message || 'Failed to update password',
				type: 'error'
			});
		} finally {
			loading = false;
		}
	}

	// Handle account deletion
	async function handleDeleteAccount() {
		if (!user?.id) return;

		loading = true;
		// try {
		// 	const { error } = await supabase.auth.admin.deleteUser(user.id);
		// 	if (error) throw error;

		// 	showToast({
		// 		message: 'Account deleted successfully',
		// 		type: 'success'
		// 	});
		// 	window.location.href = '/auth/login';
		// } catch (error) {
		// 	const authError = error as AuthError;
		// 	showToast({
		// 		message: authError.message || 'Failed to delete account',
		// 		type: 'error'
		// 	});
		// } finally {
		// 	loading = false;
		// 	showDeleteAccountModal = false;
		// }

		// TODO: Implement account deletion
		showToast({
			message: 'Account deletion is not implemented yet',
			type: 'info'
		});
		loading = false;
		showDeleteAccountModal = false;
	}
</script>

<div class="space-y-8 p-4 sm:p-6">
	<!-- Header Section -->
	<div class="space-y-1">
		<h1 class="text-foreground text-2xl font-semibold">Account Settings</h1>
		<p class="text-foreground-muted">Manage your account information and security settings</p>
	</div>

	<!-- Basic Info Section -->
	<div class="card space-y-6 p-4 sm:p-6">
		<h2 class="text-foreground text-lg font-semibold">Basic Information</h2>
		<div class="grid gap-4 sm:grid-cols-2">
			<div class="space-y-1">
				<p class="text-foreground-muted text-sm font-medium">Email Address</p>
				<p class="text-foreground text-lg font-semibold">{user?.email}</p>
			</div>
			<div class="space-y-1">
				<p class="text-foreground-muted text-sm font-medium">Full Name</p>
				<p class="text-foreground text-lg font-semibold">
					{user?.user_metadata?.full_name || 'Not set'}
				</p>
			</div>
			<div class="space-y-1">
				<p class="text-foreground-muted text-sm font-medium">Account Created</p>
				<p class="text-foreground text-lg font-semibold">
					{new Date(user?.created_at || '').toLocaleDateString()}
				</p>
			</div>
			<div class="space-y-1">
				<p class="text-foreground-muted text-sm font-medium">Last Sign In</p>
				<p class="text-foreground text-lg font-semibold">
					{new Date(user?.last_sign_in_at || '').toLocaleDateString()}
				</p>
			</div>
		</div>
	</div>

	<!-- Security Settings Section -->
	<div class="card space-y-6 p-4 sm:p-6">
		<h2 class="text-foreground text-lg font-semibold">Security Settings</h2>
		<div class="space-y-6">
			<!-- Current Authentication Method -->
			<div class="flex items-center justify-between">
				<div class="space-y-1">
					<p class="text-foreground-muted text-sm font-medium">Current Authentication Method</p>
					<p class="text-foreground text-lg font-semibold">{authProvider}</p>
				</div>
				{#if authProvider === 'Email/Password'}
					<button
						class="button button-outline-soft"
						onclick={() => (showChangePasswordModal = true)}
					>
						<iconify-icon icon="mdi:lock" width="20" height="20"></iconify-icon>
						Change Password
					</button>
				{/if}
			</div>

			<!-- Available Authentication Methods -->
			<div class="space-y-4">
				<div class="space-y-2">
					<p class="text-foreground-muted text-sm font-medium">Available Authentication Methods</p>
					<div class="flex flex-wrap gap-2">
						{#each availableAuthMethods as method}
							<div
								class="bg-surface-hover inline-flex items-center gap-2 rounded-full px-3 py-1 text-sm"
							>
								{#if method === 'Google'}
									<iconify-icon icon="mdi:google" width="16" height="16"></iconify-icon>
								{:else if method === 'Magic Link'}
									<iconify-icon icon="mdi:email" width="16" height="16"></iconify-icon>
								{:else}
									<iconify-icon icon="mdi:lock" width="16" height="16"></iconify-icon>
								{/if}
								{method}
							</div>
						{/each}
					</div>
				</div>
				<p class="text-foreground-muted text-sm">
					To add additional authentication methods, please contact support.
				</p>
			</div>

			<!-- Security Recommendations -->
			<div class="bg-primary/10 rounded-lg p-4">
				<div class="flex items-start gap-3">
					<iconify-icon icon="mdi:shield-check" width="20" height="20" class="text-primary"
					></iconify-icon>
					<div class="space-y-1">
						<p class="text-foreground text-sm font-medium">Security Recommendations</p>
						<ul class="text-foreground-muted list-inside list-disc space-y-1 text-sm">
							{#if authProvider === 'Email/Password'}
								<li>Use a strong, unique password</li>
								<li>Enable two-factor authentication when available</li>
							{:else if authProvider === 'Google'}
								<li>Keep your Google account secure</li>
								<li>Enable two-factor authentication on your Google account</li>
							{:else if authProvider === 'Magic Link'}
								<li>Keep your email account secure</li>
								<li>Enable two-factor authentication on your email account</li>
							{/if}
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- Danger Zone Section -->
	<div class="card border-error/20 bg-error/10 space-y-6 p-4 sm:p-6">
		<h2 class="text-error text-lg font-semibold">Danger Zone</h2>
		<div class="space-y-4">
			<div class="flex items-center justify-between">
				<div class="space-y-1">
					<p class="text-error text-sm font-medium">Delete Account</p>
					<p class="text-error/80 text-sm">
						Permanently delete your account and all associated data
					</p>
				</div>
				<button
					class="button button-danger"
					onclick={() => (showDeleteAccountModal = true)}
					disabled={loading}
				>
					<iconify-icon icon="mdi:delete" width="20" height="20"></iconify-icon>
					Delete Account
				</button>
			</div>
		</div>
	</div>
</div>

{#snippet changePasswordModalBody()}
	<form onsubmit={handlePasswordChange} class="space-y-4">
		<Input
			label="New Password"
			name="password"
			type="password"
			placeholder="Enter new password"
			required
			disabled={loading}
		/>
		<Input
			label="Confirm New Password"
			name="confirmPassword"
			type="password"
			placeholder="Confirm new password"
			required
			disabled={loading}
		/>
		<button type="submit" class="button button-primary w-full" disabled={loading}>
			{#if loading}
				<iconify-icon icon="svg-spinners:blocks-shuffle-2" width="20" height="20"></iconify-icon>
				Updating...
			{:else}
				<iconify-icon icon="mdi:check" width="20" height="20"></iconify-icon>
				Update Password
			{/if}
		</button>
	</form>
{/snippet}

{#snippet deleteAccountModalBody()}
	<p class="text-gray-600">
		Are you sure you want to delete your account? This action cannot be undone. All your projects
		and generated images will be permanently deleted.
	</p>
{/snippet}

{#snippet deleteAccountModalActions()}
	<button class="button button-outline-soft" onclick={() => (showDeleteAccountModal = false)}>
		Cancel
	</button>
	<button class="button button-danger" onclick={handleDeleteAccount} disabled={loading}>
		{#if loading}
			<iconify-icon icon="svg-spinners:blocks-shuffle-2" width="20" height="20"></iconify-icon>
			Deleting...
		{:else}
			<iconify-icon icon="mdi:delete" width="20" height="20"></iconify-icon>
			Yes, Delete Account
		{/if}
	</button>
{/snippet}

<Modal
	show={showChangePasswordModal}
	title="Change Password"
	onClose={() => (showChangePasswordModal = false)}
	body={changePasswordModalBody}
	actions={() => null}
/>

<Modal
	show={showDeleteAccountModal}
	title="Delete Account"
	onClose={() => (showDeleteAccountModal = false)}
	body={deleteAccountModalBody}
	actions={deleteAccountModalActions}
/>
