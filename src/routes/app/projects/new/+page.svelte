<script lang="ts">
	import { layoutStore } from '$lib/components/layout/layout.svelte';
	import { goto } from '$app/navigation';
	import { showToast } from '$lib/utils/toast';
	import FileUpload from '$lib/components/generate/FileUpload.svelte';

	// Set page title
	layoutStore.pageTitle = 'Create New Project';

	let currentStep = $state(1);
	let totalSteps = 2;
	let isSubmitting = $state(false);

	// Form data
	let projectName = $state('');
	let projectDescription = $state('');
	let selectedFiles: File[] = $state([]);

	const handleFileSelect = (event: CustomEvent<File[]>) => {
		selectedFiles = event.detail;
	};

	const handleNext = () => {
		if (currentStep === 1 && selectedFiles.length < 15) {
			showToast({
				message: 'Please upload at least 15 images',
				type: 'error'
			});
			return;
		}
		if (currentStep === 1 && selectedFiles.length > 30) {
			showToast({
				message: 'Please upload no more than 30 images',
				type: 'error'
			});
			return;
		}
		currentStep++;
	};

	const handleBack = () => {
		currentStep--;
	};

	const handleSubmit = async () => {
		if (!projectName.trim()) {
			showToast({
				message: 'Please enter a project name',
				type: 'error'
			});
			return;
		}

		isSubmitting = true;
		try {
			// TODO: Implement actual project creation
			await new Promise((resolve) => setTimeout(resolve, 1000)); // Simulate API call
			showToast({
				message: 'Project created successfully',
				type: 'success'
			});
			goto('/app/projects');
		} catch (error) {
			showToast({
				message: 'Failed to create project',
				type: 'error'
			});
		} finally {
			isSubmitting = false;
		}
	};
</script>

