<script lang="ts">
	let { children } = $props();
</script>

<div class="auth-layout">
	<main>
		{@render children()}
	</main>
</div>

<style>
	.auth-layout {
		display: flex;
		min-height: 100vh;
		align-items: center;
		justify-content: center;
		padding: 1rem;
		background-color: #f8fafc;
	}

	main {
		width: 100%;
	}
</style>
