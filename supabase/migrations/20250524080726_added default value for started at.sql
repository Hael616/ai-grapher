alter table "public"."training" alter column "training_started_at" set default timezone('utc'::text, now());


