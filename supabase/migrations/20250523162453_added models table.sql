create type "public"."training_status_type" as enum ('not_started', 'training', 'ready', 'pending', 'failed');

drop index if exists "public"."projects_model_status_idx";

create table "public"."models" (
    "id" uuid not null default gen_random_uuid(),
    "project_id" uuid,
    "user_id" uuid,
    "training_data_url" text not null,
    "num_images" integer default 0,
    "training_started_at" timestamp with time zone,
    "training_completed_at" timestamp with time zone,
    "training_status" training_status_type default 'pending'::training_status_type,
    "model_url" text,
    "model_version" text default 'v1'::text,
    "notes" text,
    "created_at" timestamp with time zone not null default timezone('utc'::text, now())
);


alter table "public"."models" enable row level security;

alter table "public"."projects" drop column "model_status";

drop type "public"."model_status_type";

CREATE INDEX models_created_at_idx ON public.models USING btree (created_at);

CREATE UNIQUE INDEX models_pkey ON public.models USING btree (id);

CREATE INDEX models_project_id_idx ON public.models USING btree (project_id);

CREATE INDEX models_training_status_idx ON public.models USING btree (training_status);

CREATE INDEX models_user_id_idx ON public.models USING btree (user_id);

alter table "public"."models" add constraint "models_pkey" PRIMARY KEY using index "models_pkey";

alter table "public"."models" add constraint "models_project_id_fkey" FOREIGN KEY (project_id) REFERENCES projects(id) ON DELETE CASCADE not valid;

alter table "public"."models" validate constraint "models_project_id_fkey";

alter table "public"."models" add constraint "models_user_id_fkey" FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE not valid;

alter table "public"."models" validate constraint "models_user_id_fkey";

grant delete on table "public"."models" to "anon";

grant insert on table "public"."models" to "anon";

grant references on table "public"."models" to "anon";

grant select on table "public"."models" to "anon";

grant trigger on table "public"."models" to "anon";

grant truncate on table "public"."models" to "anon";

grant update on table "public"."models" to "anon";

grant delete on table "public"."models" to "authenticated";

grant insert on table "public"."models" to "authenticated";

grant references on table "public"."models" to "authenticated";

grant select on table "public"."models" to "authenticated";

grant trigger on table "public"."models" to "authenticated";

grant truncate on table "public"."models" to "authenticated";

grant update on table "public"."models" to "authenticated";

grant delete on table "public"."models" to "service_role";

grant insert on table "public"."models" to "service_role";

grant references on table "public"."models" to "service_role";

grant select on table "public"."models" to "service_role";

grant trigger on table "public"."models" to "service_role";

grant truncate on table "public"."models" to "service_role";

grant update on table "public"."models" to "service_role";

create policy "Users can delete models for their own projects"
on "public"."models"
as permissive
for delete
to authenticated
using (((auth.uid() = user_id) AND (EXISTS ( SELECT 1
   FROM projects
  WHERE ((projects.id = models.project_id) AND (projects.user_id = auth.uid()))))));


create policy "Users can insert models for their own projects"
on "public"."models"
as permissive
for insert
to authenticated
with check (((auth.uid() = user_id) AND (EXISTS ( SELECT 1
   FROM projects
  WHERE ((projects.id = models.project_id) AND (projects.user_id = auth.uid()))))));


create policy "Users can update models for their own projects"
on "public"."models"
as permissive
for update
to authenticated
using (((auth.uid() = user_id) AND (EXISTS ( SELECT 1
   FROM projects
  WHERE ((projects.id = models.project_id) AND (projects.user_id = auth.uid()))))))
with check (((auth.uid() = user_id) AND (EXISTS ( SELECT 1
   FROM projects
  WHERE ((projects.id = models.project_id) AND (projects.user_id = auth.uid()))))));


create policy "Users can view models for their own projects"
on "public"."models"
as permissive
for select
to authenticated
using (((auth.uid() = user_id) OR (EXISTS ( SELECT 1
   FROM projects
  WHERE ((projects.id = models.project_id) AND (projects.user_id = auth.uid()))))));



