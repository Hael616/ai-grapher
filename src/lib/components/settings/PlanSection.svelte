<script lang="ts">
	import { showToast } from '$lib/utils/toast';
	import Modal from '$lib/components/ui/Modal.svelte';

	const {
		plan = {
			name: 'Creator',
			monthly_credits: 100,
			credits_remaining: 42,
			projects_used: 3,
			projects_limit: 5,
			next_reset: '2025-08-01'
		}
	} = $props();

	let showCancelDialog = $state(false);

	function handleCancel() {
		showCancelDialog = true;
	}

	function handleConfirmCancel() {
		// TODO: Implement actual cancellation
		showToast({
			message: 'Subscription cancelled successfully',
			type: 'success'
		});
		showCancelDialog = false;
	}

	function handleKeepSubscription() {
		showCancelDialog = false;
	}
</script>

<div class="card space-y-6 p-4 sm:p-6">
	<div class="flex flex-col gap-4 sm:flex-row sm:items-center sm:justify-between">
		<h2 class="text-foreground text-lg font-semibold">Plan & Subscription</h2>
	</div>

	<div class="grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
		<div class="space-y-1">
			<p class="text-foreground-muted text-sm font-medium">Plan</p>
			<p class="text-foreground text-lg font-semibold">{plan.name}</p>
		</div>
		<div class="space-y-1">
			<p class="text-foreground-muted text-sm font-medium">Monthly Credits</p>
			<p class="text-foreground text-lg font-semibold">{plan.monthly_credits}</p>
		</div>
		<div class="space-y-1">
			<p class="text-foreground-muted text-sm font-medium">Credits Remaining</p>
			<p class="text-foreground text-lg font-semibold">{plan.credits_remaining}</p>
		</div>
		<div class="space-y-1">
			<p class="text-foreground-muted text-sm font-medium">Projects Used</p>
			<p class="text-foreground text-lg font-semibold">
				{plan.projects_used} / {plan.projects_limit}
			</p>
		</div>
		<div class="space-y-1">
			<p class="text-foreground-muted text-sm font-medium">Next Reset</p>
			<p class="text-foreground text-lg font-semibold">
				{new Date(plan.next_reset).toLocaleDateString()}
			</p>
		</div>
	</div>

	<div class="flex flex-col gap-2 lg:flex-row">
		<a href="/app/upgrade" class="button button-primary">
			<iconify-icon icon="mdi:star" width="20" height="20"></iconify-icon>
			Upgrade Plan
		</a>
		<button class="button button-danger" onclick={handleCancel}>
			<iconify-icon icon="mdi:close-circle" width="20" height="20"></iconify-icon>
			Cancel Subscription
		</button>
	</div>
</div>

{#snippet modalBody()}
	<p class="text-foreground-muted mt-2">
		Are you sure you want to cancel your subscription? You'll lose access to premium features at the
		end of your billing period.
	</p>
{/snippet}

{#snippet modalActions()}
	<button class="button button-outline-soft" onclick={handleKeepSubscription}>
		Keep Subscription
	</button>
	<button class="button button-danger" onclick={handleConfirmCancel}> Yes, Cancel </button>
{/snippet}

<Modal
	show={showCancelDialog}
	title="Cancel Subscription"
	onClose={handleKeepSubscription}
	body={modalBody}
	actions={modalActions}
/>
