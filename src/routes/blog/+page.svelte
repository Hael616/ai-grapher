<script lang="ts">
	import PublicLayout from '$lib/components/layouts/PublicLayout.svelte';
	import { fade, fly } from 'svelte/transition';

	const featuredPost = {
		title: 'The Future of Product Photography: AI-Powered Solutions',
		date: 'March 15, 2024',
		description:
			'Discover how AI is revolutionizing product photography, making professional-quality images accessible to businesses of all sizes.',
		image:
			'https://images.unsplash.com/photo-1607082349566-187342175e2f?w=1200&auto=format&fit=crop&q=80',
		readTime: '5 min read'
	};

	const recentPosts = [
		{
			title: 'How to Choose the Perfect Product Photography Style',
			date: 'March 10, 2024',
			description:
				'Learn about different product photography styles and how to choose the right one for your brand.',
			image:
				'https://images.unsplash.com/photo-1607083206968-13611e3d76db?w=800&auto=format&fit=crop&q=80',
			readTime: '4 min read'
		},
		{
			title: 'Debunking Myths About AI Photography',
			date: 'March 5, 2024',
			description:
				'Separating fact from fiction: Understanding what AI can and cannot do in product photography.',
			image:
				'https://images.unsplash.com/photo-1607082348824-0a96f2a4b9da?w=800&auto=format&fit=crop&q=80',
			readTime: '6 min read'
		}
	];
</script>

<PublicLayout
	title="Blog"
	description="Read the latest insights about AI-powered product photography, e-commerce trends, and visual marketing strategies."
>
	<div class="py-16">
		<h1 class="text-foreground mb-12 text-center text-4xl font-bold">Blog</h1>

		<!-- Featured Post -->
		<div class="mb-16" in:fade={{ duration: 800 }}>
			<div class="bg-surface overflow-hidden rounded-2xl shadow-lg">
				<div class="grid lg:grid-cols-2">
					<div class="relative aspect-[4/3] lg:aspect-auto">
						<img
							src={featuredPost.image}
							alt={featuredPost.title}
							class="h-full w-full object-cover transition-transform duration-700 hover:scale-105"
						/>
					</div>
					<div class="flex flex-col justify-center p-8">
						<div class="text-foreground-muted mb-4 flex items-center gap-4 text-sm">
							<span>{featuredPost.date}</span>
							<span>•</span>
							<span>{featuredPost.readTime}</span>
						</div>
						<h2 class="text-foreground mb-4 text-3xl font-bold">{featuredPost.title}</h2>
						<p class="text-foreground-muted mb-6 text-lg">{featuredPost.description}</p>
						<a href="#" class="text-primary inline-flex items-center font-medium hover:underline">
							Read more
							<svg class="ml-2 h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
								<path
									stroke-linecap="round"
									stroke-linejoin="round"
									stroke-width="2"
									d="M14 5l7 7m0 0l-7 7m7-7H3"
								/>
							</svg>
						</a>
					</div>
				</div>
			</div>
		</div>

		<!-- Recent Posts -->
		<h2 class="text-foreground mb-8 text-2xl font-bold">Recent Posts</h2>
		<div class="grid gap-8 md:grid-cols-2">
			{#each recentPosts as post, i}
				<div
					class="bg-surface overflow-hidden rounded-2xl shadow-lg"
					in:fly={{ y: 50, duration: 800, delay: i * 200 }}
				>
					<div class="aspect-w-16 aspect-h-9">
						<img
							src={post.image}
							alt={post.title}
							class="h-full w-full object-cover transition-transform duration-700 hover:scale-105"
						/>
					</div>
					<div class="p-6">
						<div class="text-foreground-muted mb-4 flex items-center gap-4 text-sm">
							<span>{post.date}</span>
							<span>•</span>
							<span>{post.readTime}</span>
						</div>
						<h3 class="text-foreground mb-3 text-xl font-bold">{post.title}</h3>
						<p class="text-foreground-muted mb-4">{post.description}</p>
						<a href="#" class="text-primary inline-flex items-center font-medium hover:underline">
							Read more
							<svg class="ml-2 h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
								<path
									stroke-linecap="round"
									stroke-linejoin="round"
									stroke-width="2"
									d="M14 5l7 7m0 0l-7 7m7-7H3"
								/>
							</svg>
						</a>
					</div>
				</div>
			{/each}
		</div>
	</div>
</PublicLayout>

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
