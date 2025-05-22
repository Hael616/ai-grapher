<script lang="ts">
	import type { Snippet } from 'svelte';
	import { onMount } from 'svelte';

	interface Props {
		show: boolean;
		title: string;
		onClose: () => void;
		body: Snippet;
		actions: Snippet;
	}

	const { show = false, title = '', onClose, body, actions } = $props();

	function handleKeydown(e: KeyboardEvent) {
		if (e.key === 'Escape') {
			onClose();
		}
	}

	onMount(() => {
		document.addEventListener('keydown', handleKeydown);
		return () => {
			document.removeEventListener('keydown', handleKeydown);
		};
	});
</script>

{#if show}
	<div
		class="fixed inset-0 z-50 flex h-screen w-screen items-center justify-center"
		role="dialog"
		aria-modal="true"
		aria-labelledby="modal-title"
	>
		<!-- Backdrop -->
		<div
			class="absolute inset-0 bg-black/50"
			onclick={onClose}
			onkeydown={(e) => e.key === 'Enter' && onClose()}
			aria-label="Close dialog"
			role="button"
			tabindex="0"
		></div>

		<!-- Dialog -->
		<div class="relative mx-4 w-full max-w-md rounded-lg bg-white p-6 shadow-lg" role="document">
			<div class="mb-4">
				<h3 id="modal-title" class="text-lg font-semibold">{title}</h3>
				{@render body()}
			</div>

			<div class="flex justify-end gap-2">
				{@render actions()}
			</div>
		</div>
	</div>
{/if}
