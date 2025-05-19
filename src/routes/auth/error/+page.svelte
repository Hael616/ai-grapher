<script lang="ts">
	import { page } from '$app/stores';
	import Seo from '../../../lib/components/Seo.svelte';

	// Get error message and code from URL params
	$: message = $page.url.searchParams.get('message') || 'An authentication error occurred';
	$: code = $page.url.searchParams.get('code');

	// Define error icon based on error type
	$: errorIcon = code?.includes('email')
		? 'mdi:email-alert'
		: code?.includes('password')
			? 'mdi:lock-alert'
			: 'mdi:alert-circle';
</script>

<Seo
	title="Authentication Error | AI-Grapher"
	description="An authentication error occurred. Please try again."
/>

<div class="page-container">
	<div class="card card-sm">
		<div class="card-content">
			<div class="icon-circle icon-circle-error" role="presentation">
				<iconify-icon icon={errorIcon} width="32" height="32" class="text-red-600"></iconify-icon>
			</div>

			<div class="space-y-2">
				<h1 class="heading-xl">Authentication Failed</h1>
				<p class="text-subtle">{message}</p>
			</div>

			<div class="actions-group">
				<a href="/auth/login" class="button-soft">
					<iconify-icon icon="ion:log-in" width="16" height="16"></iconify-icon>
					Back to Login
				</a>
				<a href="/auth/signup" class="button-outline-soft">
					<iconify-icon icon="ion:person-add" width="16" height="16"></iconify-icon>
					Sign Up
				</a>
			</div>
		</div>
	</div>
</div>
