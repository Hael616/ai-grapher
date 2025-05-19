import { z } from "zod";

export const AuthSchema = z
	.object({
		flow: z.enum([
			"password",
			"magic-link",
			"forgot-password",
			"reset-password",
		]),
		email: z.string().optional(),
		password: z.string().optional(),
		confirmPassword: z.string().optional(),
	})
	.superRefine(({ flow, password, confirmPassword, email }, ctx) => {
		if (flow !== "reset-password") {
			if (!email) {
				ctx.addIssue({
					path: ["email"],
					code: z.ZodIssueCode.custom,
					message: "Email is required",
				});
			} else {
				const emailValidation = z.string().email({
					message: "Please enter a valid email address",
				});
				const result = emailValidation.safeParse(email);
				if (!result.success) {
					ctx.addIssue({
						path: ["email"],
						code: z.ZodIssueCode.custom,
						message: result.error.issues[0].message,
					});
				}
			}
		}
		if (flow === "password" || flow === "reset-password") {
			// Require password
			if (!password) {
				ctx.addIssue({
					path: ["password"],
					code: z.ZodIssueCode.custom,
					message: "Password is required",
				});
			} else {
				if (password.length < 8 || password.length > 20) {
					ctx.addIssue({
						path: ["password"],
						code: z.ZodIssueCode.custom,
						message: "Password must be 8-20 characters long",
					});
				}

				if (!/(?=.*[a-z])(?=.*[A-Z])/.test(password)) {
					ctx.addIssue({
						path: ["password"],
						code: z.ZodIssueCode.custom,
						message:
							"Password should contain at least 1 uppercase and lowercase letter",
					});
				}

				if (!/(?=.*[0-9])(?=.*[!@#$%^&*])/.test(password)) {
					ctx.addIssue({
						path: ["password"],
						code: z.ZodIssueCode.custom,
						message:
							"Password should contain at least 1 number and special character",
					});
				}
			}

			// If confirmPassword is provided, validate match
			if (confirmPassword && password !== confirmPassword) {
				ctx.addIssue({
					path: ["confirmPassword"],
					code: z.ZodIssueCode.custom,
					message: "Passwords do not match",
				});
			}
		}
	});
