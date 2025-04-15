import { AuthSchema } from '$lib/schemas';
import { fail, type Actions } from '@sveltejs/kit';

export const actions: Actions = {
	default: async (event) => {
		const {
			request,
			locals: { supabase }
		} = event;

		const formData = await request.formData();

		const dataToValidate = Object.fromEntries(formData.entries());

		const validatedData = AuthSchema.safeParse(dataToValidate);

		if (!validatedData.success) {
			return fail(400, { errors: validatedData.error.flatten().fieldErrors });
		}
		const { flow, confirmPassword, ...sanitizedData } = validatedData.data as {
			flow: string;
			email: string;
			password: string;
			confirmPassword: string;
		};

		if (flow === 'password') {
			const { error } = await supabase.auth.signUp(sanitizedData);

			if (error) {
				console.log('error', error);

				if (error.code?.includes('email_exists')) {
					return fail(400, {
						success: false,
						message: 'An account with this email already exists. Try logging in.'
					});
				} else {
					return fail(500, { success: false, message: 'Oops something went wrong' });
				}
			}

			return {
				success: true,
				message: 'Please check your email for confirmation to log into the website.'
			};
		} else {
			const { error } = await supabase.auth.signInWithOtp({ email: sanitizedData.email });
			if (error) {
				if (error.code?.includes('email_exists')) {
					return fail(400, {
						success: false,
						message: 'An account with this email already exists. Try logging in.'
					});
				} else {
					return fail(400, {
						success: false,

						message: `There was an issue, Please contact support.`
					});
				}
			}
			return {
				success: true,
				message: 'Please check your email for a magic link to log into the website.'
			};
		}
	}
};
