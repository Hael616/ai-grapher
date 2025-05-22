<script lang="ts">
	import { page } from '$app/state';
	import { twMerge } from 'tailwind-merge';
	import { onMount } from 'svelte';
	import { slide } from 'svelte/transition';
	import ThemeToggle from '$lib/components/ThemeToggle.svelte';

	import { layoutStore } from './layout.svelte';
	import { trace, warn } from '$lib/utils/logger';
	import { goto } from '$app/navigation';

	const { supabase } = page.data;

	let {
		showSidebar = true,
		sidebarItems = [],
		theme = {},
		loading = false,
		user,
		children
	} = $props();

	let isSidebarOpen = $state(true);
	let isMobile = $state(false);
	let isUserMenuOpen = $state(false);

	const { container = '', sidebar = '', main = '', header = '', content = '' } = theme;

	const checkMobile = () => {
		isMobile = window.innerWidth < 768;
		if (isMobile) {
			isSidebarOpen = false;
		}
	};

	onMount(() => {
		checkMobile();
		window.addEventListener('resize', checkMobile);
		return () => window.removeEventListener('resize', checkMobile);
	});

	const toggleSidebar = () => {
		isSidebarOpen = !isSidebarOpen;
	};

	const toggleUserMenu = () => {
		isUserMenuOpen = !isUserMenuOpen;
	};

	const handleClickOutside = (event: MouseEvent) => {
		const target = event.target as HTMLElement;
		if (!target.closest('.user-menu')) {
			isUserMenuOpen = false;
		}
	};

	onMount(() => {
		document.addEventListener('click', handleClickOutside);
		return () => document.removeEventListener('click', handleClickOutside);
	});

	let signOutLoading = $state(false);

	const handleSignOut = async () => {
		signOutLoading = true;
		const { error } = await supabase.auth.signOut();

		if (error) {
			trace('Error signing out', error);
		} else {
			await goto('/auth/login');
		}
		signOutLoading = false;
	};
</script>

