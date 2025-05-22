create type "public"."generation_status_type" as enum ('pending', 'success', 'failed');

create type "public"."model_status_type" as enum ('not_started', 'training', 'ready');

create type "public"."model_support_type" as enum ('none', 'basic', 'full');

create type "public"."resolution_type" as enum ('720p', '1080p', '4k');

create type "public"."scene_type_type" as enum ('studio', 'lifestyle', 'modeling');

create table "public"."generations" (
    "id" uuid not null default gen_random_uuid(),
    "project_id" uuid not null,
    "user_id" uuid not null,
    "prompt" text not null,
    "scene_type" scene_type_type not null,
    "image_url" text,
    "resolution" resolution_type not null,
    "credit_cost" integer not null,
    "status" generation_status_type not null default 'pending'::generation_status_type,
    "created_at" timestamp with time zone not null default timezone('utc'::text, now())
);


alter table "public"."generations" enable row level security;

create table "public"."plans" (
    "id" uuid not null default gen_random_uuid(),
    "name" text not null,
    "monthly_credits" integer not null,
    "max_projects" integer default 1,
    "max_resolution" resolution_type not null,
    "model_support" model_support_type not null,
    "price_monthly" integer not null,
    "created_at" timestamp with time zone not null default timezone('utc'::text, now())
);


alter table "public"."plans" enable row level security;

create table "public"."projects" (
    "id" uuid not null default gen_random_uuid(),
    "user_id" uuid not null,
    "name" text not null,
    "description" text,
    "cover_image_url" text,
    "model_status" model_status_type not null,
    "created_at" timestamp with time zone not null default timezone('utc'::text, now())
);


alter table "public"."projects" enable row level security;

CREATE INDEX generations_created_at_idx ON public.generations USING btree (created_at);

CREATE UNIQUE INDEX generations_pkey ON public.generations USING btree (id);

CREATE INDEX generations_project_id_idx ON public.generations USING btree (project_id);

CREATE INDEX generations_status_idx ON public.generations USING btree (status);

CREATE INDEX generations_user_id_idx ON public.generations USING btree (user_id);

CREATE INDEX plans_name_idx ON public.plans USING btree (name);

CREATE UNIQUE INDEX plans_pkey ON public.plans USING btree (id);

CREATE INDEX plans_price_monthly_idx ON public.plans USING btree (price_monthly);

CREATE INDEX projects_created_at_idx ON public.projects USING btree (created_at);

CREATE UNIQUE INDEX projects_id_user_id_key ON public.projects USING btree (id, user_id);

CREATE INDEX projects_model_status_idx ON public.projects USING btree (model_status);

CREATE UNIQUE INDEX projects_pkey ON public.projects USING btree (id);

CREATE INDEX projects_user_id_idx ON public.projects USING btree (user_id);

alter table "public"."generations" add constraint "generations_pkey" PRIMARY KEY using index "generations_pkey";

alter table "public"."plans" add constraint "plans_pkey" PRIMARY KEY using index "plans_pkey";

alter table "public"."projects" add constraint "projects_pkey" PRIMARY KEY using index "projects_pkey";

alter table "public"."generations" add constraint "generations_project_id_fkey" FOREIGN KEY (project_id) REFERENCES projects(id) ON DELETE CASCADE not valid;

alter table "public"."generations" validate constraint "generations_project_id_fkey";

alter table "public"."generations" add constraint "generations_project_user_match" FOREIGN KEY (project_id, user_id) REFERENCES projects(id, user_id) ON DELETE CASCADE not valid;

alter table "public"."generations" validate constraint "generations_project_user_match";

alter table "public"."generations" add constraint "generations_user_id_fkey" FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE not valid;

alter table "public"."generations" validate constraint "generations_user_id_fkey";

alter table "public"."projects" add constraint "projects_id_user_id_key" UNIQUE using index "projects_id_user_id_key";

alter table "public"."projects" add constraint "projects_user_id_fkey" FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE not valid;

alter table "public"."projects" validate constraint "projects_user_id_fkey";

grant delete on table "public"."generations" to "anon";

grant insert on table "public"."generations" to "anon";

grant references on table "public"."generations" to "anon";

grant select on table "public"."generations" to "anon";

grant trigger on table "public"."generations" to "anon";

grant truncate on table "public"."generations" to "anon";

grant update on table "public"."generations" to "anon";

grant delete on table "public"."generations" to "authenticated";

grant insert on table "public"."generations" to "authenticated";

grant references on table "public"."generations" to "authenticated";

