<script lang="ts">
	import PublicLayout from '$lib/components/layouts/PublicLayout.svelte';
</script>

<PublicLayout
	title="Contact"
	description="Get in touch with the AI Grapher team. We're here to help with your product photography needs."
>
	<div class="py-16">
		<h1 class="text-foreground mb-12 text-center text-4xl font-bold">Contact Us</h1>

		<div class="mx-auto max-w-4xl">
			<div class="grid gap-12 md:grid-cols-2">
				<!-- Contact Form -->
				<div class="bg-surface rounded-2xl p-8 shadow-lg">
					<h2 class="text-foreground mb-6 text-2xl font-bold">Send us a message</h2>
					<form class="space-y-6">
						<div>
							<label for="name" class="text-foreground mb-2 block text-sm font-medium">Name</label>
							<input
								type="text"
								id="name"
								class="bg-background border-border text-foreground focus:border-primary w-full rounded-lg border px-4 py-2 focus:outline-none"
								required
							/>
						</div>
						<div>
							<label for="email" class="text-foreground mb-2 block text-sm font-medium">Email</label
							>
							<input
								type="email"
								id="email"
								class="bg-background border-border text-foreground focus:border-primary w-full rounded-lg border px-4 py-2 focus:outline-none"
								required
							/>
						</div>
						<div>
							<label for="subject" class="text-foreground mb-2 block text-sm font-medium"
								>Subject</label
							>
							<input
								type="text"
								id="subject"
								class="bg-background border-border text-foreground focus:border-primary w-full rounded-lg border px-4 py-2 focus:outline-none"
								required
							/>
						</div>
						<div>
							<label for="message" class="text-foreground mb-2 block text-sm font-medium"
								>Message</label
							>
							<textarea
								id="message"
								rows="4"
								class="bg-background border-border text-foreground focus:border-primary w-full rounded-lg border px-4 py-2 focus:outline-none"
								required
							></textarea>
						</div>
						<button
							type="submit"
							class="bg-primary hover:bg-primary/90 text-primary-foreground w-full rounded-lg px-6 py-3 font-medium transition-colors"
						>
							Send Message
						</button>
					</form>
				</div>

				<!-- Contact Information -->
				<div class="space-y-8">
					<div>
						<h2 class="text-foreground mb-4 text-2xl font-bold">Get in Touch</h2>
						<p class="text-foreground-muted">
							Have questions about our AI-powered product photography service? We're here to help!
						</p>
					</div>

					<div>
						<h3 class="text-foreground mb-2 text-lg font-semibold">Email</h3>
						<a href="mailto:contact@aigrapher.com" class="text-primary hover:underline"
							>contact@aigrapher.com</a
						>
					</div>

					<div>
						<h3 class="text-foreground mb-2 text-lg font-semibold">Office Hours</h3>
						<p class="text-foreground-muted">Monday - Friday: 9:00 AM - 6:00 PM EST</p>
					</div>

					<div>
						<h3 class="text-foreground mb-4 text-lg font-semibold">Follow Us</h3>
						<div class="flex gap-4">
							<a
								href="https://twitter.com/aigrapher"
								target="_blank"
								rel="noopener noreferrer"
								class="text-foreground-muted hover:text-primary"
							>
								<svg class="h-6 w-6" fill="currentColor" viewBox="0 0 24 24">
									<path
										d="M8.29 20.251c7.547 0 11.675-6.253 11.675-11.675 0-.178 0-.355-.012-.53A8.348 8.348 0 0022 5.92a8.19 8.19 0 01-2.357.646 4.118 4.118 0 001.804-2.27 8.224 8.224 0 01-2.605.996 4.107 4.107 0 00-6.993 3.743 11.65 11.65 0 01-8.457-4.287 4.106 4.106 0 001.27 5.477A4.072 4.072 0 012.8 9.713v.052a4.105 4.105 0 003.292 4.022 4.095 4.095 0 01-1.853.07 4.108 4.108 0 003.834 2.85A8.233 8.233 0 012 18.407a11.616 11.616 0 006.29 1.84"
									/>
								</svg>
							</a>
							<a
								href="https://linkedin.com/company/aigrapher"
								target="_blank"
								rel="noopener noreferrer"
								class="text-foreground-muted hover:text-primary"
							>
								<svg class="h-6 w-6" fill="currentColor" viewBox="0 0 24 24">
									<path
										d="M19 0h-14c-2.761 0-5 2.239-5 5v14c0 2.761 2.239 5 5 5h14c2.762 0 5-2.239 5-5v-14c0-2.761-2.238-5-5-5zm-11 19h-3v-11h3v11zm-1.5-12.268c-.966 0-1.75-.79-1.75-1.764s.784-1.764 1.75-1.764 1.75.79 1.75 1.764-.783 1.764-1.75 1.764zm13.5 12.268h-3v-5.604c0-3.368-4-3.113-4 0v5.604h-3v-11h3v1.765c1.396-2.586 7-2.777 7 2.476v6.759z"
									/>
								</svg>
							</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</PublicLayout>

<style>
	.container {
		max-width: 1280px;
	}
</style>
