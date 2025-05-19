import type { EmailOtpType } from "@supabase/supabase-js";
import { redirect, type RequestHandler } from "@sveltejs/kit";

export const GET: RequestHandler = async ({ url, locals: { supabase } }) => {
	const token_hash = url.searchParams.get("token_hash");
	const type = url.searchParams.get("type") as EmailOtpType | null;
	const next = (url.searchParams.get("next") as string) || "/app";

	const redirectTo = new URL(url);
	redirectTo.pathname = next;
	redirectTo.searchParams.delete("token_hash");
	redirectTo.searchParams.delete("type");

	if (token_hash && type) {
		const { error } = await supabase.auth.verifyOtp({ type, token_hash });

		if (!error) {
			redirectTo.searchParams.delete("next");
			redirect(303, redirectTo);
		}
		redirectTo.pathname = "/auth/error";
		redirectTo.searchParams.set(
			"message",
			error.message || "Invalid or expired magic link",
		);
		redirectTo.searchParams.set("code", error.code || "invalid_magic_link");
		return redirect(303, redirectTo);
	}

	console.log("No code found");
	redirectTo.pathname = "/auth/error";
	redirectTo.searchParams.set("message", "No authentication code provided");
	redirectTo.searchParams.set("code", "missing_code");
	return redirect(303, redirectTo);
};
