<script lang="ts">
	import PublicLayout from '$lib/components/layouts/PublicLayout.svelte';
</script>

<PublicLayout
	title="Privacy Policy"
	description="Learn about how AI Grapher collects, uses, and protects your personal information."
>
	<div class="py-16">
		<h1 class="text-foreground mb-12 text-center text-4xl font-bold">Privacy Policy</h1>

		<div class="prose prose-lg mx-auto">
			<p class="text-foreground-muted">Last updated: March 15, 2024</p>

			<h2>Introduction</h2>
			<p>
				At AI Grapher, we take your privacy seriously. This Privacy Policy explains how we collect,
				use, disclose, and safeguard your information when you use our AI-powered product
				photography service.
			</p>

			<h2>Information We Collect</h2>
			<p>We collect information that you provide directly to us, including:</p>
			<ul>
				<li>Account information (name, email address, password)</li>
				<li>Payment information (processed securely through our payment providers)</li>
				<li>Product images and related content you upload</li>
				<li>Communications with our support team</li>
			</ul>

			<h2>How We Use Your Information</h2>
			<p>We use the information we collect to:</p>
			<ul>
				<li>Provide and maintain our service</li>
				<li>Process your transactions</li>
				<li>Send you technical notices and support messages</li>
				<li>Communicate with you about products, services, and events</li>
				<li>Improve our AI models and service quality</li>
			</ul>

			<h2>Data Security</h2>
			<p>
				We implement appropriate technical and organizational measures to protect your personal
				information against unauthorized access, alteration, disclosure, or destruction.
			</p>

			<h2>Contact Us</h2>
			<p>
				If you have any questions about this Privacy Policy, please contact us at
				<a href="mailto:privacy@aigrapher.com" class="text-primary hover:underline"
					>privacy@aigrapher.com</a
				>
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

	:global(.prose ul) {
		color: var(--color-foreground-muted);
		margin-bottom: 1.5em;
		padding-left: 1.5em;
	}

	:global(.prose li) {
		margin-bottom: 0.5em;
	}
</style>
