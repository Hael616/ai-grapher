# AI Grapher

AI Grapher is an AI app that helps users generate professional product shots by uploading a base image and selecting a style.


## Developing

Once you've cloned the repo, follow these steps to start the development server:

1. Install dependencies:

```bash
pnpm install
```

2. Start the development server:

```bash
pnpm dev
```

## Start Local Supabase

To start the local Supabase server, make sure you have Docker installed and run the following command:

```bash
pnpx supabase start
```

The supabase url and anon key will be displayed in the terminal.

## Run supabase migrations

1. Stop your local supabase server

    > Note: Make sure your local database is stopped before running this command. 

    ```bash
    pnpx supabase stop
    ```

2. Edit the schema in the `supabase/schema/` directory. This can be by editing an existing sql file or creating a new one for a new table e.g `supabase/schema/photos.sql`.

    > Note: Make sure to add the enums to the `supabase/schema/enums.sql` file and the seeds to the `supabase/seeds/` directory.

3. If you created a new sql file, add it to the `supabase/config.toml` file.

    > Note: Make sure to add the new schema to the `schema_paths` array, they are run from top to bottom, so make sure the new schema is after the enums and any other dependent schemas.

4. Create a new migration


    ```bash
    pnpx supabase db diff -f "name-of-migration"
    ```

    This will create a new migration file in the `supabase/migrations/` directory.

5. Apply the migrations

    To apply the migrations, run the following command:

    ```bash
    pnpx supabase start && pnpx supabase migration up
    ```


## Deploy your schema changes 

1. Login to supabase

    ```bash
    supabase login
    ```

2. Link your remote project

    ```bash
    supabase link
    ```

3. Deploy the changes

    ```bash
    supabase db push
    ```

