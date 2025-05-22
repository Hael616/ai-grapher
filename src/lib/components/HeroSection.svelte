<script lang="ts">
	import { fade, fly } from 'svelte/transition';
</script>

<div class="relative">
	<div
		class="absolute inset-0 bg-[url('https://images.unsplash.com/photo-1607082349566-187342175e2f?w=1200&auto=format&fit=crop&q=80')] bg-cover bg-center bg-no-repeat opacity-5"
	></div>
	<div class="relative container mx-auto px-4">
		<div class="mx-auto max-w-6xl">
			<div class="grid gap-12 lg:grid-cols-2">
				<div class="flex flex-col justify-center" in:fade={{ duration: 800 }}>
					<h1 class="text-foreground mb-6 text-5xl leading-tight font-bold">
						Transform Your Product Photos with AI
					</h1>
					<p class="text-foreground-muted mb-8 text-xl">
						Create stunning, professional product photos in seconds. No studio, no photographer, no
						problem.
					</p>
					<div class="flex flex-wrap gap-4">
						<a
							href="#demo"
							class="bg-primary hover:bg-primary/90 text-primary-foreground inline-flex items-center justify-center rounded-lg px-8 py-3 text-lg font-medium transition-colors"
						>
							Try It Free
						</a>
						<a
							href="#how-it-works"
							class="bg-surface hover:bg-surface/80 text-foreground inline-flex items-center justify-center rounded-lg px-8 py-3 text-lg font-medium transition-colors"
						>
							See How It Works
						</a>
					</div>
				</div>
				<div class="relative" in:fly={{ x: 50, duration: 800 }}>
					<div class="relative aspect-[4/3] overflow-hidden rounded-2xl">
						<img
							src="https://images.unsplash.com/photo-1607083206968-13611e3d76db?w=800&auto=format&fit=crop&q=80"
							alt="AI Product Photography"
							class="h-full w-full object-cover"
						/>
					</div>
					<div
						class="border-background absolute -bottom-6 -left-6 aspect-square w-48 overflow-hidden rounded-2xl border-4"
					>
						<img
							src="https://images.unsplash.com/photo-1607082348824-0a96f2a4b9da?w=400&auto=format&fit=crop&q=80"
							alt="Before"
							class="h-full w-full object-cover"
						/>
					</div>
					<div
						class="border-background absolute -top-6 -right-6 aspect-square w-48 overflow-hidden rounded-2xl border-4"
					>
						<img
							src="https://images.unsplash.com/photo-1607082349566-187342175e2f?w=400&auto=format&fit=crop&q=80"
							alt="After"
							class="h-full w-full object-cover"
						/>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
