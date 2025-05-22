<script>
	const currentYear = new Date().getFullYear();
</script>

<footer class="bg-surface border-border border-t">
	<div class="container mx-auto px-4 py-12">
		<div class="grid grid-cols-2 gap-8 md:grid-cols-4">
			<!-- AI Grapher -->
			<div>
				<h3 class="text-foreground text-lg font-semibold">AI Grapher</h3>
				<p class="text-foreground-muted mt-4 text-sm">
					Transform your product photography with AI-powered image generation.
				</p>
			</div>

			<!-- Product -->
			<div>
				<h3 class="text-foreground text-lg font-semibold">Product</h3>
				<ul class="mt-4 space-y-2">
					<li>
						<a href="/#features" class="text-foreground-muted hover:text-foreground">Features</a>
					</li>
					<li>
						<a href="/#templates" class="text-foreground-muted hover:text-foreground">Templates</a>
					</li>
					<li>
						<a href="/#pricing" class="text-foreground-muted hover:text-foreground">Pricing</a>
					</li>
				</ul>
			</div>

			<!-- Company -->
			<div>
				<h3 class="text-foreground text-lg font-semibold">Company</h3>
				<ul class="mt-4 space-y-2">
					<li>
						<a href="/about" class="text-foreground-muted hover:text-foreground">About</a>
					</li>
					<li>
						<a href="/blog" class="text-foreground-muted hover:text-foreground">Blog</a>
					</li>
					<li>
						<a href="/contact" class="text-foreground-muted hover:text-foreground">Contact</a>
					</li>
				</ul>
			</div>

			<!-- Legal -->
			<div>
				<h3 class="text-foreground text-lg font-semibold">Legal</h3>
				<ul class="mt-4 space-y-2">
					<li>
						<a href="/privacy" class="text-foreground-muted hover:text-foreground">Privacy Policy</a
						>
					</li>
					<li>
						<a href="/terms" class="text-foreground-muted hover:text-foreground">Terms of Service</a
						>
					</li>
				</ul>
			</div>
		</div>

		<div class="border-border mt-12 border-t pt-8">
			<p class="text-foreground-muted text-center text-sm">
				© {new Date().getFullYear()} AI Grapher. All rights reserved.
			</p>
		</div>
	</div>
</footer>

<style>
	.container {
		max-width: 1280px;
	}
</style>
