<script lang="ts">
	import { fly } from 'svelte/transition';
</script>

<div class="grid gap-12 md:grid-cols-2 lg:grid-cols-3">
	{#each [{ title: 'Upload Your Product', description: 'Simply upload a photo of your product. Any angle, any lighting - our AI can handle it.', image: 'https://images.unsplash.com/photo-1607082348824-0a96f2a4b9da?w=800&auto=format&fit=crop&q=80' }, { title: 'Choose Your Style', description: 'Select from our curated styles or create your own custom look.', image: 'https://images.unsplash.com/photo-1607083206968-13611e3d76db?w=800&auto=format&fit=crop&q=80' }, { title: 'Get Perfect Photos', description: 'Download your professionally styled product photos instantly.', image: 'https://images.unsplash.com/photo-1607082349566-187342175e2f?w=800&auto=format&fit=crop&q=80' }] as step, i}
		<div
			class="bg-surface rounded-2xl p-8 shadow-lg"
			in:fly={{ y: 50, duration: 800, delay: i * 200 }}
		>
			<div class="mb-6 aspect-video overflow-hidden rounded-xl">
				<img
					src={step.image}
					alt={step.title}
					class="h-full w-full object-cover transition-transform duration-500 hover:scale-105"
				/>
			</div>
			<h3 class="text-foreground mb-4 text-2xl font-bold">{step.title}</h3>
			<p class="text-foreground-muted">{step.description}</p>
		</div>
	{/each}
</div>