<div class="mx-auto max-w-3xl space-y-8">
	<!-- Progress Steps -->
	<div class="flex items-center justify-between">
		{#each Array(totalSteps) as _, i}
			<div class="flex items-center">
				<div
					class="flex h-8 w-8 items-center justify-center rounded-full {currentStep > i + 1
						? 'bg-primary text-white'
						: currentStep === i + 1
							? 'border-primary text-primary border-2'
							: 'border-2 border-gray-300 text-gray-300'}"
				>
					{i + 1}
				</div>
				{#if i < totalSteps - 1}
					<div class="h-0.5 w-24 {currentStep > i + 1 ? 'bg-primary' : 'bg-gray-300'}"></div>
				{/if}
			</div>
		{/each}
	</div>

	<!-- Step 1: Upload Images -->
	{#if currentStep === 1}
		<div class="space-y-6">
			<div class="space-y-2 text-center">
				<h1 class="text-2xl font-semibold">Upload Product Images</h1>
				<p class="text-gray-600">
					Upload 15-30 images of your product in good lighting from different angles
				</p>
			</div>

			<div class="space-y-4">
				<FileUpload
					maxFiles={30}
					minFiles={15}
					title="Upload 15-30 product images"
					subtitle="Upload high-quality images of your product from different angles. Supported: JPG, PNG. Transparent background recommended."
					aspectRatio="aspect-square"
					on:files={handleFileSelect}
				/>
				<div class="text-center text-sm text-gray-500">
					{selectedFiles.length} images selected (min: 15, max: 30)
				</div>
			</div>

			<!-- Image Examples Section -->
			<div class="border-border bg-surface rounded-lg border p-6">
				<h2 class="mb-4 text-lg font-semibold">Image Examples</h2>
				<div class="grid gap-6 md:grid-cols-2">
					<!-- Good Examples -->
					<div class="space-y-4">
						<h3 class="flex items-center gap-2 text-sm font-medium text-green-600">
							<iconify-icon icon="mdi:check-circle" width="20" height="20"></iconify-icon>
							Good Examples
						</h3>
						<div class="grid gap-4 sm:grid-cols-2">
							<div class="space-y-2">
								<img
									src="https://images.unsplash.com/photo-1560343090-f0409e92791a?w=400&h=400&fit=crop"
									alt="Good lighting example"
									class="aspect-square rounded-lg object-cover"
								/>
								<p class="text-xs text-gray-600">Good lighting, clear product</p>
							</div>
							<div class="space-y-2">
								<img
									src="https://images.unsplash.com/photo-1585386959984-a4155224a1ad?w=400&h=400&fit=crop"
									alt="Multiple angles example"
									class="aspect-square rounded-lg object-cover"
								/>
								<p class="text-xs text-gray-600">Multiple angles, consistent background</p>
							</div>
						</div>
					</div>

					<!-- Bad Examples -->
					<div class="space-y-4">
						<h3 class="flex items-center gap-2 text-sm font-medium text-red-600">
							<iconify-icon icon="mdi:close-circle" width="20" height="20"></iconify-icon>
							Bad Examples
						</h3>
						<div class="grid gap-4 sm:grid-cols-2">
							<div class="space-y-2">
								<img
									src="https://images.unsplash.com/photo-1585386959984-a4155224a1ad?w=400&h=400&fit=crop&brightness=0.3"
									alt="Poor lighting example"
									class="aspect-square rounded-lg object-cover"
								/>
								<p class="text-xs text-gray-600">Poor lighting, hard to see details</p>
							</div>
							<div class="space-y-2">
								<img
									src="https://images.unsplash.com/photo-1585386959984-a4155224a1ad?w=400&h=400&fit=crop&blur=5"
									alt="Blurry example"
									class="aspect-square rounded-lg object-cover"
								/>
								<p class="text-xs text-gray-600">Blurry, inconsistent background</p>
							</div>
						</div>
					</div>
				</div>
			</div>

			<div class="flex justify-end">
				<button
					class="button button-primary"
					onclick={handleNext}
					disabled={selectedFiles.length < 15 || selectedFiles.length > 30}
				>
					Next Step
					<iconify-icon icon="mdi:arrow-right" width="20" height="20"></iconify-icon>
				</button>
			</div>
		</div>
	{/if}

	<!-- Step 2: Project Details -->
	{#if currentStep === 2}
		<div class="space-y-6">
			<div class="space-y-2 text-center">
				<h1 class="text-2xl font-semibold">Project Details</h1>
				<p class="text-gray-600">Enter the details for your new project</p>
			</div>

			<div class="space-y-4">
				<div class="space-y-2">
					<label for="projectName" class="block text-sm font-medium">Project Name</label>
					<input
						type="text"
						id="projectName"
						bind:value={projectName}
						placeholder="Enter project name"
						class="input w-full"
						required
					/>
				</div>

				<div class="space-y-2">
					<label for="projectDescription" class="block text-sm font-medium">Description</label>
					<textarea
						id="projectDescription"
						bind:value={projectDescription}
						placeholder="Enter project description"
						rows="4"
						class="input w-full"
					></textarea>
				</div>
			</div>

			<div class="flex justify-between">
				<button class="button button-outline-soft" onclick={handleBack}>
					<iconify-icon icon="mdi:arrow-left" width="20" height="20"></iconify-icon>
					Back
				</button>
				<button
					class="button button-primary"
					onclick={handleSubmit}
					disabled={isSubmitting || !projectName.trim()}
				>
					{#if isSubmitting}
						<iconify-icon icon="svg-spinners:blocks-shuffle-2" width="20" height="20"
						></iconify-icon>
						Creating...
					{:else}
						<iconify-icon icon="mdi:check" width="20" height="20"></iconify-icon>
						Create Project
					{/if}
				</button>
			</div>
		</div>
	{/if}

	<!-- Tips Section -->
	<div class="border-border bg-surface rounded-lg border p-4">
		<h2 class="mb-2 text-lg font-semibold">Tips</h2>
		<ul class="list-inside list-disc space-y-1 text-sm text-gray-600">
			<li>Use high-quality images with good lighting</li>
			<li>Capture your product from different angles</li>
			<li>Ensure the product is clearly visible in each image</li>
			<li>Use a consistent background for better results</li>
		</ul>
	</div>
</div>
