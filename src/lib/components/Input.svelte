<script lang="ts">
	import { page } from '$app/state';

	import { slide } from 'svelte/transition';
	import { twMerge } from 'tailwind-merge';

	let {
		name,
		type = 'text',

		label,
		value = $bindable(''),
		options = [],

		inputClass = '',
		labelClass = '',
		containerClass = '',
		errorClass = '',
		...restProps
	} = $props();

	let showPassword = $state(false);
	const uid = $props.id();

	function togglePasswordVisibility() {
		showPassword = !showPassword;
	}

	let errors = $derived(page.form?.errors?.[name] || []);

	const baseStyle =
		'w-full rounded-md border bg-white px-3 py-2 text-sm transition focus:ring-2 focus:ring-blue-500 focus:outline-none';
	const errorStyle = 'border-red-500 focus:ring-red-300';
</script>

<div class={twMerge('mt-5 grid w-full gap-1.5', containerClass)} transition:slide>
	<label for="{name}-{uid}" class={twMerge('text-sm font-medium text-gray-800', labelClass)}>
		{label}{restProps.required ? ' *' : ''}
	</label>

	{#if type === 'password'}
		<div class="relative w-full">
			<input
				{name}
				id="{name}-{uid}"
				type={showPassword ? 'text' : 'password'}
				bind:value
				{...restProps}
				class={twMerge(baseStyle, errors.length > 0 ? errorStyle : 'border-gray-300', inputClass)}
				aria-invalid={errors.length > 0}
				aria-describedby={errors.length > 0 ? `${name}-error` : undefined}
			/>
			<button
				type="button"
				tabindex="-1"
				onclick={togglePasswordVisibility}
				class="absolute top-1/2 right-3 -translate-y-1/2 cursor-pointer text-gray-500 hover:text-gray-700"
				aria-label={showPassword ? 'Hide password' : 'Show password'}
			>
				{#if showPassword}
					<iconify-icon icon="weui:eyes-off-outlined" width="20" height="20"></iconify-icon>
				{:else}
					<iconify-icon icon="weui:eyes-on-outlined" width="20" height="20"></iconify-icon>
				{/if}
			</button>
		</div>
		{#if name === 'password' && page.route.id?.includes('/login')}
			<a href="forgot-password" class="text-right text-sm text-gray-400 underline"
				>forgot password?</a
			>
		{/if}
	{:else if type === 'textarea'}
		<textarea
			{name}
			id="{name}-{uid}"
			bind:value
			rows="5"
			{...restProps}
			class={twMerge(baseStyle, errors.length > 0 ? errorStyle : 'border-gray-300', inputClass)}
			aria-invalid={errors.length > 0}
			aria-describedby={errors.length > 0 ? `${name}-error` : undefined}
		></textarea>
	{:else if type === 'select'}
		<select
			{name}
			id="{name}-{uid}"
			bind:value
			class={twMerge(baseStyle, errors.length > 0 ? errorStyle : 'border-gray-300', inputClass)}
			aria-invalid={errors.length > 0}
			aria-describedby={errors.length > 0 ? `${name}-error` : undefined}
		>
			<option value="" disabled selected>Please select</option>
			{#each options as option}
				<option value={option}>{option.charAt(0).toUpperCase() + option.slice(1)}</option>
			{/each}
		</select>
	{:else}
		<input
			{name}
			id="{name}-{uid}"
			bind:value
			{...restProps}
			class={twMerge(baseStyle, errors.length > 0 ? errorStyle : 'border-gray-300', inputClass)}
			aria-invalid={errors.length > 0}
			aria-describedby={errors.length > 0 ? `${name}-error` : undefined}
		/>
	{/if}

	{#if errors.length > 0}
		<div
			class={twMerge('mt-1 grid gap-1 text-sm text-red-600', errorClass)}
			id="{name}-error"
			role="alert"
			transition:slide
		>
			{#each errors as error}
				<span>{error}</span>
			{/each}
		</div>
	{/if}
</div>
