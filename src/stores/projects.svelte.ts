import type { Database, Tables, TablesInsert } from '$lib/types/database.types';
import { trace, warn } from '$lib/utils/logger';
import { nexus } from '$lib/utils/nexus';
import type { SupabaseClient } from '@supabase/supabase-js';

const mockProjects: (Tables<'projects'> & {
	generation_count: number;
})[] = [
	{
		id: '1',
		user_id: '1',
		name: 'Summer Collection',
		description: 'Product images for summer clothing line',
		cover_image_url:
			'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcThG9OUmDa76UVBfc5el7c-ALmH4cBG-U6g5A&s',
		model_status: 'ready',
		created_at: '2024-03-20',
		generation_count: 12
	},
	{
		id: '2',
		user_id: '1',
		name: 'Skincare Products',
		description: 'Luxury skincare product photography',
		cover_image_url:
			'https://media-cldnry.s-nbcnews.com/image/upload/t_fit-1500w,f_auto,q_auto:best/rockcms/2024-06/240610-beauty-awards-2024-skincare-winners-vl-social-91be20.jpg',
		model_status: 'training',
		created_at: '2024-03-19',
		generation_count: 8
	},
	{
		id: '3',
		user_id: '1',
		name: 'Electronics',
		description: 'Tech product showcase',
		cover_image_url:
			'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTZW2iQNBFnQvAJZ7bTlKRPsRpOOIVmiVoDXg&s',
		model_status: 'failed',
		created_at: '2024-03-18',
		generation_count: 15
	},
	{
		id: '4',
		user_id: '1',
		name: 'Home Decor',
		description: 'Interior decoration items',
		cover_image_url:
			'https://i0.wp.com/blog.marmalead.com/wp-content/uploads/2021/06/home-decor-and-planters.jpg?fit=1200%2C800&ssl=1',
		model_status: 'ready',
		created_at: '2024-03-17',
		generation_count: 10
	},
	{
		id: '5',
		user_id: '1',
		name: 'Jewelry Collection',
		description: 'Fine jewelry photography',
		cover_image_url:
			'https://i0.wp.com/blog.marmalead.com/wp-content/uploads/2021/06/home-decor-and-planters.jpg?fit=1200%2C800&ssl=1',
		model_status: 'pending',
		created_at: '2024-03-16',
		generation_count: 0
	},
	{
		id: '6',
		user_id: '1',
		name: 'Footwear',
		description: 'Shoe collection showcase',
		cover_image_url:
			'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTkZTnpU1IoWJFrFx-U2JxuXeJh0uZAVm-n1g&s',
		model_status: 'ready',
		created_at: '2024-03-15',
		generation_count: 16
	},
	{
		id: '7',
		user_id: '1',
		name: 'New Watch Collection',
		description: 'Luxury timepiece photography',
		cover_image_url:
			'https://images.unsplash.com/photo-1524805444758-089113d48a6d?q=80&w=1000&auto=format&fit=crop',
		model_status: 'pending',
		created_at: '2024-03-14',
		generation_count: 0
	},
	{
		id: '8',
		user_id: '1',
		name: 'Perfume Line',
		description: 'Fragrance bottle photography',
		cover_image_url:
			'https://images.unsplash.com/photo-1592945403244-b3fbafd7f539?q=80&w=1000&auto=format&fit=crop',
		model_status: 'pending',
		created_at: '2024-03-13',
		generation_count: 0
	}
];
class ProjectsStore {
	loaded = $state(false);
	private loadLocked = $state(false);
	loading = $state(false);
	projects: { [key: string]: Tables<'projects'> } = $state({});

	private supabase: SupabaseClient<Database> | null = null;

	private reduceProject = (data: Tables<'projects'>[]) => {
		return data.reduce(
			(acc: { [key: string]: Tables<'projects'> }, project: Tables<'projects'>) => {
				acc[project.id] = project;
				return acc;
			},
			{} as { [key: string]: Tables<'projects'> }
		);
	};
	private loadProjects = async () => {
		if (!this.supabase) {
			warn('Supabase not found, cannot load projects');
			return;
		}

		const { data, error } = await this.supabase
			.from('projects')
			.select('*')
			.order('created_at', { ascending: false });

		if (error || data.length < 1) {
			trace('Error loading projects', error);
			this.projects = this.reduceProject(mockProjects);
		} else {
			this.projects = this.reduceProject(data);
		}
	};

	public load = async (supabase: SupabaseClient<Database>) => {
		this.loading = true;
		this.loadLocked = true;

		if (!supabase) {
			warn('Supabase not found, cannot load projects');
			return;
		}

		this.supabase = supabase;

		await this.loadProjects();

		if (this.loadLocked) return;
		this.loadLocked = true;
		this.loading = true;

		this.loaded = true;
		this.loading = false;
		this.loadLocked = false;
	};

	public createProject = async (
		project: Omit<TablesInsert<'projects'>, 'user_id' | 'model_status' | 'cover_image_url'>
	) => {
		if (!this.supabase) {
			warn('Supabase not found, cannot create project');
			return;
		}

		const { data, error } = await nexus.createProject(project);

		if (error) {
			trace('Error creating project', error);
			return null;
		}

		if (data) {
			this.projects[data.id] = data;

			return data;
		}
	};

	public getProject = (id: string): { error?: string; data?: Tables<'projects'> } => {
		const data = this.projects[id];
		const error = data ? undefined : 'Project not found';
		if (!error) {
			return { data };
		} else {
			trace('Error getting project', error);

			return { error };
		}
	};
}

export default new ProjectsStore();