grant select on table "public"."generations" to "authenticated";

grant trigger on table "public"."generations" to "authenticated";

grant truncate on table "public"."generations" to "authenticated";

grant update on table "public"."generations" to "authenticated";

grant delete on table "public"."generations" to "service_role";

grant insert on table "public"."generations" to "service_role";

grant references on table "public"."generations" to "service_role";

grant select on table "public"."generations" to "service_role";

grant trigger on table "public"."generations" to "service_role";

grant truncate on table "public"."generations" to "service_role";

grant update on table "public"."generations" to "service_role";

grant delete on table "public"."plans" to "anon";

grant insert on table "public"."plans" to "anon";

grant references on table "public"."plans" to "anon";

grant select on table "public"."plans" to "anon";

grant trigger on table "public"."plans" to "anon";

grant truncate on table "public"."plans" to "anon";

grant update on table "public"."plans" to "anon";

grant delete on table "public"."plans" to "authenticated";

grant insert on table "public"."plans" to "authenticated";

grant references on table "public"."plans" to "authenticated";

grant select on table "public"."plans" to "authenticated";

grant trigger on table "public"."plans" to "authenticated";

grant truncate on table "public"."plans" to "authenticated";

grant update on table "public"."plans" to "authenticated";

grant delete on table "public"."plans" to "service_role";

grant insert on table "public"."plans" to "service_role";

grant references on table "public"."plans" to "service_role";

grant select on table "public"."plans" to "service_role";

grant trigger on table "public"."plans" to "service_role";

grant truncate on table "public"."plans" to "service_role";

grant update on table "public"."plans" to "service_role";

grant delete on table "public"."projects" to "anon";

grant insert on table "public"."projects" to "anon";

grant references on table "public"."projects" to "anon";

grant select on table "public"."projects" to "anon";

grant trigger on table "public"."projects" to "anon";

grant truncate on table "public"."projects" to "anon";

grant update on table "public"."projects" to "anon";

grant delete on table "public"."projects" to "authenticated";

grant insert on table "public"."projects" to "authenticated";

grant references on table "public"."projects" to "authenticated";

grant select on table "public"."projects" to "authenticated";

grant trigger on table "public"."projects" to "authenticated";

grant truncate on table "public"."projects" to "authenticated";

grant update on table "public"."projects" to "authenticated";

grant delete on table "public"."projects" to "service_role";

grant insert on table "public"."projects" to "service_role";

grant references on table "public"."projects" to "service_role";

grant select on table "public"."projects" to "service_role";

grant trigger on table "public"."projects" to "service_role";

grant truncate on table "public"."projects" to "service_role";

grant update on table "public"."projects" to "service_role";

create policy "Users can delete their own generations"
on "public"."generations"
as permissive
for delete
to authenticated
using ((auth.uid() = user_id));


create policy "Users can insert their own generations"
on "public"."generations"
as permissive
for insert
to authenticated
with check ((auth.uid() = user_id));


create policy "Users can update their own generations"
on "public"."generations"
as permissive
for update
to authenticated
using ((auth.uid() = user_id))
with check ((auth.uid() = user_id));


create policy "Users can view their own generations"
on "public"."generations"
as permissive
for select
to authenticated
using ((auth.uid() = user_id));


create policy "Only admins can delete plans"
on "public"."plans"
as permissive
for delete
to authenticated
using (((auth.jwt() ->> 'role'::text) = 'admin'::text));


create policy "Only admins can insert plans"
on "public"."plans"
as permissive
for insert
to authenticated
with check (((auth.jwt() ->> 'role'::text) = 'admin'::text));


create policy "Only admins can update plans"
on "public"."plans"
as permissive
for update
to authenticated
using (((auth.jwt() ->> 'role'::text) = 'admin'::text))
with check (((auth.jwt() ->> 'role'::text) = 'admin'::text));


create policy "Plans are viewable by everyone"
on "public"."plans"
as permissive
for select
to public
using (true);


create policy "Users can delete their own projects"
on "public"."projects"
as permissive
for delete
to authenticated
using ((auth.uid() = user_id));


create policy "Users can insert their own projects"
on "public"."projects"
as permissive
for insert
to authenticated
with check ((auth.uid() = user_id));


create policy "Users can update their own projects"
on "public"."projects"
as permissive
for update
to authenticated
using ((auth.uid() = user_id))
with check ((auth.uid() = user_id));


create policy "Users can view their own projects"
on "public"."projects"
as permissive
for select
to authenticated
using ((auth.uid() = user_id));



