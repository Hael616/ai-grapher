import type { Database, Tables, TablesInsert } from "$lib/types/database.types";
import { trace, warn } from "$lib/utils/logger";
import type { SupabaseClient } from "@supabase/supabase-js";

class ProjectsStore {
  loaded = $state(false);
  private loadLocked = $state(false);
  loading = $state(false);
  projects: { [key: string]: Tables<"projects"> } = $state({});
  keys: string[] = $derived(Object.keys(this.projects));

  private supabase: SupabaseClient<Database> | null = null;

  private async loadProjects() {
    if (!this.supabase) {
      warn("Supabase not found, cannot load projects");
      return;
    }

    const { data, error } = await this.supabase
      .from("projects")
      .select("*")
      .order("created_at", { ascending: false });

    if (error) {
      trace("Error loading projects", error);
    } else {
      this.projects = data.reduce(
        (
          acc: { [key: string]: Tables<"projects"> },
          project: Tables<"projects">,
        ) => {
          acc[project.id] = project;
          return acc;
        },
        {} as { [key: string]: Tables<"projects"> },
      );
    }
  }

  public async load(supabase: SupabaseClient<Database>) {
    this.loading = true;
    this.loadLocked = true;

    if (!supabase) {
      warn("Supabase not found, cannot load projects");
      return;
    }

    this.supabase = supabase;

    if (this.loadLocked) return;
    this.loadLocked = true;
    this.loading = true;

    await this.loadProjects();

    this.loaded = true;
    this.loading = false;
    this.loadLocked = false;
  }

  public async createProject(
    project: Omit<
      TablesInsert<"projects">,
      "user_id" | "model_status" | "cover_image_url"
    >,
  ) {
    if (!this.supabase) {
      warn("Supabase not found, cannot create project");
      return;
    }

    const { data, error } = await this.supabase
      .from("projects")
      .insert(project)
      .select()
      .single();

    if (error) {
      trace("Error creating project", error);
      return null;
    }

    this.projects[data.id] = data;

    return data;
  }
}

export default new ProjectsStore();
