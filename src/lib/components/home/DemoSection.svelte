<script lang="ts">
	import { onMount } from 'svelte';
	import { fade, scale } from 'svelte/transition';

	let isVisible = false;
	let isPlaying = false;

	onMount(() => {
		isVisible = true;
	});

	function togglePlay() {
		isPlaying = !isPlaying;
	}
</script>

<section id="demo" class="relative py-32">
	<div
		class="absolute inset-0 bg-[url('https://images.unsplash.com/photo-1556742044-3c52d6e88c62?w=1200&auto=format&fit=crop&q=80')] bg-cover bg-center bg-no-repeat opacity-5"
	></div>
	<div class="relative container mx-auto px-4">
		<div class="mx-auto max-w-6xl">
			<div class="mb-16 text-center" in:fade={{ duration: 800 }}>
				<h2 class="text-foreground mb-4 text-4xl font-bold">See the Magic in Action</h2>
				<p class="text-foreground-muted text-xl">
					Watch how AI transforms your product photos in seconds
				</p>
			</div>
			<div
				class="group bg-surface relative overflow-hidden rounded-2xl shadow-2xl"
				in:scale={{ duration: 800, delay: 200 }}
			>
				<div class="aspect-w-16 aspect-h-9">
					<img
						src="https://images.unsplash.com/photo-1556742044-3c52d6e88c62?w=1200&auto=format&fit=crop&q=80"
						alt="AI Product Photography Demo"
						class="h-full w-full object-cover transition-transform duration-700 group-hover:scale-105"
					/>
				</div>
				<div
					class="absolute inset-0 flex items-center justify-center bg-black/30 opacity-0 transition-opacity duration-300 group-hover:opacity-100"
				>
					<button
						on:click={togglePlay}
						class="group/btn bg-surface/90 flex h-20 w-20 items-center justify-center rounded-full shadow-lg transition-all hover:scale-110"
					>
						{#if isPlaying}
							<svg
								class="text-primary h-8 w-8 transition-transform group-hover/btn:scale-110"
								fill="none"
								viewBox="0 0 24 24"
								stroke="currentColor"
							>
								<path
									stroke-linecap="round"
									stroke-linejoin="round"
									stroke-width="2"
									d="M10 9v6m4-6v6m7-3a9 9 0 11-18 0 9 9 0 0118 0z"
								/>
							</svg>
						{:else}
							<svg
								class="text-primary h-8 w-8 transition-transform group-hover/btn:scale-110"
								fill="none"
								viewBox="0 0 24 24"
								stroke="currentColor"
							>
								<path
									stroke-linecap="round"
									stroke-linejoin="round"
									stroke-width="2"
									d="M14.752 11.168l-3.197-2.132A1 1 0 0010 9.87v4.263a1 1 0 001.555.832l3.197-2.132a1 1 0 000-1.664z"
								/>
								<path
									stroke-linecap="round"
									stroke-linejoin="round"
									stroke-width="2"
									d="M21 12a9 9 0 11-18 0 9 9 0 0118 0z"
								/>
							</svg>
						{/if}
					</button>
				</div>
			</div>
		</div>
	</div>
</section>

<style>
	.aspect-w-16 {
		position: relative;
		padding-bottom: 56.25%;
	}

	.aspect-w-16 > * {
		position: absolute;
		height: 100%;
		width: 100%;
		top: 0;
		right: 0;
		bottom: 0;
		left: 0;
	}
</style>
