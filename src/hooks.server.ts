import { type Handle, redirect } from "@sveltejs/kit";
import { createServerClient } from "@supabase/ssr";
import {
	PUBLIC_SUPABASE_ANON_KEY,
	PUBLIC_SUPABASE_URL,
} from "$env/static/public";
import { warn } from "./lib/utils/logger";
import { sequence } from "@sveltejs/kit/hooks";

const chromeDevTools: Handle = async ({ event, resolve }) => {
	if (
		event.url.pathname.startsWith(
			"/.well-known/appspecific/com.chrome.devtools",
		)
	) {
		return new Response(null, { status: 204 }); // Return empty response with 204 No Content
	}

	return await resolve(event);
};

const supabase: Handle = async ({ event, resolve }) => {
	event.locals.supabase = createServerClient(
		PUBLIC_SUPABASE_URL,
		PUBLIC_SUPABASE_ANON_KEY,
		{
			cookies: {
				getAll: () => event.cookies.getAll(),
				setAll: (cookiesToSet) => {
					cookiesToSet.forEach(({ name, value, options }) =>
						event.cookies.set(name, value, { ...options, path: "/" })
					);
				},
			},
		},
	);

	// This function calls `getUser()` to validate the * JWT before returning the session.
	event.locals.getSafeSession = async () => {
		const {
			data: { session },
		} = await event.locals.supabase.auth.getSession();

		if (!session) {
			return { session: null, user: null };
		}

		const { data: { user }, error } = await event.locals.supabase.auth
			.getUser();

		if (error) {
			warn("error while fetching user", error);
			return { session: null, user: null };
		}

		return { user, session };
	};

	return resolve(event, {
		filterSerializedResponseHeaders(name) {
			return name === "content-range" || name === "x-supabase-api-version";
		},
	});
};

const authGuard: Handle = async ({ event, resolve }) => {
	const { user, session } = await event.locals.getSafeSession();
	event.locals.user = user;
	event.locals.session = session;

	// Regex of protected routes
	const protectedRoutes = ["/app/*"];

	// Check if there is a code in the url
	const code = event.url.searchParams.get("code");

	if (code) {
		const { error } = await event.locals.supabase.auth.exchangeCodeForSession(
			code,
		);
		if (error) {
			warn("error while exchanging code for session", error);
		}
	}

	if (user && event.url.pathname.startsWith("/auth")) {
		redirect(303, "/app");
	} else if (
		!user && protectedRoutes.some((route) => event.url.pathname.match(route))
	) {
		redirect(303, "/auth/login");
	}

	return resolve(event);
};

export const handle: Handle = sequence(
	chromeDevTools,
	supabase,
	authGuard,
);
