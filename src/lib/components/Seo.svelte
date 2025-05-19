<script lang="ts">
	import { page } from '$app/state';

	let { title, description, image = '/og-image.png' } = $props();

	let imageUrl = $derived(
		image.startsWith('/') ? page.url.protocol + '//' + page.url.host + image : image
	);
</script>

<svelte:head>
	<title>{title}</title>
	<meta name="description" content={description} />
	<meta property="og:image" content={imageUrl} />
	<!-- TODO: Add other meta tags -->
</svelte:head>
