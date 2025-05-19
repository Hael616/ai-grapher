import { AuthSchema } from "$lib/schemas";
import type { SignInWithPasswordCredentials } from "@supabase/supabase-js";
import { type Actions, fail } from "@sveltejs/kit";

export const actions: Actions = {
	default: async ({ request, locals: { supabase }, url }) => {
		const formData = await request.formData();

		const dataToValidate = Object.fromEntries(formData.entries());
		const validatedData = AuthSchema.safeParse(dataToValidate);

		if (!validatedData.success) {
			return fail(400, {
				message: "Fix the errors below",
				errors: validatedData.error.flatten().fieldErrors,
			});
		}

		// eslint-disable-next-line @typescript-eslint/no-unused-vars
		const { flow, confirmPassword, ...sanitizedData } = validatedData.data;

		if (flow === "password") {
			const { error } = await supabase.auth.signInWithPassword(
				sanitizedData as SignInWithPasswordCredentials,
			);

			if (error) {
				console.log("Sign-in error:", error);

				return fail(401, {
					success: false,
					message: error.message === "Invalid login credentials"
						? "Invalid email or password"
						: "Oops, something went wrong. Please try again.",
				});
			}

			return {
				success: true,
				message: "Welcome back! Redirecting to your dashboard...",
			};
		} else {
			// Magic link
			const redirectTo = new URL(url);
			redirectTo.pathname = "/auth/confirm";
			const { error } = await supabase.auth.signInWithOtp({
				email: sanitizedData.email as string,
				options: {
					emailRedirectTo: redirectTo.toString(),
				},
			});

			if (error) {
				console.log("Magic link error:", error);

				return fail(400, {
					success: false,
					message:
						"Something went wrong sending the magic link. Please try again.",
				});
			}

			return {
				success: true,
				message: "Check your email for the magic link to log in.",
			};
		}
	},
};
