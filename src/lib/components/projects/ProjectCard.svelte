<script lang="ts">
	import { showToast } from '$lib/utils/toast';
	import { toast } from 'svelte-sonner';

	export let project: {
		id: string;
		name: string;
		description: string;
		cover_image_url: string;
		model_status: string;
		created_at: string;
		generation_count: number;
	};

	// Helper function to get status color and icon
	function getStatusInfo(status: string) {
		switch (status) {
			case 'ready':
				return {
					color: 'text-green-600',
					bgColor: 'bg-green-50 dark:bg-green-950',
					icon: 'mdi:check-circle',
					label: 'Ready'
				};
			case 'training':
				return {
					color: 'text-blue-600',
					bgColor: 'bg-blue-50 dark:bg-blue-950',
					icon: 'mdi:progress-clock',
					label: 'Training'
				};
			case 'failed':
				return {
					color: 'text-red-600',
					bgColor: 'bg-red-50 dark:bg-red-950',
					icon: 'mdi:alert-circle',
					label: 'Failed'
				};
			case 'pending':
				return {
					color: 'text-yellow-600',
					bgColor: 'bg-yellow-50 dark:bg-yellow-950',
					icon: 'mdi:clock-outline',
					label: 'Pending'
				};
			default:
				return {
					color: 'text-foreground-muted',
					bgColor: 'bg-surface-hover',
					icon: 'mdi:help-circle',
					label: 'Unknown'
				};
		}
	}

	let statusInfo = getStatusInfo(project.model_status);
</script>

<div class="card group overflow-hidden p-0">
	<div class="relative">
		<img src={project.cover_image_url} alt={project.name} class="h-48 w-full object-cover" />
		{#if project.model_status !== 'ready'}
			<div
				class="absolute top-2 right-2 flex items-center gap-1.5 rounded-full px-2 py-1 {statusInfo.bgColor}"
			>
				<iconify-icon icon={statusInfo.icon} width="16" height="16" class="{statusInfo.color} flex"
				></iconify-icon>
				<span class={statusInfo.color}>{statusInfo.label}</span>
			</div>
		{/if}
		<div
			class="absolute inset-0 flex items-center justify-center bg-black/50 opacity-0 transition-opacity group-hover:opacity-100"
		>
			<div class="flex gap-2">
				<a
					href="/app/projects/{project.id}"
					class="button button-outline-soft border-white text-white hover:bg-white hover:text-black"
					aria-label="View project"
				>
					<iconify-icon icon="mdi:eye" width="20" height="20"></iconify-icon>
					View
				</a>
				<a
					href="/app/projects/{project.id}/generate"
					class="button button-primary {project.model_status !== 'ready'
						? 'cursor-not-allowed opacity-50'
						: ''}"
					aria-label="Generate images"
					onclick={(e) => {
						if (project.model_status !== 'ready') {
							e.preventDefault();
							if (project.model_status === 'failed') {
								showToast({
									message: 'Model training failed',
									type: 'error',
									action: {
										label: 'Retry',
										onClick: () => {
											// TODO: Implement retry logic
											toast.info('Aw, snap! This feature is coming soon.');
										}
									}
								});
							} else {
								showToast({
									message:
										project.model_status === 'pending'
											? 'Model is still being set up'
											: 'Model is not ready',
									type: 'info'
								});
							}
						}
					}}
				>
					<iconify-icon icon="mdi:lightning-bolt" width="20" height="20"></iconify-icon>
					Generate
				</a>
			</div>
		</div>
	</div>
	<div class="card-content p-4">
		<div class="mb-2">
			<h3 class="text-foreground font-medium">{project.name}</h3>
			<p class="text-foreground-muted text-sm">{project.description}</p>
		</div>
		<div class="flex flex-col gap-2">
			<div class="flex items-center justify-between text-sm">
				<div class="flex items-center gap-2">
					<iconify-icon
						icon="mdi:image-multiple"
						width="16"
						height="16"
						class="text-foreground-muted"
					></iconify-icon>
					<span class="text-foreground-muted">{project.generation_count} generations</span>
				</div>
			</div>
			<div class="text-foreground-muted text-sm">
				{new Date(project.created_at).toLocaleDateString()}
			</div>
		</div>
	</div>
</div>
