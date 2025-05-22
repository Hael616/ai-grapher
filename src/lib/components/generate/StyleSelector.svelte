<script lang="ts">
	import { createEventDispatcher } from 'svelte';
	import { slide } from 'svelte/transition';
	import { onMount } from 'svelte';

	const { initialStyle = null } = $props<{
		initialStyle: string | null;
	}>();

	let selectedStyle = $state(initialStyle);

	const dispatch = createEventDispatcher<{
		select: string;
	}>();

	let isOpen = $state(false);

	const styles = [
		{
			id: 'studio',
			label: 'Studio',
			icon: 'mdi:image-filter-center-focus',
			description: 'Clean, professional studio setting'
		},
		{
			id: 'lifestyle',
			label: 'Lifestyle',
			icon: 'mdi:home',
			description: 'Natural, everyday environment'
		},
		{
			id: 'clean-beauty',
			label: 'Clean Beauty',
			icon: 'mdi:spa',
			description: 'Minimalist, spa-like atmosphere'
		},
		{
			id: 'outdoor',
			label: 'Outdoor',
			icon: 'mdi:weather-sunny',
			description: 'Natural outdoor setting'
		},
		{
			id: 'desk',
			label: 'Desk Setup',
			icon: 'mdi:desk',
			description: 'Modern workspace environment'
		}
	];

	const handleSelect = (style: string) => {
		selectedStyle = style;
		dispatch('select', style);
		isOpen = false;
	};

	const toggleDropdown = () => {
		isOpen = !isOpen;
	};

	// Close dropdown when clicking outside
	const handleClickOutside = (event: MouseEvent) => {
		const target = event.target as HTMLElement;
		if (!target.closest('.style-dropdown')) {
			isOpen = false;
		}
	};

	onMount(() => {
		document.addEventListener('click', handleClickOutside);
		return () => document.removeEventListener('click', handleClickOutside);
	});
</script>

<div class="style-dropdown relative">
	<button
		class="button button-outline-soft w-full justify-between"
		on:click={toggleDropdown}
		aria-expanded={isOpen}
		aria-haspopup="true"
	>
		<div class="flex items-center gap-2">
			{#if selectedStyle}
				<iconify-icon icon={styles.find((s) => s.id === selectedStyle)?.icon} width="20" height="20"
				></iconify-icon>
				<span class="text-foreground">{styles.find((s) => s.id === selectedStyle)?.label}</span>
			{:else}
				<span class="text-foreground-muted">Select style</span>
			{/if}
		</div>
		<iconify-icon
			icon="mdi:chevron-down"
			width="20"
			height="20"
			class="text-foreground-muted transition-transform duration-200"
			style="transform: rotate({isOpen ? '180deg' : '0deg'})"
		></iconify-icon>
	</button>

	{#if isOpen}
		<div
			class="bg-surface absolute top-full right-0 left-0 z-10 mt-1 max-h-60 overflow-y-auto rounded-lg border shadow-lg"
			transition:slide={{ duration: 200 }}
		>
			{#each styles as style}
				<button
					class="hover:bg-surface-hover flex w-full flex-col gap-1 px-4 py-2 text-left {selectedStyle ===
					style.id
						? 'bg-primary/5 text-primary'
						: 'text-foreground'}"
					on:click={() => handleSelect(style.id)}
				>
					<div class="flex items-center gap-2">
						<iconify-icon icon={style.icon} width="20" height="20"></iconify-icon>
						<span class="font-medium">{style.label}</span>
					</div>
					<p class="text-foreground-muted text-sm">{style.description}</p>
				</button>
			{/each}
		</div>
	{/if}
</div>
