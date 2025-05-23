import type { Tables, TablesInsert } from '$lib/types/database.types';
import type { Session } from '@supabase/supabase-js';

class Nexus {
	private session: Session | null = null;

	private request = async (
		method: 'GET' | 'POST' | 'PUT' | 'DELETE',
		url: string,
		body?: unknown
	): Promise<{ error?: string; data?: unknown }> => {
		const headers = {
			'Content-Type': 'application/json',
			Authorization: `Bearer ${this.session?.access_token ?? ''}`
		};

		const response = await fetch(url, {
			method,
			headers,
			body: JSON.stringify(body)
		});

		if (!response.ok) {
			return { error: await response.text() };
		}

		return { data: await response.json() };
	};

	private get = async (url: string): Promise<{ error?: string; data?: unknown }> => {
		const { error, data } = await this.request('GET', url);
		if (error) {
			return { error };
		}

		return { data: data as Tables<'projects'> };
	};

	private post = async (url: string, body?: unknown) => {
		return this.request('POST', url, body);
	};

	private put = async (url: string, body?: unknown) => {
		return this.request('PUT', url, body);
	};

	private delete = async (url: string) => {
		return this.request('DELETE', url);
	};

	init(session: Session) {
		this.session = session;
	}

	public createProject = async (
		project: Omit<TablesInsert<'projects'>, 'user_id' | 'model_status' | 'cover_image_url'>
	): Promise<{ error?: string; data?: Tables<'projects'> }> => {
		return this.post('/api/projects', project).then((data) => {
			if (data.error) {
				return { error: data.error };
			}

			return { data: data.data as Tables<'projects'> };
		});
	};
}

export const nexus = new Nexus();
