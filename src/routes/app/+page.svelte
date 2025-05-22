<script lang="ts">
	import { layoutStore } from '$lib/components/layout/layout.svelte';
	import ProjectCard from '$lib/components/projects/ProjectCard.svelte';

	const { data } = $props();

	const session = $derived(data.session);

	// Set page title
	layoutStore.pageTitle = 'Dashboard';

	// Mock data - replace with actual data from your backend
	const user = {
		name: 'Oluwaseyifunmi',
		credits: {
			used: 2,
			total: 10,
			balance: 8
		}
	};

	// Mock data - replace with actual data from your backend
	const recentProjects = [
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
			name: 'New Watch Collection',
			description: 'Luxury timepiece photography',
			cover_image_url:
				'https://images.unsplash.com/photo-1524805444758-089113d48a6d?q=80&w=1000&auto=format&fit=crop',
			model_status: 'pending',
			created_at: '2024-03-17',
			generation_count: 0
		}
	];
</script>

<div class="space-y-8">
	<!-- Welcome Section -->
	<div class="space-y-2">
		<h1 class="text-foreground text-2xl font-semibold">
			Welcome back, {session?.user?.user_metadata?.full_name.split(' ')[0]}
		</h1>
		<p class="text-foreground-muted">Let's turn your products into magic.</p>
	</div>

	<!-- Credits Section -->
	<div class="card flex items-center justify-between">
		<div class="space-y-1">
			<p class="text-foreground-muted text-sm font-medium">Credits Left</p>
			<p class="text-foreground text-2xl font-semibold">
				{user.credits.total - user.credits.used}/{user.credits.total}
			</p>
		</div>
		<a href="/app/upgrade" class="button button-outline-soft">
			<iconify-icon icon="mdi:star" width="20" height="20"></iconify-icon>
			Upgrade Plan
		</a>
	</div>

	<!-- Recent Projects Section -->
	<div class="space-y-4">
		<div class="flex items-center justify-between">
			<h2 class="text-foreground text-lg font-semibold">Recent Projects</h2>
			<div class="flex items-center gap-4">
				<a href="/app/projects" class="text-primary text-sm hover:underline">View All Projects</a>
				<a
					href="/app/projects/new"
					class="button button-primary hidden md:inline-flex"
					aria-label="Create new project"
				>
					<iconify-icon icon="mdi:plus" width="20" height="20"></iconify-icon>
					<span>New Project</span>
				</a>
			</div>
		</div>

		<div class="grid gap-6 sm:grid-cols-2 lg:grid-cols-3">
			{#each recentProjects as project}
				<ProjectCard {project} />
			{/each}
		</div>
	</div>

	<!-- Generate New Button (Mobile Only) -->
	<div class="fixed right-0 bottom-0 left-0 p-4 md:hidden">
		<a
			href="/app/projects"
			class="button button-primary w-full shadow-lg"
			aria-label="Create new project"
		>
			<iconify-icon icon="mdi:plus" width="24" height="24"></iconify-icon>
			<span>New Project</span>
		</a>
	</div>

	<!-- Add padding to prevent content from being hidden behind the floating button on mobile -->
	<div class="h-20 md:h-0"></div>
</div>
