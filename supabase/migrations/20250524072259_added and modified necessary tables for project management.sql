alter table "public"."models" drop constraint "models_project_id_fkey";

alter table "public"."models" drop constraint "models_user_id_fkey";

alter table "public"."projects" drop constraint "projects_user_id_fkey";

drop index if exists "public"."models_training_status_idx";

alter type "public"."training_status_type" rename to "training_status_type__old_version_to_be_dropped";

create type "public"."training_status_type" as enum ('not_started', 'training', 'ready', 'failed');

create table "public"."training" (
    "id" uuid not null default gen_random_uuid(),
    "project_id" uuid,
    "user_id" uuid,
    "training_data_id" uuid,
    "status" training_status_type default 'not_started'::training_status_type,
    "training_started_at" timestamp with time zone,
    "training_completed_at" timestamp with time zone,
    "error_message" text,
    "created_at" timestamp with time zone not null default timezone('utc'::text, now())
);


alter table "public"."training" enable row level security;

create table "public"."training_data" (
    "id" uuid not null default gen_random_uuid(),
    "project_id" uuid,
    "user_id" uuid,
    "zip_url" text not null,
    "num_images" integer,
    "created_at" timestamp with time zone not null default timezone('utc'::text, now())
);


alter table "public"."training_data" enable row level security;

alter table "public"."models" drop column "notes";

alter table "public"."models" drop column "num_images";

alter table "public"."models" drop column "training_completed_at";

alter table "public"."models" drop column "training_data_url";

alter table "public"."models" drop column "training_started_at";

alter table "public"."models" drop column "training_status";

alter table "public"."models" alter column "model_url" set not null;

alter table "public"."projects" add column "current_model_id" uuid;

CREATE INDEX training_created_at_idx ON public.training USING btree (created_at);

CREATE INDEX training_data_created_at_idx ON public.training_data USING btree (created_at);

CREATE UNIQUE INDEX training_data_pkey ON public.training_data USING btree (id);

CREATE INDEX training_data_project_id_idx ON public.training_data USING btree (project_id);

CREATE INDEX training_data_user_id_idx ON public.training_data USING btree (user_id);

CREATE UNIQUE INDEX training_pkey ON public.training USING btree (id);

CREATE INDEX training_project_id_idx ON public.training USING btree (project_id);

CREATE INDEX training_status_idx ON public.training USING btree (status);

CREATE INDEX training_training_data_id_idx ON public.training USING btree (training_data_id);

CREATE INDEX training_user_id_idx ON public.training USING btree (user_id);

alter table "public"."training" add constraint "training_pkey" PRIMARY KEY using index "training_pkey";

alter table "public"."training_data" add constraint "training_data_pkey" PRIMARY KEY using index "training_data_pkey";

alter table "public"."models" add constraint "fk_models_project_id" FOREIGN KEY (project_id) REFERENCES projects(id) ON DELETE CASCADE not valid;

alter table "public"."models" validate constraint "fk_models_project_id";

alter table "public"."models" add constraint "fk_models_user_id" FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE not valid;

alter table "public"."models" validate constraint "fk_models_user_id";

alter table "public"."projects" add constraint "fk_projects_current_model_id" FOREIGN KEY (current_model_id) REFERENCES models(id) ON DELETE SET NULL not valid;

alter table "public"."projects" validate constraint "fk_projects_current_model_id";

alter table "public"."projects" add constraint "fk_projects_user_id" FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE not valid;

alter table "public"."projects" validate constraint "fk_projects_user_id";

alter table "public"."training" add constraint "fk_training_project_id" FOREIGN KEY (project_id) REFERENCES projects(id) ON DELETE CASCADE not valid;

alter table "public"."training" validate constraint "fk_training_project_id";

alter table "public"."training" add constraint "fk_training_training_data_id" FOREIGN KEY (training_data_id) REFERENCES training_data(id) ON DELETE CASCADE not valid;

alter table "public"."training" validate constraint "fk_training_training_data_id";

alter table "public"."training" add constraint "fk_training_user_id" FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE not valid;

alter table "public"."training" validate constraint "fk_training_user_id";

alter table "public"."training_data" add constraint "fk_training_data_project_id" FOREIGN KEY (project_id) REFERENCES projects(id) ON DELETE CASCADE not valid;

alter table "public"."training_data" validate constraint "fk_training_data_project_id";

alter table "public"."training_data" add constraint "fk_training_data_user_id" FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE not valid;

alter table "public"."training_data" validate constraint "fk_training_data_user_id";

grant delete on table "public"."training" to "anon";

grant insert on table "public"."training" to "anon";

grant references on table "public"."training" to "anon";

grant select on table "public"."training" to "anon";

grant trigger on table "public"."training" to "anon";

