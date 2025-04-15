import { createBrowserClient, createServerClient, isBrowser } from '@supabase/ssr';
import type { LayoutLoad } from './$types';
import { PUBLIC_SUPABASE_ANON_KEY, PUBLIC_SUPABASE_URL } from '$env/static/public';
import { redirect } from '@sveltejs/kit';

export const load: LayoutLoad = async ({ fetch, data, depends, route }) => {
	depends('supabase:auth');
	if (data.session && route.id?.includes('auth')) {
		redirect(303, '/');
	}
	if (!data.session && !route.id?.includes('auth')) {
		redirect(303, '/auth/login');
	}
	const supabase = isBrowser()
		? createBrowserClient(PUBLIC_SUPABASE_URL, PUBLIC_SUPABASE_ANON_KEY, { global: { fetch } })
		: createServerClient(PUBLIC_SUPABASE_URL, PUBLIC_SUPABASE_ANON_KEY, {
				global: { fetch },
				cookies: {
					getAll() {
						return data.cookies;
					}
				}
			});

	const {
		data: { session }
	} = await supabase.auth.getSession();

	return { supabase, session };
};
