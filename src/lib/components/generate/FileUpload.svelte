<script lang="ts">
	import { createEventDispatcher } from 'svelte';

	const {
		maxFiles = 3,
		acceptedFileTypes = ['image/jpeg', 'image/png'],
		minFiles = 0,
		title = 'Drag & drop or click to upload',
		subtitle = 'Upload images. Supported: JPG, PNG. Transparent background recommended.',
		aspectRatio = 'aspect-video'
	} = $props();

	const dispatch = createEventDispatcher<{
		files: File[];
	}>();

	let isDragging = $state(false);
	let files: File[] = $state([]);
	let previewUrls: string[] = $state([]);
	let currentIndex = $state(0);

	const handleDragOver = (e: DragEvent) => {
		e.preventDefault();
		isDragging = true;
	};

	const handleDragLeave = () => {
		isDragging = false;
	};

	const handleDrop = (e: DragEvent) => {
		e.preventDefault();
		isDragging = false;

		const droppedFiles = Array.from(e.dataTransfer?.files || []);
		const validFiles = droppedFiles.filter((file) => acceptedFileTypes.includes(file.type));

		if (validFiles.length > 0) {
			handleFiles(validFiles);
		}
	};

	const handleFileInput = (e: Event) => {
		const input = e.target as HTMLInputElement;
		const selectedFiles = Array.from(input.files || []);
		const validFiles = selectedFiles.filter((file) => acceptedFileTypes.includes(file.type));

		if (validFiles.length > 0) {
			handleFiles(validFiles);
		}
	};

	const handleFiles = (newFiles: File[]) => {
		const remainingSlots = maxFiles - files.length;
		if (remainingSlots <= 0) return;

		const filesToAdd = newFiles.slice(0, remainingSlots);
		files = [...files, ...filesToAdd];
		previewUrls = files.map((file) => URL.createObjectURL(file));
		dispatch('files', files);
	};

	const removeFile = (e: Event, index: number) => {
		e.preventDefault();
		e.stopPropagation();
		files = files.filter((_, i) => i !== index);
		previewUrls = previewUrls.filter((_, i) => i !== index);
		if (currentIndex >= files.length) {
			currentIndex = Math.max(0, files.length - 1);
		}
		dispatch('files', files);
	};

	const setCurrentIndex = (e: Event, index: number) => {
		e.preventDefault();
		e.stopPropagation();
		currentIndex = index;
	};
</script>

<div
	class="bg-surface relative flex h-[400px] cursor-pointer flex-col items-center justify-center rounded-lg border-2 border-dashed p-8 text-center transition-colors {isDragging
		? 'border-primary bg-primary/5'
		: 'hover:border-primary/50 border-gray-300'}"
	ondragover={handleDragOver}
	ondragleave={handleDragLeave}
	ondrop={handleDrop}
	role="button"
	tabindex="0"
>
	<input
		type="file"
		accept={acceptedFileTypes.join(',')}
		multiple
		class="absolute inset-0 cursor-pointer opacity-0"
		onchange={handleFileInput}
	/>

	{#if previewUrls.length > 0}
		<div class="flex h-full w-full flex-col">
			<!-- Main Image -->
			<div class="relative min-h-0 flex-1">
				<div class="absolute inset-0 overflow-auto">
					<img
						src={previewUrls[currentIndex]}
						alt="Preview {currentIndex + 1}"
						class="h-full w-full object-contain"
					/>
				</div>
				<button
					class="button button-outline-soft absolute top-2 right-2 z-10"
					onclick={(e) => removeFile(e, currentIndex)}
				>
					<iconify-icon icon="mdi:close" width="20" height="20"></iconify-icon>
					<span class="sr-only">Remove image {currentIndex + 1}</span>
				</button>
			</div>

			<!-- Thumbnails -->
			<div class="mt-4 flex justify-center gap-2 overflow-x-auto py-2">
				{#each previewUrls as url, index}
					<button
						class="relative aspect-square w-16 flex-shrink-0 overflow-hidden rounded-lg border-2 {currentIndex ===
						index
							? 'border-primary'
							: 'border-transparent'}"
						onclick={(e) => setCurrentIndex(e, index)}
					>
						<img src={url} alt="Thumbnail {index + 1}" class="h-full w-full object-cover" />
					</button>
				{/each}
				{#if files.length < maxFiles}
					<div
						class="flex aspect-square w-16 flex-shrink-0 cursor-pointer items-center justify-center rounded-lg border-2 border-dashed border-gray-300"
					>
						<iconify-icon icon="mdi:plus" width="24" height="24" class="text-gray-400"
						></iconify-icon>
					</div>
				{/if}
			</div>
		</div>
	{:else}
		<iconify-icon icon="mdi:upload" width="48" height="48" class="text-gray-400"></iconify-icon>
		<div class="mt-4 space-y-1">
			<p class="text-sm font-medium">{title}</p>
			<p class="text-xs text-gray-500">{subtitle}</p>
		</div>
	{/if}
</div>
