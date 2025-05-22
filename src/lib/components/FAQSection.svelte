<script lang="ts">
	import { slide } from 'svelte/transition';

	interface FAQ {
		question: string;
		answer: string;
	}

	const faqs: FAQ[] = [
		{
			question: 'How does AI Grapher work?',
			answer:
				'Simply upload your product image, choose a style, and our AI will generate professional-quality photos in seconds.'
		},
		{
			question: 'What types of products can I use?',
			answer:
				'AI Grapher works with any product type - from clothing and accessories to electronics and home goods.'
		},
		{
			question: 'How many credits do I need?',
			answer:
				'Each image generation uses one credit. Buy credits as you need them, with no minimum purchase required.'
		},
		{
			question: 'What resolution are the generated images?',
			answer:
				'Image resolution depends on your plan. Free and Starter plans get 720p, Creator plan gets 1080p, and Pro plan supports up to 4K resolution.'
		},
		{
			question: 'Can I use the images commercially?',
			answer:
				'Commercial usage is available on the Pro plan only. Free, Starter, and Creator plans are for personal use only.'
		},
		{
			question: 'How long do credits last?',
			answer:
				'Monthly plan credits expire at the end of each billing cycle. Additional credit packs are valid for 60 days from purchase.'
		}
	];

	let openIndex: number | null = null;

	function toggleFAQ(index: number): void {
		openIndex = openIndex === index ? null : index;
	}
</script>

<section class="py-20">
	<div class="container mx-auto px-4">
		<h2 class="mb-12 text-center text-3xl font-bold">Frequently Asked Questions</h2>
		<div class="mx-auto max-w-3xl space-y-4">
			{#each faqs as faq, index}
				<div class="bg-surface rounded-lg">
					<button
						class="flex w-full items-center justify-between p-6 text-left"
						on:click={() => toggleFAQ(index)}
					>
						<h3 class="text-xl font-semibold">{faq.question}</h3>
						<svg
							class="text-foreground-muted h-6 w-6 transform transition-transform duration-300 {openIndex ===
							index
								? 'rotate-180'
								: ''}"
							fill="none"
							viewBox="0 0 24 24"
							stroke="currentColor"
						>
							<path
								stroke-linecap="round"
								stroke-linejoin="round"
								stroke-width="2"
								d="M19 9l-7 7-7-7"
							/>
						</svg>
					</button>
					{#if openIndex === index}
						<div class="border-border border-t px-6 pt-2 pb-6" transition:slide={{ duration: 300 }}>
							<p class="text-foreground-muted">{faq.answer}</p>
						</div>
					{/if}
				</div>
			{/each}
		</div>
	</div>
</section>

<style>
	.container {
		max-width: 1280px;
	}
</style>
