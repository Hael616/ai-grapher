<script lang="ts">
	import AppLayout from '$lib/components/layout/AppLayout.svelte';
	import type { SidebarItem } from '$lib/components/layout/types';

	let { children, data } = $props();

	let user = $state(data?.session?.user);

	const sidebarItems: SidebarItem[] = [
		{
			label: 'Dashboard',
			href: '/app',
			icon: 'mdi:view-dashboard'
		},
		{
			label: 'My Projects',
			href: '/app/projects',
			icon: 'mdi:folder'
		},
		{
			label: 'Settings',
			href: '/app/settings',
			icon: 'mdi:cog'
		}
	];
</script>

<AppLayout {sidebarItems} {user}>
	{@render children()}
</AppLayout>
