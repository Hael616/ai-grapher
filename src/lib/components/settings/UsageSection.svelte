<script lang="ts">
	export let usage = {
		total_generations: 128,
		max_resolution: '1080p',
		modeling_support: 'Basic',
		project_limit: 5,
		extra_credits: 50
	};
</script>

<div class="card space-y-6 p-4 sm:p-6">
	<h2 class="text-foreground text-lg font-semibold">Usage Summary</h2>

	<div class="grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
		<div class="space-y-1">
			<p class="text-foreground-muted text-sm font-medium">Total Generations</p>
			<p class="text-foreground text-lg font-semibold">{usage.total_generations}</p>
		</div>
		<div class="space-y-1">
			<p class="text-foreground-muted text-sm font-medium">Max Resolution Allowed</p>
			<p class="text-foreground text-lg font-semibold">{usage.max_resolution}</p>
		</div>
		<div class="space-y-1">
			<p class="text-foreground-muted text-sm font-medium">Modeling Support</p>
			<p class="text-foreground text-lg font-semibold">{usage.modeling_support}</p>
		</div>
		<div class="space-y-1">
			<p class="text-foreground-muted text-sm font-medium">Current Project Limit</p>
			<p class="text-foreground text-lg font-semibold">{usage.project_limit}</p>
		</div>
		<div class="space-y-1">
			<p class="text-foreground-muted text-sm font-medium">Extra Credits Purchased</p>
			<p class="text-foreground text-lg font-semibold">{usage.extra_credits}</p>
		</div>
	</div>
</div>
