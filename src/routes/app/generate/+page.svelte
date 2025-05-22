<script lang="ts">
	import { layoutStore } from '$lib/components/layout/layout.svelte';
	import FileUpload from '$lib/components/generate/FileUpload.svelte';
	import ProductTypeSelector from '$lib/components/generate/ProductTypeSelector.svelte';
	import StyleSelector from '$lib/components/generate/StyleSelector.svelte';

	// Set page title
	layoutStore.pageTitle = 'Generate New Product Image';

	let selectedFiles: File[] = $state([]);
	let selectedType: string | null = $state(null);
	let selectedStyle: string | null = $state(null);
	let isGenerating = $state(false);
	let generatedImages: string[] = $state([]);

	// Mock data - replace with actual data from your backend
	const user = {
		credits: {
			balance: 8
		}
	};

	const handleFileSelect = (event: CustomEvent<File[]>) => {
		selectedFiles = event.detail;
	};

	const handleTypeSelect = (event: CustomEvent<string>) => {
		selectedType = event.detail;
	};

	const handleStyleSelect = (event: CustomEvent<string>) => {
		selectedStyle = event.detail;
	};

	const handleGenerate = async () => {
		if (selectedFiles.length === 0 || !selectedType || !selectedStyle) return;

		isGenerating = true;
		// TODO: Implement actual image generation
		await new Promise((resolve) => setTimeout(resolve, 2000)); // Simulate API call
		generatedImages = selectedFiles.map(() => 'https://placehold.co/800x600');
		isGenerating = false;
	};
</script>

<div class="mx-auto max-w-3xl space-y-8">
	<!-- Welcome Section -->
	<div class="space-y-2 text-center">
		<h1 class="text-2xl font-semibold">Generate New Product Image</h1>
		<p class="text-gray-600">
			Welcome! Upload your product image and generate stunning visuals in seconds.
		</p>
	</div>

	<div class="space-y-8">
		<!-- Upload Section -->
		<section class="space-y-4">
			<h2 class="text-lg font-semibold">Upload Product Image</h2>
			<FileUpload on:file={handleFileSelect} />
		</section>

		<!-- Product Type Section -->
		<section class="space-y-4">
			<h2 class="text-lg font-semibold">Select Product Type</h2>
			<p class="text-sm text-gray-500">This helps us style the scene to match your product.</p>
			<ProductTypeSelector initialType={selectedType} on:select={handleTypeSelect} />
		</section>

		<!-- Style Section -->
		<section class="space-y-4">
			<h2 class="text-lg font-semibold">Choose a Style / Scene</h2>
			<p class="text-sm text-gray-500">How should your product be presented?</p>
			<StyleSelector initialStyle={selectedStyle} on:select={handleStyleSelect} />
		</section>

		<!-- Generate Section -->
		<section class="space-y-4">
			<button
				class="button button-primary w-full"
				on:click={handleGenerate}
				disabled={selectedFiles.length === 0 || !selectedType || !selectedStyle || isGenerating}
			>
				{#if isGenerating}
					<iconify-icon icon="svg-spinners:blocks-shuffle-2" width="20" height="20"></iconify-icon>
					Generating...
				{:else}
					<iconify-icon icon="mdi:lightning-bolt" width="20" height="20"></iconify-icon>
					Generate Images
				{/if}
			</button>
			<p class="text-center text-sm text-gray-500">
				You have <span class="font-medium">{user.credits.balance} credits</span> remaining.
			</p>
		</section>

		{#if generatedImages.length > 0}
			<!-- Generated Images Section -->
			<section class="space-y-4">
				<h2 class="text-lg font-semibold">Generated Images</h2>
				<div class="grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
					{#each generatedImages as image, index}
						<div class="card">
							<img
								src={image}
								alt="Generated image {index + 1}"
								class="w-full rounded-t-lg object-cover"
							/>
							<div class="card-content flex justify-between">
								<a href={image} target="_blank" class="button button-outline-soft">
									<iconify-icon icon="mdi:eye" width="20" height="20"></iconify-icon>
									View Full
								</a>
								<div class="flex gap-2">
									<a href={image} download class="button button-outline-soft">
										<iconify-icon icon="mdi:download" width="20" height="20"></iconify-icon>
										Download
									</a>
									<button class="button button-outline-soft" on:click={handleGenerate}>
										<iconify-icon icon="mdi:refresh" width="20" height="20"></iconify-icon>
										Regenerate
									</button>
								</div>
							</div>
						</div>
					{/each}
				</div>
			</section>
		{/if}

		<!-- Tips Section -->
		<section class="rounded-lg border bg-gray-50 p-4">
			<h2 class="mb-2 text-lg font-semibold">Tips</h2>
			<ul class="list-inside list-disc space-y-1 text-sm text-gray-600">
				<li>Transparent images work best for apparel and skincare products.</li>
				<li>You can refine the background later in "My Projects".</li>
			</ul>
		</section>
	</div>
</div>
