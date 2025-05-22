<script lang="ts">
	import PublicLayout from '$lib/components/layouts/PublicLayout.svelte';
</script>

<PublicLayout
	title="Terms of Service"
	description="Read our terms of service to understand the rules and guidelines for using AI Grapher's services."
>
	<div class="py-16">
		<h1 class="text-foreground mb-12 text-center text-4xl font-bold">Terms of Service</h1>

		<div class="prose prose-lg mx-auto">
			<p class="text-foreground-muted">Last updated: March 15, 2024</p>

			<h2>Agreement to Terms</h2>
			<p>
				By accessing or using AI Grapher's services, you agree to be bound by these Terms of
				Service. If you disagree with any part of these terms, you may not access our services.
			</p>

			<h2>Use of Service</h2>
			<p>Our service is available to users who:</p>
			<ul>
				<li>Are at least 18 years old</li>
				<li>Have the legal capacity to enter into binding contracts</li>
				<li>Will use the service in compliance with these terms</li>
			</ul>

			<h2>Service Rules</h2>
			<p>When using our service, you agree not to:</p>
			<ul>
				<li>Upload content that infringes on intellectual property rights</li>
				<li>Use the service for any illegal purposes</li>
				<li>Attempt to reverse engineer our AI technology</li>
				<li>Share your account credentials with others</li>
			</ul>

			<h2>Intellectual Property</h2>
			<p>
				You retain ownership of your original product images. However, you grant AI Grapher a
				license to use your content to provide and improve our services. The AI-generated images are
				licensed to you according to your subscription plan.
			</p>

			<h2>Limitation of Liability</h2>
			<p>
				AI Grapher is not liable for any indirect, incidental, special, consequential, or punitive
				damages resulting from your use of or inability to use our service.
			</p>

			<h2>Changes to Terms</h2>
			<p>
				We reserve the right to modify these terms at any time. We will notify users of any material
				changes via email or through our website.
			</p>

			<h2>Contact Us</h2>
			<p>
				If you have any questions about these Terms of Service, please contact us at
				<a href="mailto:legal@aigrapher.com" class="text-primary hover:underline"
					>legal@aigrapher.com</a
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
