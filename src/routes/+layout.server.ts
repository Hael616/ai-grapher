import type { LayoutServerLoad } from './$types';

export const load: LayoutServerLoad = async ({ locals: { getSafeSession }, cookies }) => {
	const { user, session } = await getSafeSession(); // handles server side session

	return {
		user,
		session,
		cookies: cookies.getAll()
	};
};