<div class="bg-background flex h-screen">
	<!-- Sidebar -->
	{#if showSidebar}
		<aside
			class={twMerge(
				'bg-surface fixed inset-y-0 left-0 z-50 flex w-64 flex-col shadow-lg transition-transform duration-300 ease-in-out md:relative md:translate-x-0',
				isSidebarOpen ? 'translate-x-0' : '-translate-x-full',
				sidebar
			)}
		>
			<!-- Sidebar Header -->
			<div class="border-border flex h-16 items-center justify-between border-b px-4">
				<a href="/app" class="flex items-center gap-2">
					<!-- TODO: Add logo -->
					<iconify-icon icon="mdi:chart-box" width="24" height="24" class="text-primary flex"
					></iconify-icon>
					<span class="text-foreground text-lg font-semibold">AI Grapher</span>
				</a>
				<button
					class="hover:bg-surface-hover rounded p-2 md:hidden"
					onclick={toggleSidebar}
					aria-label="Close sidebar"
				>
					<iconify-icon class="flex" icon="mdi:close" width="20" height="20"></iconify-icon>
				</button>
			</div>

			<!-- Sidebar Navigation -->
			<nav class="flex-1 space-y-1 overflow-y-auto p-4">
				{#each sidebarItems as item}
					<a
						href={item.href}
						class={twMerge(
							'flex items-center gap-3 rounded-lg px-3 py-2 text-sm font-medium transition-colors',
							(
								item.href === '/app'
									? page.url.pathname === '/app'
									: page.url.pathname.startsWith(item.href) && page.url.pathname !== '/app'
							)
								? 'bg-primary/10 text-primary'
								: 'text-foreground-muted hover:bg-surface-hover'
						)}
					>
						<iconify-icon icon={item.icon} width="20" height="20"></iconify-icon>
						<span>{item.label}</span>
					</a>
				{/each}
			</nav>

			<!-- Sidebar Footer -->
			<div class="border-border border-t p-4">
				<div class="user-menu relative">
					<button
						class="hover:bg-surface-hover flex w-full items-center gap-3 rounded-lg px-2 py-1.5"
						onclick={toggleUserMenu}
						aria-expanded={isUserMenuOpen}
						aria-haspopup="true"
					>
						<div class="bg-surface-hover h-8 w-8 rounded-full">
							{#if user}
								<img
									src={user?.user_metadata?.avatar_url}
									alt={user?.user_metadata?.full_name}
									class="h-full w-full rounded-full object-cover"
								/>
							{/if}
						</div>
						<div class="flex-1 text-left">
							{#if user}
								<p class="text-foreground text-sm font-medium">{user?.user_metadata?.full_name}</p>
								<p class="text-foreground-muted text-xs">{user?.email}</p>
							{/if}
						</div>
						<iconify-icon
							icon="mdi:chevron-down"
							width="20"
							height="20"
							class="text-foreground-muted transition-transform duration-200"
							style="transform: rotate({isUserMenuOpen ? '180deg' : '0deg'})"
						></iconify-icon>
					</button>

					{#if isUserMenuOpen}
						<div
							class="bg-surface absolute bottom-full left-0 mb-2 w-full overflow-hidden rounded-lg border shadow-lg"
							transition:slide={{ duration: 200 }}
						>
							<a href="/app/account" class="button button-outline-soft justify-start border-0 p-3">
								<iconify-icon icon="mdi:account" width="20" height="20"></iconify-icon>
								Account
							</a>
							<a href="/app/settings" class="button button-outline-soft justify-start border-0 p-3">
								<iconify-icon icon="mdi:cog" width="20" height="20"></iconify-icon>
								Settings
							</a>
							<div class="border-border border-t"></div>

							<button
								class="button button-outline-soft text-error h-full w-full justify-start p-4"
								onclick={handleSignOut}
								disabled={signOutLoading}
							>
								<iconify-icon icon="mdi:logout" width="20" height="20"></iconify-icon>
								Sign out
							</button>
						</div>
					{/if}
				</div>
			</div>
		</aside>
	{/if}

	<!-- Main Content -->
	<div class="flex flex-1 flex-col">
		<!-- Top Header -->
		<header
			class={twMerge(
				'border-border bg-surface flex h-16 items-center justify-between border-b px-4 shadow-sm',
				header
			)}
		>
			<div class="flex items-center gap-4">
				{#if showSidebar}
					<button
						class="hover:bg-surface-hover rounded p-2 md:hidden"
						onclick={toggleSidebar}
						aria-label="Open sidebar"
					>
						<iconify-icon icon="mdi:menu" class="flex" width="20" height="20"></iconify-icon>
					</button>
				{/if}
				<h1 class="text-foreground text-lg font-semibold">{layoutStore.pageTitle}</h1>
			</div>

			<div class="flex items-center gap-4">
				<ThemeToggle />
				<!-- <button class="rounded p-2 hover:bg-surface-hover" aria-label="Notifications">
					<iconify-icon icon="mdi:bell-outline" width="20" height="20"></iconify-icon>
				</button>
				<button class="rounded p-2 hover:bg-surface-hover" aria-label="Settings">
					<iconify-icon icon="mdi:cog-outline" width="20" height="20"></iconify-icon>
				</button> -->
			</div>
		</header>

		<!-- Main Content Area -->
		<main class={twMerge('bg-background flex-1 overflow-y-auto p-4', main)}>
			<div class={twMerge('mx-auto max-w-7xl', content)}>
				{#if loading}
					<div class="flex h-full items-center justify-center">
						<div class="text-center">
							<iconify-icon
								icon="svg-spinners:blocks-shuffle-2"
								width="48"
								height="48"
								class="text-primary"
							></iconify-icon>
							<p class="text-foreground-muted mt-4">Loading...</p>
						</div>
					</div>
				{:else}
					{@render children()}
				{/if}
			</div>
		</main>
	</div>
</div>

<!-- Mobile Sidebar Backdrop -->
{#if isSidebarOpen && isMobile}
	<div
		class="fixed inset-0 z-40 bg-black/50 transition-opacity"
		onclick={toggleSidebar}
		onkeydown={(e) => e.key === 'Enter' && toggleSidebar()}
		role="button"
		tabindex="0"
	></div>
{/if}
