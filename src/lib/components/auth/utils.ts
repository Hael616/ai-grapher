import type { Snippet } from "svelte";

export type AuthFlow =
	| "password"
	| "forgot-password"
	| "reset-password"
	| "magic-link"
	| "google"
	| "github"
	| "apple";

export interface AuthContextProps {
	title: string;
	children: Snippet;
	extras?: Snippet;
	flow?: AuthFlow;
	redirectTo?: string;
	socialProviders?: string[];
	showSocials?: boolean;
	showExtras?: boolean;
	loading: boolean;
	description?: string;
	showDescription?: boolean;
	// Theme object approach for custom Tailwind classes
	theme?: {
		container?: string;
		form?: string;
		header?: string;
		heading?: string;
		descriptionClass?: string;
		fields?: string;
		submitButton?: string;
		link?: string;
		socialButton?: string;
		error?: string;
		success?: string;
		divider?: string;
		alternate?: string;
	};
}
