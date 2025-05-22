<script lang="ts">
	import { createEventDispatcher } from 'svelte';
	import { slide } from 'svelte/transition';
	import { onMount } from 'svelte';

	const { initialType = null } = $props<{
		initialType: string | null;
	}>();

	let selectedType = $state(initialType);

	const dispatch = createEventDispatcher<{
		select: string;
	}>();

	let isOpen = $state(false);

	const productTypes = [
		{ id: 'skincare', label: 'Skincare', icon: 'mdi:face-woman' },
		{ id: 'apparel', label: 'Apparel', icon: 'mdi:tshirt-crew' },
		{ id: 'shoes', label: 'Shoes', icon: 'mdi:shoe-heel' },
		{ id: 'tech', label: 'Tech Gadget', icon: 'mdi:cellphone' },
		{ id: 'food', label: 'Food', icon: 'mdi:food' }
	];

	const handleSelect = (type: string) => {
		selectedType = type;
		dispatch('select', type);
		isOpen = false;
	};

	const toggleDropdown = () => {
		isOpen = !isOpen;
	};

	// Close dropdown when clicking outside
	const handleClickOutside = (event: MouseEvent) => {
		const target = event.target as HTMLElement;
		if (!target.closest('.product-type-dropdown')) {
			isOpen = false;
		}
	};

	onMount(() => {
		document.addEventListener('click', handleClickOutside);
		return () => document.removeEventListener('click', handleClickOutside);
	});
</script>

<div class="product-type-dropdown relative">
	<button
		class="button button-outline-soft w-full justify-between"
		on:click={toggleDropdown}
		aria-expanded={isOpen}
		aria-haspopup="true"
	>
		<div class="flex items-center gap-2">
			{#if selectedType}
				<iconify-icon
					icon={productTypes.find((t) => t.id === selectedType)?.icon}
					width="20"
					height="20"
				></iconify-icon>
				<span>{productTypes.find((t) => t.id === selectedType)?.label}</span>
			{:else}
				<span>Select product type</span>
			{/if}
		</div>
		<iconify-icon
			icon="mdi:chevron-down"
			width="20"
			height="20"
			class="transition-transform duration-200"
			style="transform: rotate({isOpen ? '180deg' : '0deg'})"
		></iconify-icon>
	</button>

	{#if isOpen}
		<div
			class="absolute top-full right-0 left-0 z-10 mt-1 max-h-60 overflow-y-auto rounded-lg border bg-white shadow-lg"
			transition:slide={{ duration: 200 }}
		>
			{#each productTypes as type}
				<button
					class="flex w-full items-center gap-2 px-4 py-2 text-left hover:bg-gray-50 {selectedType ===
					type.id
						? 'bg-primary/5 text-primary'
						: 'text-gray-700'}"
					on:click={() => handleSelect(type.id)}
				>
					<iconify-icon icon={type.icon} width="20" height="20"></iconify-icon>
					<span>{type.label}</span>
				</button>
			{/each}
		</div>
	{/if}
</div>
