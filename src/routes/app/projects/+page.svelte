<script lang="ts">
	import { onMount } from 'svelte';
	import { layoutStore } from '$lib/components/layout/layout.svelte';
	import { browser } from '$app/environment';
	import projectStore from '$stores/projects.svelte';
	import { page } from '$app/state';
	import { showToast } from '$lib/utils/toast';
	import ProjectCard from '$lib/components/projects/ProjectCard.svelte';

	onMount(() => {
		layoutStore.pageTitle = 'My Projects';

		if (browser) {
			projectStore.load(page.data.supabase);
		}
	});

	// Mock data - replace with actual data from your backend
	const projects = [
		{
			id: '1',
			user_id: '1',
			name: 'Summer Collection',
			description: 'Product images for summer clothing line',
			cover_image_url:
				'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcThG9OUmDa76UVBfc5el7c-ALmH4cBG-U6g5A&s',
			model_status: 'ready',
			created_at: '2024-03-20',
			generation_count: 12
		},
		{
			id: '2',
			user_id: '1',
			name: 'Skincare Products',
			description: 'Luxury skincare product photography',
			cover_image_url:
				'https://media-cldnry.s-nbcnews.com/image/upload/t_fit-1500w,f_auto,q_auto:best/rockcms/2024-06/240610-beauty-awards-2024-skincare-winners-vl-social-91be20.jpg',
			model_status: 'training',
			created_at: '2024-03-19',
			generation_count: 8
		},
		{
			id: '3',
			user_id: '1',
			name: 'Electronics',
			description: 'Tech product showcase',
			cover_image_url:
				'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTZW2iQNBFnQvAJZ7bTlKRPsRpOOIVmiVoDXg&s',
			model_status: 'failed',
			created_at: '2024-03-18',
			generation_count: 15
		},
		{
			id: '4',
			user_id: '1',
			name: 'Home Decor',
			description: 'Interior decoration items',
			cover_image_url:
				'https://i0.wp.com/blog.marmalead.com/wp-content/uploads/2021/06/home-decor-and-planters.jpg?fit=1200%2C800&ssl=1',
			model_status: 'ready',
			created_at: '2024-03-17',
			generation_count: 10
		},
		{
			id: '5',
			user_id: '1',
			name: 'Jewelry Collection',
			description: 'Fine jewelry photography',
			cover_image_url:
				'https://i0.wp.com/blog.marmalead.com/wp-content/uploads/2021/06/home-decor-and-planters.jpg?fit=1200%2C800&ssl=1',
			model_status: 'pending',
			created_at: '2024-03-16',
			generation_count: 0
		},
		{
			id: '6',
			user_id: '1',
			name: 'Footwear',
			description: 'Shoe collection showcase',
			cover_image_url:
				'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTkZTnpU1IoWJFrFx-U2JxuXeJh0uZAVm-n1g&s',
			model_status: 'ready',
			created_at: '2024-03-15',
			generation_count: 16
		},
		{
			id: '7',
			user_id: '1',
			name: 'New Watch Collection',
			description: 'Luxury timepiece photography',
			cover_image_url:
				'https://images.unsplash.com/photo-1524805444758-089113d48a6d?q=80&w=1000&auto=format&fit=crop',
			model_status: 'pending',
			created_at: '2024-03-14',
			generation_count: 0
		},
		{
			id: '8',
			user_id: '1',
			name: 'Perfume Line',
			description: 'Fragrance bottle photography',
			cover_image_url:
				'https://images.unsplash.com/photo-1592945403244-b3fbafd7f539?q=80&w=1000&auto=format&fit=crop',
			model_status: 'pending',
			created_at: '2024-03-13',
			generation_count: 0
		}
	];

	// Helper function to get status color and icon
	function getStatusInfo(status: string) {
		switch (status) {
			case 'ready':
				return {
					color: 'text-green-600',
					bgColor: 'bg-green-50',
					icon: 'mdi:check-circle',
					label: 'Ready'
				};
			case 'training':
				return {
					color: 'text-blue-600',
					bgColor: 'bg-blue-50',
					icon: 'mdi:progress-clock',
					label: 'Training'
				};
			case 'failed':
				return {
					color: 'text-red-600',
					bgColor: 'bg-red-50',
					icon: 'mdi:alert-circle',
					label: 'Failed'
				};
			case 'pending':
				return {
					color: 'text-yellow-600',
					bgColor: 'bg-yellow-50',
					icon: 'mdi:clock-outline',
					label: 'Pending'
				};
			default:
				return {
					color: 'text-gray-600',
					bgColor: 'bg-gray-50',
					icon: 'mdi:help-circle',
					label: 'Unknown'
				};
		}
	}
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
