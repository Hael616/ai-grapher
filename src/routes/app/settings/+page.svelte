<script lang="ts">
	import { layoutStore } from '$lib/components/layout/layout.svelte';
	import PlanSection from '$lib/components/settings/PlanSection.svelte';
	import UsageSection from '$lib/components/settings/UsageSection.svelte';
	import ThemeSection from '$lib/components/settings/ThemeSection.svelte';

	// Set page title
	layoutStore.pageTitle = 'Settings';

	// Mock data - replace with actual data from your backend
	const plan = {
		name: 'Creator',
		monthly_credits: 100,
		credits_remaining: 42,
		projects_used: 3,
		projects_limit: 5,
		next_reset: '2025-08-01'
	};

	const usage = {
		total_generations: 128,
		max_resolution: '1080p',
		modeling_support: 'Basic',
		project_limit: 5,
		extra_credits: 50
	};
</script>

<div class="space-y-6 p-4 sm:space-y-8 sm:p-6">
	<!-- Header Section -->
	<div class="space-y-1">
		<h1 class="text-foreground text-2xl font-semibold">Settings</h1>
		<p class="text-foreground-muted">Manage your account settings and subscription</p>
	</div>

	<div class="grid gap-6 xl:grid-cols-2">
		<!-- Plan & Subscription Section -->
		<PlanSection {plan} />

		<!-- Usage Summary Section -->
		<UsageSection {usage} />

		<!-- Theme Settings Section -->
		<ThemeSection />
	</div>
</div>
