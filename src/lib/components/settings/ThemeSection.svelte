<script lang="ts">
	import ThemeToggle from '$lib/components/ThemeToggle.svelte';
	import { theme } from '$stores/theme.svelte';
	import { onMount } from 'svelte';

	let themeText = $derived(theme.theme === 'dark' ? 'Dark' : 'Light');
</script>

<div class="card space-y-6 p-4 sm:p-6">
	<div class="flex flex-col gap-4 sm:flex-row sm:items-center sm:justify-between">
		<div class="space-y-1">
			<h2 class="text-foreground text-lg font-semibold">Theme Settings</h2>
			<p class="text-foreground-muted text-sm">Customize your application appearance</p>
		</div>
		<ThemeToggle />
	</div>

	<div class="space-y-4">
		<div class="space-y-2">
			<p class="text-foreground-muted text-sm font-medium">Current Theme</p>
			<div class="flex items-center gap-2">
				<div class="bg-surface-hover inline-flex items-center gap-2 rounded-full px-3 py-1 text-sm">
					<iconify-icon icon="mdi:theme-light-dark" width="16" height="16"></iconify-icon>
					<span>{themeText}</span>
				</div>
			</div>
		</div>
		<p class="text-foreground-muted text-sm">
			The theme will automatically sync across all your devices. You can also set your system
			preference to automatically switch between light and dark mode.
		</p>
	</div>
</div>
