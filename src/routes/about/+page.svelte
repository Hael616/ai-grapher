<script lang="ts">
	import PublicLayout from '$lib/components/layouts/PublicLayout.svelte';
</script>

<PublicLayout
	title="About"
	description="Learn about AI Grapher's mission to revolutionize product photography with AI technology."
>
	<div class="py-16">
		<h1 class="text-foreground mb-12 text-center text-4xl font-bold">About Us</h1>

		<div class="prose prose-lg mx-auto">
			<h2>Our Mission</h2>
			<p>
				At AI Grapher, we're on a mission to democratize professional product photography. We
				believe that every business, regardless of size or budget, deserves access to high-quality
				product images that drive sales and build trust with customers.
			</p>

			<h2>Our Story</h2>
			<p>
				Founded in 2024, AI Grapher was born from a simple observation: while e-commerce continues
				to grow, many businesses struggle with the cost and complexity of professional product
				photography. Our team of AI experts and photography professionals came together to solve
				this problem using cutting-edge artificial intelligence.
			</p>

			<h2>Our Technology</h2>
			<p>
				We've developed proprietary AI models that understand the nuances of product photography.
				Our system can analyze product images, understand lighting and composition, and generate
				professional-quality photos that meet industry standards. The technology continues to learn
				and improve, ensuring that our users always get the best possible results.
			</p>

			<h2>Our Team</h2>
			<p>
				Our diverse team brings together expertise in artificial intelligence, photography,
				e-commerce, and user experience design. We're united by a shared passion for making
				professional product photography accessible to everyone.
			</p>
		</div>
	</div>
</PublicLayout>

<style>
	:global(.prose) {
		max-width: 65ch;
	}

	:global(.prose h2) {
		color: var(--color-foreground);
		margin-top: 2em;
		margin-bottom: 1em;
	}

	:global(.prose p) {
		color: var(--color-foreground-muted);
		margin-bottom: 1.5em;
		line-height: 1.7;
	}
</style>
