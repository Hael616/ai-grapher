// See https://svelte.dev/docs/kit/types#app.d.ts

import type { Session, SupabaseClient, User } from "@supabase/supabase-js";

// for information about these interfaces
declare global {
	namespace App {
		// interface Error {}
		interface Locals {
			supabase: SupabaseClient;
			getSafeSession(): Promise<{ session: Session | null; user: User | null }>;
			user: User | null;
			session: Session | null;
		}
		interface PageData {
			session: Session | null;
			supabase: SupabaseClient;
			user?: User | null;
		}
		// interface PageState {}
		// interface Platform {}
	}
}

export {};
