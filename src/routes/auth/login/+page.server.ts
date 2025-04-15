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

		const { flow, confirmPassword, ...sanitizedData } = validatedData.data;

		if (flow === 'password') {
			const { error } = await supabase.auth.signInWithPassword(sanitizedData);

			if (error) {
				console.log('Sign-in error:', error);

				return fail(401, {
					success: false,
					message:
						error.message === 'Invalid login credentials'
							? 'Invalid email or password'
							: 'Oops, something went wrong. Please try again.'
				});
			}

			return {
				success: true,
				message: 'Welcome back! Redirecting to your dashboard...'
			};
		} else {
			// Magic link
			const { error } = await supabase.auth.signInWithOtp({ email: sanitizedData.email });

			if (error) {
				console.log('Magic link error:', error);

				return fail(400, {
					success: false,
					message: 'Something went wrong sending the magic link. Please try again.'
				});
			}

			return {
				success: true,
				message: 'Check your email for the magic link to log in.'
			};
		}
	}
};
