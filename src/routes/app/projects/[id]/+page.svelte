<script lang="ts">
	import { page } from '$app/state';
	import type { Tables } from '$lib/types/database.types';
	import { projectsStore } from '$stores';
	import { goto } from '$app/navigation';

	let { data: project, error } = $derived(projectsStore.getProject(page.params.id.toString()));

	function getStatusInfo(status: string) {
		switch (status) {
			case 'ready':
				return { color: 'bg-green-600 text-white', label: 'Ready' };
			case 'training':
				return { color: 'bg-blue-600 text-white', label: 'Training' };
			case 'failed':
				return { color: 'bg-red-600 text-white', label: 'Failed' };
			case 'pending':
				return { color: 'bg-yellow-400 text-gray-900', label: 'Pending' };
			default:
				return { color: 'bg-gray-400 text-white', label: 'Unknown' };
		}
	}
</script>

<main class="mx-auto max-w-2xl p-4 md:p-8">
	<button
		class="text-primary mb-6 flex items-center gap-2 font-semibold hover:underline"
		onclick={() => goto('/app/projects')}
	>
		<svg
			xmlns="http://www.w3.org/2000/svg"
			fill="none"
			viewBox="0 0 24 24"
			stroke="currentColor"
			class="h-5 w-5"
		>
			<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7" />
		</svg>
		Back to Projects
	</button>

	{#if project}
		<div class="bg-surface border-border overflow-hidden rounded-2xl border shadow-xl">
			{#if project.cover_image_url}
				<img
					src={project.cover_image_url}
					alt={project.name}
					class="border-border h-72 w-full border-b object-cover object-center"
				/>
			{/if}
			<div class="flex flex-col gap-6 p-8">
				<div class="flex flex-col gap-4 md:items-center md:justify-between">
					<div class="flex w-full flex-col gap-2">
						<h1 class="text-foreground text-4xl leading-tight font-extrabold tracking-tight">
							{project.name}
						</h1>
						<section class="flex items-center justify-between">
							<span
								class={`inline-block max-w-fit rounded-full px-4 py-1 text-sm font-bold tracking-wider uppercase shadow ${getStatusInfo(project.model_status).color}`}
								>{getStatusInfo(project.model_status).label}</span
							>
							<a
								href={`/app/projects/${project.id}/generate`}
								class="button button-primary gap-1 text-base font-bold shadow-lg transition-transform hover:scale-105"
							>
								<span class="hidden md:block">Generate Images</span>
								<iconify-icon icon="mdi:lightning-bolt" width="20" height="20"></iconify-icon>
							</a>
						</section>
					</div>

					{#if project.description}
						<p class="text-foreground-muted mb-5 w-full text-lg font-medium">
							{project.description}
						</p>
					{/if}
				</div>

				<section class="mt-4 grid grid-cols-1 gap-6 sm:grid-cols-2">
					<div class="bg-background border-border flex flex-col gap-2 rounded-xl border p-5 shadow">
						<span class="text-foreground-muted text-xs font-semibold uppercase">Project ID</span>
						<span class="text-foreground text-lg font-bold break-all">{project.id}</span>
					</div>
					<div class="bg-background border-border flex flex-col gap-2 rounded-xl border p-5 shadow">
						<span class="text-foreground-muted text-xs font-semibold uppercase">Created</span>
						<span class="text-foreground text-lg font-bold"
							>{new Date(project.created_at).toLocaleString()}</span
						>
					</div>
					<div
						class="bg-background border-border flex flex-col gap-2 rounded-xl border p-5 shadow sm:col-span-2"
					>
						<span class="text-foreground-muted text-xs font-semibold uppercase">Status</span>
						<span class="text-foreground text-lg font-bold">{project.model_status}</span>
					</div>
				</section>
			</div>
		</div>
	{:else}
		<p class="text-error text-lg font-bold">Project not found.</p>
	{/if}
</main>
