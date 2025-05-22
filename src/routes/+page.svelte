<script lang="ts">
	import { onMount } from 'svelte';
	import { page } from '$app/state';
	import { fade, fly, scale } from 'svelte/transition';
	import Navbar from '$lib/components/Navbar.svelte';
	import Footer from '$lib/components/Footer.svelte';
	import PricingSection from '$lib/components/PricingSection.svelte';
	import FAQSection from '$lib/components/FAQSection.svelte';
	import HeroSection from '$lib/components/home/HeroSection.svelte';
	import DemoSection from '$lib/components/home/DemoSection.svelte';
	import HowItWorksSection from '$lib/components/home/HowItWorksSection.svelte';

	let isVisible = false;
	const { session } = page.data;

	onMount(() => {
		isVisible = true;
	});
</script>

<svelte:head>
	<title>AI Grapher - Transform Your Product Photography with AI</title>
	<meta
		name="description"
		content="Transform your product photography with AI. Upload a product, choose a style, and get professional-quality images instantly."
	/>
</svelte:head>

<Navbar />

<main class="bg-background min-h-screen">
	<section id="product">
		<HeroSection />
	</section>

	<section id="how-it-works">
		<HowItWorksSection />
	</section>

	<section id="demo">
		<DemoSection />
	</section>

	<!-- Use Cases Section -->
	<section class="relative py-32">
		<div
			class="absolute inset-0 bg-[url('https://images.unsplash.com/photo-1607082348824-0a96f2a4b9da?w=1200&auto=format&fit=crop&q=80')] bg-cover bg-center bg-no-repeat opacity-5"
		></div>
		<div class="relative container mx-auto px-4">
			<div class="mx-auto max-w-6xl">
				<div class="mb-16 text-center" in:fade={{ duration: 800 }}>
					<h2 class="text-foreground mb-4 text-4xl font-bold">Perfect for Every Business</h2>
					<p class="text-foreground-muted text-xl">
						From startups to enterprises, we've got you covered
					</p>
				</div>
				<div class="grid gap-8 md:grid-cols-2 lg:grid-cols-3">
					{#each [{ title: 'E-commerce Stores', description: 'Create consistent, high-quality product images that drive sales and build trust.', image: 'https://images.unsplash.com/photo-1607083206968-13611e3d76db?w=800&auto=format&fit=crop&q=80' }, { title: 'Marketing Agencies', description: 'Scale your creative production with AI-powered product photography.', image: 'https://images.unsplash.com/photo-1607082348824-0a96f2a4b9da?w=800&auto=format&fit=crop&q=80' }, { title: 'Brands', description: 'Maintain brand consistency across all your product photography.', image: 'https://images.unsplash.com/photo-1607082349566-187342175e2f?w=800&auto=format&fit=crop&q=80' }] as useCase, i}
						<div
							class="group bg-surface overflow-hidden rounded-2xl shadow-lg transition-all hover:shadow-xl"
							in:fly={{ y: 50, duration: 800, delay: i * 200 }}
						>
							<div class="aspect-w-16 aspect-h-9">
								<img
									src={useCase.image}
									alt={useCase.title}
									class="h-full w-full object-cover transition-transform duration-700 group-hover:scale-105"
								/>
							</div>
							<div class="p-6">
								<h3 class="text-foreground mb-2 text-xl font-bold">{useCase.title}</h3>
								<p class="text-foreground-muted">{useCase.description}</p>
							</div>
						</div>
					{/each}
				</div>
			</div>
		</div>
	</section>

	<!-- Core Features Section -->
	<section id="features" class="relative py-32">
		<div
			class="absolute inset-0 bg-[url('https://images.unsplash.com/photo-1607082349566-187342175e2f?w=1200&auto=format&fit=crop&q=80')] bg-cover bg-center bg-no-repeat opacity-5"
		></div>
		<div class="relative container mx-auto px-4">
			<div class="mx-auto max-w-6xl">
				<div class="mb-16 text-center" in:fade={{ duration: 800 }}>
					<h2 class="text-foreground mb-4 text-4xl font-bold">Powerful Features</h2>
					<p class="text-foreground-muted text-xl">
						Everything you need for perfect product photos
					</p>
				</div>
				<div class="grid gap-8 md:grid-cols-2 lg:grid-cols-3">
					{#each [{ title: 'AI Enhancement', description: 'Automatically enhance your product photos with our advanced AI technology.', icon: `<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 9a2 2 0 012-2h.93a2 2 0 001.664-.89l.812-1.22A2 2 0 0110.07 4h3.86a2 2 0 011.664.89l.812 1.22A2 2 0 0018.07 7H19a2 2 0 012 2v9a2 2 0 01-2 2H5a2 2 0 01-2-2V9z" /><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 13a3 3 0 11-6 0 3 3 0 016 0z" />` }, { title: 'Style Customization', description: 'Customize every aspect of your product photos to match your brand.', icon: `<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 21a4 4 0 01-4-4V5a2 2 0 012-2h4a2 2 0 012 2v12a4 4 0 01-4 4zm0 0h12a2 2 0 002-2v-4a2 2 0 00-2-2h-2.343M11 7.343l1.657-1.657a2 2 0 012.828 0l2.829 2.829a2 2 0 010 2.828l-8.486 8.485M7 17h.01" />` }, { title: 'Batch Processing', description: 'Process multiple product photos at once with our batch processing feature.', icon: `<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 16v1a3 3 0 003 3h10a3 3 0 003-3v-1m-4-4l-4 4m0 0l-4-4m4 4V4" />` }] as feature, i}
						<div
							class="group bg-surface rounded-2xl p-8 shadow-lg transition-all hover:shadow-xl"
							in:fly={{ y: 50, duration: 800, delay: i * 200 }}
						>
							<div
								class="bg-primary/10 group-hover:bg-primary/20 mb-4 flex h-12 w-12 items-center justify-center rounded-xl transition-all duration-300 group-hover:scale-110"
							>
								<svg
									class="text-primary h-6 w-6 transition-transform duration-300 group-hover:scale-110"
									fill="none"
									viewBox="0 0 24 24"
									stroke="currentColor"
								>
									{@html feature.icon}
								</svg>
							</div>
							<h3 class="text-foreground mb-2 text-xl font-bold">{feature.title}</h3>
							<p class="text-foreground-muted">{feature.description}</p>
						</div>
					{/each}
				</div>
			</div>
		</div>
	</section>

	<section id="pricing">
		<PricingSection />
	</section>

	<section id="faq">
		<FAQSection />
	</section>

	<!-- Final CTA Section -->
	<section class="relative py-32">
		<div
			class="absolute inset-0 bg-[url('https://images.unsplash.com/photo-1607082348824-0a96f2a4b9da?w=1200&auto=format&fit=crop&q=80')] bg-cover bg-center bg-no-repeat opacity-5"
		></div>
		<div class="relative container mx-auto px-4">
			<div
				class="bg-primary mx-auto max-w-4xl rounded-3xl px-8 py-16 text-center"
				in:scale={{ duration: 800 }}
			>
				<h2 class="text-on-primary mb-6 text-4xl font-bold">
					Ready to Transform Your Product Photos?
				</h2>
				<p class="text-on-primary/90 mb-8 text-xl">
					Join thousands of businesses already using AI Grapher to create stunning product images.
				</p>
				<a
					href="/app"
					class="group text-primary bg-surface inline-flex items-center justify-center rounded-lg px-8 py-3 text-base font-medium shadow-lg transition-all hover:scale-105"
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
			</div>
		</div>
	</section>

	<Footer />
</main>

<style>
	.container {
		max-width: 1280px;
	}

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
