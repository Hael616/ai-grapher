alter type "public"."model_status_type" rename to "model_status_type__old_version_to_be_dropped";

create type "public"."model_status_type" as enum ('not_started', 'training', 'ready', 'pending', 'failed');

alter table "public"."projects" alter column model_status type "public"."model_status_type" using model_status::text::"public"."model_status_type";

drop type "public"."model_status_type__old_version_to_be_dropped";


