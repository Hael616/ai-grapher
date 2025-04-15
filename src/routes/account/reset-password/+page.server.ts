import { AuthSchema } from '$lib/schemas';
import type { Actions } from '@sveltejs/kit';
import { fail, redirect } from '@sveltejs/kit';

export const actions: Actions = {
	default: async ({ request, locals: { supabase } }) => {
		const formData = await request.formData();

		const dataToValidate = Object.fromEntries(formData.entries());

		const validatedData = AuthSchema.safeParse(dataToValidate);

		if (!validatedData.success) {
			console.log(validatedData.error);

			return fail(400, {
				errors: validatedData.error.flatten().fieldErrors
			});
		}

		const { password } = validatedData.data;

		const { error } = await supabase.auth.updateUser({ password });

		if (error) {
			console.log('error resetting password', error);

			return fail(400, {
				errors: { password: [error.message] }
			});
		}

		redirect(303, 'login');
	}
};
