<script lang="ts">
	import { onMount } from 'svelte';
	import { fade, fly } from 'svelte/transition';

	let isVisible = false;

	onMount(() => {
		isVisible = true;
	});
</script>

<section class="from-primary/5 to-background relative overflow-hidden bg-gradient-to-b py-32">
	<!-- Animated background elements -->
	<div class="absolute inset-0 overflow-hidden">
		<div
			class="animate-float bg-primary/10 absolute -top-4 -left-4 h-72 w-72 rounded-full blur-3xl"
		></div>
		<div
			class="animate-float-delayed bg-primary/10 absolute -right-4 -bottom-4 h-72 w-72 rounded-full blur-3xl"
		></div>
		<div
			class="bg-primary/5 absolute top-1/2 left-1/2 h-96 w-96 -translate-x-1/2 -translate-y-1/2 animate-pulse rounded-full blur-3xl"
		></div>
	</div>

	<div class="relative container mx-auto px-4">
		<div class="grid items-center gap-12 lg:grid-cols-2">
			<div class="relative" in:fade={{ duration: 800, delay: 200 }}>
				<h1 class="text-foreground mb-6 text-5xl font-bold tracking-tight md:text-6xl">
					Transform Your Product Photography with
					<span class="text-primary">AI Magic</span>
				</h1>
				<p class="text-foreground-muted mb-8 text-xl">
					Create stunning, professional product images in seconds. No studio, no photographer, no
					problem.
				</p>
				<div class="flex flex-wrap gap-4">
					<a
						href="/app"
						class="group bg-primary hover:bg-primary/90 focus:ring-primary text-on-primary inline-flex items-center justify-center rounded-lg px-8 py-3 text-base font-medium shadow-lg transition-all hover:scale-105 focus:ring-2 focus:ring-offset-2"
					>
						Get Started Free
						<svg
							class="ml-2 h-5 w-5 transition-transform group-hover:translate-x-1"
							fill="none"
							viewBox="0 0 24 24"
							stroke="currentColor"
						>
							<path
								stroke-linecap="round"
								stroke-linejoin="round"
								stroke-width="2"
								d="M13 7l5 5m0 0l-5 5m5-5H6"
							/>
						</svg>
					</a>
					<a
						href="#demo"
						class="border-border bg-surface text-foreground hover:bg-surface-hover inline-flex items-center justify-center rounded-lg border px-8 py-3 text-base font-medium shadow-sm transition-all hover:scale-105"
					>
						See How It Works
					</a>
				</div>
			</div>
			<div class="relative" in:fly={{ y: 50, duration: 800, delay: 400 }}>
				<div class="relative overflow-hidden rounded-2xl shadow-2xl">
					<img
						src="https://images.unsplash.com/photo-1607083206968-13611e3d76db?w=1200&auto=format&fit=crop&q=80"
						alt="AI Product Photography Demo"
						class="h-full w-full object-cover"
					/>
					<div class="absolute inset-0 bg-gradient-to-t from-black/50 to-transparent"></div>
				</div>
				<div
					class="absolute -bottom-6 -left-6 overflow-hidden rounded-2xl shadow-2xl"
					in:fly={{ x: -50, duration: 800, delay: 600 }}
				>
					<img
						src="https://images.unsplash.com/photo-1556742049-0cfed4f6a45d?w=800&auto=format&fit=crop&q=80"
						alt="Before and After"
						class="h-48 w-48 object-cover"
					/>
				</div>
			</div>
		</div>
	</div>
</section>

<style>
	@keyframes float {
		0%,
		100% {
			transform: translateY(0);
		}
		50% {
			transform: translateY(-20px);
		}
	}

	@keyframes float-delayed {
		0%,
		100% {
			transform: translateY(0);
		}
		50% {
			transform: translateY(20px);
		}
	}

	.animate-float {
		animation: float 6s ease-in-out infinite;
	}

	.animate-float-delayed {
		animation: float-delayed 6s ease-in-out infinite;
	}
</style>
