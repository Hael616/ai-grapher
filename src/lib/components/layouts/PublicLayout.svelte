<script lang="ts">
	import Navbar from '$lib/components/Navbar.svelte';
	import Footer from '$lib/components/Footer.svelte';
	import { fade } from 'svelte/transition';
	import type { Snippet } from 'svelte';

	let { title, description, children }: { title: string; description: string; children: Snippet } =
		$props();
</script>

<svelte:head>
	<title>{title} - AI Grapher</title>
	<meta name="description" content={description} />
</svelte:head>

<Navbar />

<main class="bg-background min-h-screen" in:fade={{ duration: 300 }}>
	<div class="container mx-auto px-4 py-16">
		{@render children()}
	</div>
</main>

<Footer />

<style>
	.container {
		max-width: 1280px;
	}
</style>
