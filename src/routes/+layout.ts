import { createBrowserClient, createServerClient, isBrowser } from '@supabase/ssr';
import type { LayoutLoad } from './$types';
import { PUBLIC_SUPABASE_ANON_KEY, PUBLIC_SUPABASE_URL } from '$env/static/public';
import type { Database } from '$lib/types/database.types';
import { trace } from '../lib/utils/logger';
import { nexus } from '$lib/utils/nexus';
import { projectsStore } from '$stores';

export const load: LayoutLoad = async ({ fetch, data, depends }) => {
	depends('supabase:auth');
	const supabase = isBrowser()
		? createBrowserClient<Database>(PUBLIC_SUPABASE_URL, PUBLIC_SUPABASE_ANON_KEY, {
				global: { fetch }
			})
		: createServerClient<Database>(PUBLIC_SUPABASE_URL, PUBLIC_SUPABASE_ANON_KEY, {
				global: { fetch },
				cookies: {
					getAll() {
						return data.cookies;
					}
				}
			});

	const { data: plans, error: plansError } = await supabase
		.from('plans')
		.select('*')
		.order('price_monthly', { ascending: true });

	if (plansError) {
		trace(plansError);
	}

	const {
		data: { session }
	} = await supabase.auth.getSession();

	if (session) {
		nexus.init(session);
	}

	if (supabase) {
		projectsStore.load(supabase);
	}

	return { supabase, session, plans };
};