grant truncate on table "public"."training" to "anon";

grant update on table "public"."training" to "anon";

grant delete on table "public"."training" to "authenticated";

grant insert on table "public"."training" to "authenticated";

grant references on table "public"."training" to "authenticated";

grant select on table "public"."training" to "authenticated";

grant trigger on table "public"."training" to "authenticated";

grant truncate on table "public"."training" to "authenticated";

grant update on table "public"."training" to "authenticated";

grant delete on table "public"."training" to "service_role";

grant insert on table "public"."training" to "service_role";

grant references on table "public"."training" to "service_role";

grant select on table "public"."training" to "service_role";

grant trigger on table "public"."training" to "service_role";

grant truncate on table "public"."training" to "service_role";

grant update on table "public"."training" to "service_role";

grant delete on table "public"."training_data" to "anon";

grant insert on table "public"."training_data" to "anon";

grant references on table "public"."training_data" to "anon";

grant select on table "public"."training_data" to "anon";

grant trigger on table "public"."training_data" to "anon";

grant truncate on table "public"."training_data" to "anon";

grant update on table "public"."training_data" to "anon";

grant delete on table "public"."training_data" to "authenticated";

grant insert on table "public"."training_data" to "authenticated";

grant references on table "public"."training_data" to "authenticated";

grant select on table "public"."training_data" to "authenticated";

grant trigger on table "public"."training_data" to "authenticated";

grant truncate on table "public"."training_data" to "authenticated";

grant update on table "public"."training_data" to "authenticated";

grant delete on table "public"."training_data" to "service_role";

grant insert on table "public"."training_data" to "service_role";

grant references on table "public"."training_data" to "service_role";

grant select on table "public"."training_data" to "service_role";

grant trigger on table "public"."training_data" to "service_role";

grant truncate on table "public"."training_data" to "service_role";

grant update on table "public"."training_data" to "service_role";

create policy "Users can delete training records for their own projects"
on "public"."training"
as permissive
for delete
to authenticated
using (((auth.uid() = user_id) AND (EXISTS ( SELECT 1
   FROM projects
  WHERE ((projects.id = training.project_id) AND (projects.user_id = auth.uid()))))));


create policy "Users can insert training records for their own projects"
on "public"."training"
as permissive
for insert
to authenticated
with check (((auth.uid() = user_id) AND (EXISTS ( SELECT 1
   FROM projects
  WHERE ((projects.id = training.project_id) AND (projects.user_id = auth.uid()))))));


create policy "Users can update training records for their own projects"
on "public"."training"
as permissive
for update
to authenticated
using (((auth.uid() = user_id) AND (EXISTS ( SELECT 1
   FROM projects
  WHERE ((projects.id = training.project_id) AND (projects.user_id = auth.uid()))))))
with check (((auth.uid() = user_id) AND (EXISTS ( SELECT 1
   FROM projects
  WHERE ((projects.id = training.project_id) AND (projects.user_id = auth.uid()))))));


create policy "Users can view training records for their own projects"
on "public"."training"
as permissive
for select
to authenticated
using (((auth.uid() = user_id) OR (EXISTS ( SELECT 1
   FROM projects
  WHERE ((projects.id = training.project_id) AND (projects.user_id = auth.uid()))))));


create policy "Users can delete training data for their own projects"
on "public"."training_data"
as permissive
for delete
to authenticated
using (((auth.uid() = user_id) AND (EXISTS ( SELECT 1
   FROM projects
  WHERE ((projects.id = training_data.project_id) AND (projects.user_id = auth.uid()))))));


create policy "Users can insert training data for their own projects"
on "public"."training_data"
as permissive
for insert
to authenticated
with check (((auth.uid() = user_id) AND (EXISTS ( SELECT 1
   FROM projects
  WHERE ((projects.id = training_data.project_id) AND (projects.user_id = auth.uid()))))));


create policy "Users can update training data for their own projects"
on "public"."training_data"
as permissive
for update
to authenticated
using (((auth.uid() = user_id) AND (EXISTS ( SELECT 1
   FROM projects
  WHERE ((projects.id = training_data.project_id) AND (projects.user_id = auth.uid()))))))
with check (((auth.uid() = user_id) AND (EXISTS ( SELECT 1
   FROM projects
  WHERE ((projects.id = training_data.project_id) AND (projects.user_id = auth.uid()))))));


create policy "Users can view training data for their own projects"
on "public"."training_data"
as permissive
for select
to authenticated
using (((auth.uid() = user_id) OR (EXISTS ( SELECT 1
   FROM projects
  WHERE ((projects.id = training_data.project_id) AND (projects.user_id = auth.uid()))))));



drop type "public"."training_status_type__old_version_to_be_dropped";
