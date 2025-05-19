<script lang="ts">
	import { layoutStore } from '$lib/components/layout/layout.svelte';

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

	const recentProjects = [
		{
			id: 1,
			image: 'https://placehold.co/400x300',
			title: 'Project 1',
			createdAt: '2024-03-20'
		},
		{
			id: 2,
			image: 'https://placehold.co/400x300',
			title: 'Project 2',
			createdAt: '2024-03-19'
		},
		{
			id: 3,
			image: 'https://placehold.co/400x300',
			title: 'Project 3',
			createdAt: '2024-03-18'
		},
		{
			id: 4,
			image: 'https://placehold.co/400x300',
			title: 'Project 4',
			createdAt: '2024-03-17'
		}
	];
</script>

<div class="space-y-8">
	<!-- Welcome Section -->
	<div class="space-y-2">
		<h1 class="text-2xl font-semibold">
			Welcome back, {session?.user?.user_metadata?.full_name.split(' ')[0]}
		</h1>
		<p class="text-gray-600">Let's turn your products into magic.</p>
	</div>

	<!-- Credits Section -->
	<div class="card flex items-center justify-between">
		<div class="space-y-1">
			<p class="text-sm font-medium text-gray-600">Credits Left</p>
			<p class="text-2xl font-semibold">
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
			<h2 class="text-lg font-semibold">Recent Projects</h2>
			<div class="flex items-center gap-4">
				<a href="/app/projects" class="text-primary text-sm hover:underline">View All Projects</a>
				<a
					href="/app/generate"
					class="button button-primary hidden md:inline-flex"
					aria-label="Generate new image"
				>
					<iconify-icon icon="mdi:plus" width="20" height="20"></iconify-icon>
					<span>Generate New Image</span>
				</a>
			</div>
		</div>

		<div class="grid gap-4 md:grid-cols-2 lg:grid-cols-3">
			{#each recentProjects as project}
				<div class="card p-0">
					<img src={project.image} alt={project.title} class="h-48 w-full object-cover" />
					<div class="card-content p-4">
						<div class="mb-4 flex w-full items-center justify-between">
							<div>
								<h3 class="font-medium">{project.title}</h3>
								<p class="text-sm text-gray-500">
									{new Date(project.createdAt).toLocaleDateString()}
								</p>
							</div>
							<div class="flex gap-2">
								<a
									href="/app/projects/{project.id}"
									class="button button-outline-soft"
									aria-label="View project"
								>
									<iconify-icon icon="mdi:eye" width="20" height="20"></iconify-icon>
									<span class="sr-only">View</span>
								</a>
								<button class="button button-outline-soft" aria-label="Regenerate project">
									<iconify-icon icon="mdi:refresh" width="20" height="20"></iconify-icon>
									<span class="sr-only">Regenerate</span>
								</button>
							</div>
						</div>
					</div>
				</div>
			{/each}
		</div>
	</div>

	<!-- Generate New Button (Mobile Only) -->
	<div class="fixed right-0 bottom-0 left-0 p-4 md:hidden">
		<a
			href="/app/generate"
			class="button button-primary w-full shadow-lg"
			aria-label="Generate new image"
		>
			<iconify-icon icon="mdi:plus" width="24" height="24"></iconify-icon>
			<span>Generate New Image</span>
		</a>
	</div>

	<!-- Add padding to prevent content from being hidden behind the floating button on mobile -->
	<div class="h-20 md:h-0"></div>
</div>
