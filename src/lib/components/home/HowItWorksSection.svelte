<script lang="ts">
	import { onMount } from 'svelte';
	import { fade, fly } from 'svelte/transition';

	let isVisible = false;
	let activeStep = 0;

	const steps = [
		{
			title: 'Upload Your Product',
			description:
				'Simply upload a photo of your product. Any angle, any lighting - our AI can handle it.',
			icon: `<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 16l4.586-4.586a2 2 0 012.828 0L16 16m-2-2l1.586-1.586a2 2 0 012.828 0L20 14m-6-6h.01M6 20h12a2 2 0 002-2V6a2 2 0 00-2-2H6a2 2 0 00-2 2v12a2 2 0 002 2z" />`
		},
		{
			title: 'Choose Your Style',
			description:
				"Select from our curated styles or create your own. Perfect for your brand's unique look.",
			icon: `<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9.663 17h4.673M12 3v1m6.364 1.636l-.707.707M21 12h-1M4 12H3m3.343-5.657l-.707-.707m2.828 9.9a5 5 0 117.072 0l-.548.547A3.374 3.374 0 0014 18.469V19a2 2 0 11-4 0v-.531c0-.895-.356-1.754-.988-2.386l-.548-.547z" />`
		},
		{
			title: 'Download & Use',
			description:
				'Get your professional product photos instantly. Ready for your website, social media, or ads.',
			icon: `<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 16v1a3 3 0 003 3h10a3 3 0 003-3v-1m-4-4l-4 4m0 0l-4-4m4 4V4" />`
		}
	];

	onMount(() => {
		isVisible = true;
	});

	function setActiveStep(index: number) {
		activeStep = index;
	}
</script>

<section class="relative py-32">
	<div
		class="absolute inset-0 bg-[url('https://images.unsplash.com/photo-1607083206968-13611e3d76db?w=1200&auto=format&fit=crop&q=80')] bg-cover bg-center bg-no-repeat opacity-5"
	></div>
	<div class="relative container mx-auto px-4">
		<div class="mx-auto max-w-6xl">
			<div class="mb-16 text-center" in:fade={{ duration: 800 }}>
				<h2 class="text-foreground mb-4 text-4xl font-bold">How It Works</h2>
				<p class="text-foreground-muted text-xl">Three simple steps to perfect product photos</p>
			</div>
			<div class="grid gap-12 md:grid-cols-3">
				{#each steps as step, i}
					<div
						class="group relative cursor-pointer"
						on:click={() => setActiveStep(i)}
						on:mouseenter={() => setActiveStep(i)}
						in:fly={{ y: 50, duration: 800, delay: i * 200 }}
					>
						<div
							class="bg-primary/10 group-hover:bg-primary/20 mb-6 flex h-16 w-16 items-center justify-center rounded-2xl transition-all duration-300 group-hover:scale-110"
						>
							<svg
								class="text-primary h-8 w-8 transition-transform duration-300 group-hover:scale-110"
								fill="none"
								viewBox="0 0 24 24"
								stroke="currentColor"
							>
								{@html step.icon}
							</svg>
						</div>
						<h3
							class="group-hover:text-primary text-foreground mb-4 text-2xl font-bold transition-colors duration-300"
						>
							{step.title}
						</h3>
						<p class="text-foreground-muted">{step.description}</p>
						<div
							class="bg-primary absolute -bottom-4 left-0 h-1 w-0 transition-all duration-300 group-hover:w-full"
						></div>
					</div>
				{/each}
			</div>
		</div>
	</div>
</section>

<style>
	.group:hover .group-hover\:scale-110 {
		transform: scale(1.1);
	}
</style>
