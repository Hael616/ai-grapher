<script lang="ts">
	import { page } from '$app/stores';
	import { onMount } from 'svelte';
	import { fade, fly } from 'svelte/transition';

	let isScrolled = false;
	let isMobileMenuOpen = false;
	const { session } = $page.data;

	onMount(() => {
		const handleScroll = () => {
			isScrolled = window.scrollY > 0;
		};

		window.addEventListener('scroll', handleScroll);
		return () => window.removeEventListener('scroll', handleScroll);
	});

	function toggleMobileMenu() {
		isMobileMenuOpen = !isMobileMenuOpen;
	}

	function closeMobileMenu() {
		isMobileMenuOpen = false;
	}
</script>

<nav
	class="border-border bg-surface fixed top-0 right-0 left-0 z-50 border-b transition-all duration-300 {isScrolled
		? 'shadow-lg'
		: ''}"
>
	<div class="container mx-auto px-4">
		<div class="flex h-16 items-center justify-between">
			<!-- Logo -->
			<a href="/" class="text-foreground flex items-center space-x-2">
				<span class="text-xl font-bold">AI Grapher</span>
			</a>

			<!-- Desktop Navigation -->
			<div class="hidden md:flex md:items-center md:space-x-8">
				<a href="/#product" class="text-foreground-muted hover:text-foreground transition-colors"
					>Product</a
				>
				<a href="/#features" class="text-foreground-muted hover:text-foreground transition-colors"
					>Features</a
				>
				<a href="/#pricing" class="text-foreground-muted hover:text-foreground transition-colors"
					>Pricing</a
				>
				<a href="/about" class="text-foreground-muted hover:text-foreground transition-colors"
					>About</a
				>
				<a href="/blog" class="text-foreground-muted hover:text-foreground transition-colors"
					>Blog</a
				>
				{#if session}
					<a href="/app" class="button button-primary">Go to App</a>
				{:else}
					<a href="/app" class="button button-primary">Get Started</a>
				{/if}
			</div>

			<!-- Mobile Menu Button -->
			<button
				type="button"
				class="text-foreground-muted hover:text-foreground md:hidden"
				on:click={toggleMobileMenu}
			>
				<svg class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
					{#if isMobileMenuOpen}
						<path
							stroke-linecap="round"
							stroke-linejoin="round"
							stroke-width="2"
							d="M6 18L18 6M6 6l12 12"
						/>
					{:else}
						<path
							stroke-linecap="round"
							stroke-linejoin="round"
							stroke-width="2"
							d="M4 6h16M4 12h16M4 18h16"
						/>
					{/if}
				</svg>
			</button>
		</div>
	</div>

	<!-- Mobile Menu -->
	{#if isMobileMenuOpen}
		<div
			class="border-border bg-surface border-t md:hidden"
			transition:fly={{ y: -20, duration: 200 }}
		>
			<div class="container mx-auto px-4 py-4">
				<div class="flex flex-col space-y-4">
					<a
						href="/#product"
						class="text-foreground-muted hover:text-foreground transition-colors"
						on:click={closeMobileMenu}>Product</a
					>
					<a
						href="/#features"
						class="text-foreground-muted hover:text-foreground transition-colors"
						on:click={closeMobileMenu}>Features</a
					>
					<a
						href="/#pricing"
						class="text-foreground-muted hover:text-foreground transition-colors"
						on:click={closeMobileMenu}>Pricing</a
					>
					<a
						href="/about"
						class="text-foreground-muted hover:text-foreground transition-colors"
						on:click={closeMobileMenu}>About</a
					>
					<a
						href="/blog"
						class="text-foreground-muted hover:text-foreground transition-colors"
						on:click={closeMobileMenu}>Blog</a
					>
					{#if session}
						<a href="/app" class="button button-primary" on:click={closeMobileMenu}>Go to App</a>
					{:else}
						<a href="/app" class="button button-primary" on:click={closeMobileMenu}>Get Started</a>
					{/if}
				</div>
			</div>
		</div>
	{/if}
</nav>

<style>
	.container {
		max-width: 1280px;
	}
</style>
