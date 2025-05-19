import { AuthSchema } from '$lib/schemas';
import { fail, type Actions } from '@sveltejs/kit';

export const actions: Actions = {
	default: async ({ request, locals: { supabase } }) => {
		const formData = await request.formData();

		const dataToValidate = Object.fromEntries(formData.entries());

		const validatedData = AuthSchema.safeParse(dataToValidate);

		if (!validatedData.success) {
			return fail(400, {
				errors: validatedData.error.flatten().fieldErrors
			});
		}

		const { email } = validatedData.data;

		const { error } = await supabase.auth.resetPasswordForEmail(email as string, {
			redirectTo: 'http://localhost:5173/account/reset-password'
		});

		if (error) {
			return fail(400, {
				errors: { email: [error.message] }
			});
		}

		return {
			success: true,
			message: 'Reset link sent to your email.'
		};
	}
};
