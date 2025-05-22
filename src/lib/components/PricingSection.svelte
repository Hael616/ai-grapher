<script lang="ts">
	import { page } from '$app/state';
	import { fade, fly } from 'svelte/transition';

	const { plans } = page.data;

	const formatPrice = (cents: number) => {
		if (cents === 0) return 'Free';
		return `$${(cents / 100).toFixed(2)}/mo`;
	};
</script>

<section class="py-24" id="pricing">
	<div class="container mx-auto px-4">
		<div class="mx-auto max-w-3xl text-center">
			<h2 class="text-foreground mb-4 text-4xl font-bold">Simple, transparent pricing</h2>
			<p class="text-foreground-muted mb-16 text-xl">
				Choose the plan that's right for your business
			</p>
		</div>

		<div class="grid gap-8 md:grid-cols-2 lg:grid-cols-3">
			{#each plans as plan, i}
				<div
					class="bg-surface relative flex flex-col rounded-2xl p-8 shadow-lg transition-all duration-300 hover:scale-105"
					class:ring-2={plan.most_popular}
					class:ring-primary={plan.most_popular}
					class:lg:col-start-2={i === plans.length - 1 && plans.length % 3 === 1}
					in:fly={{ y: 50, duration: 500, delay: i * 100 }}
				>
					{#if plan.most_popular}
						<div class="absolute -top-4 left-1/2 -translate-x-1/2">
							<span
								class="bg-primary text-primary-foreground rounded-full px-4 py-1.5 text-sm font-medium shadow-lg"
								>Most Popular</span
							>
						</div>
					{/if}

					<div class="mb-8">
						<h3 class="text-foreground mb-4 text-2xl font-bold">{plan.name}</h3>
						<div class="mb-2">
							<span class="text-foreground text-4xl font-bold"
								>{formatPrice(plan.price_monthly)}</span
							>
						</div>
						{#if plan.price_monthly !== 0}
							<p class="text-foreground-muted text-sm">Billed monthly</p>
						{/if}
					</div>

					<div class="mb-8 flex-grow">
						<ul class="space-y-4">
							<li class="flex items-start gap-3">
								<svg
									class="text-primary mt-1 h-5 w-5 flex-shrink-0"
									fill="none"
									viewBox="0 0 24 24"
									stroke="currentColor"
								>
									<path
										stroke-linecap="round"
										stroke-linejoin="round"
										stroke-width="2"
										d="M5 13l4 4L19 7"
									/>
								</svg>
								<span class="text-foreground-muted">
									<strong class="text-foreground">{plan.monthly_credits}</strong> credits/month
								</span>
							</li>
							<li class="flex items-start gap-3">
								<svg
									class="text-primary mt-1 h-5 w-5 flex-shrink-0"
									fill="none"
									viewBox="0 0 24 24"
									stroke="currentColor"
								>
									<path
										stroke-linecap="round"
										stroke-linejoin="round"
										stroke-width="2"
										d="M5 13l4 4L19 7"
									/>
								</svg>
								<span class="text-foreground-muted">
									<strong class="text-foreground">{plan.max_projects || 'Unlimited'}</strong> projects
								</span>
							</li>
							<li class="flex items-start gap-3">
								<svg
									class="text-primary mt-1 h-5 w-5 flex-shrink-0"
									fill="none"
									viewBox="0 0 24 24"
									stroke="currentColor"
								>
									<path
										stroke-linecap="round"
										stroke-linejoin="round"
										stroke-width="2"
										d="M5 13l4 4L19 7"
									/>
								</svg>
								<span class="text-foreground-muted">
									Up to <strong class="text-foreground">{plan.max_resolution}</strong>
								</span>
							</li>
							<li class="flex items-start gap-3">
								<svg
									class="text-primary mt-1 h-5 w-5 flex-shrink-0"
									fill="none"
									viewBox="0 0 24 24"
									stroke="currentColor"
								>
									<path
										stroke-linecap="round"
										stroke-linejoin="round"
										stroke-width="2"
										d="M5 13l4 4L19 7"
									/>
								</svg>
								<span class="text-foreground-muted">
									{plan.model_support === 'none'
										? 'No'
										: plan.model_support.charAt(0).toUpperCase() + plan.model_support.slice(1)}{' '}
									<strong class="text-foreground">model support</strong>
								</span>
							</li>
						</ul>
					</div>

					<a
						href="/auth/login"
						class="button mt-auto block w-full text-center"
						class:button-outline={plan.price_monthly === 0}
						class:button-primary={plan.price_monthly !== 0}
					>
						{plan.price_monthly === 0 ? 'Get Started' : 'Choose Plan'}
					</a>
				</div>
			{/each}
		</div>

		<div class="mt-16 text-center">
			<p class="text-foreground-muted mb-4">Need a custom plan?</p>
			<a href="/contact" class="text-primary hover:underline">Contact us for enterprise pricing</a>
		</div>
	</div>
</section>

<style>
	.container {
		max-width: 1280px;
	}
</style>
