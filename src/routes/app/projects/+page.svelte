<script lang="ts">
	import { onMount } from 'svelte';
	import { layoutStore } from '$lib/components/layout/layout.svelte';

	import ProjectCard from '$lib/components/projects/ProjectCard.svelte';

	import type { Tables } from '$lib/types/database.types';
	import { projectsStore } from '$stores';

	onMount(() => {
		layoutStore.pageTitle = 'My Projects';
	});

	const projects = $derived<Tables<'projects'>[]>(Object.values(projectsStore.projects));
</script>

<div class="space-y-8">
	<!-- Header Section -->
	<div class="flex flex-col gap-4 sm:flex-row sm:items-center sm:justify-between">
		<div class="space-y-1">
			<h1 class="text-foreground text-2xl font-semibold">My Projects</h1>
			<p class="text-foreground-muted">Manage and organize your product images</p>
		</div>
		<a href="/app/projects/new" class="button button-primary">
			<iconify-icon icon="mdi:plus" width="20" height="20"></iconify-icon>
			New Project
		</a>
	</div>

	<!-- Projects Grid -->
	<div class="grid gap-6 sm:grid-cols-2 xl:grid-cols-3">
		{#each projects as project}
			<ProjectCard {project} />
		{/each}
	</div>

	<!-- Empty State -->
	{#if projects.length === 0}
		<div class="card text-center">
			<div class="mb-4">
				<iconify-icon icon="mdi:folder-open" width="48" height="48" class="text-foreground-muted"
				></iconify-icon>
			</div>
			<h3 class="text-foreground mb-2 text-lg font-medium">No projects yet</h3>
			<p class="text-foreground-muted mb-4">Create your first project to start generating images</p>
			<a href="/app/projects/new" class="button button-primary">
				<iconify-icon icon="mdi:plus" width="20" height="20"></iconify-icon>
				Create Project
			</a>
		</div>
	{/if}
</div>
