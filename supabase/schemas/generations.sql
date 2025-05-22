-- Create generations table
CREATE TABLE generations (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    project_id UUID NOT NULL REFERENCES projects(id) ON DELETE CASCADE,
    user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    prompt TEXT NOT NULL,
    scene_type scene_type_type NOT NULL,
    image_url TEXT,
    resolution resolution_type NOT NULL,
    credit_cost INTEGER NOT NULL,
    status generation_status_type NOT NULL DEFAULT 'pending',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- Enable Row Level Security
ALTER TABLE generations ENABLE ROW LEVEL SECURITY;

-- Create policies
-- Users can view their own generations
CREATE POLICY "Users can view their own generations" ON generations
    FOR SELECT
    TO authenticated
    USING (auth.uid() = user_id);

-- Users can insert their own generations
CREATE POLICY "Users can insert their own generations" ON generations
    FOR INSERT
    TO authenticated
    WITH CHECK (auth.uid() = user_id);

-- Users can update their own generations
CREATE POLICY "Users can update their own generations" ON generations
    FOR UPDATE
    TO authenticated
    USING (auth.uid() = user_id)
    WITH CHECK (auth.uid() = user_id);

-- Users can delete their own generations
CREATE POLICY "Users can delete their own generations" ON generations
    FOR DELETE
    TO authenticated
    USING (auth.uid() = user_id);

-- Create indexes for better query performance
CREATE INDEX generations_user_id_idx ON generations(user_id);
CREATE INDEX generations_project_id_idx ON generations(project_id);
CREATE INDEX generations_status_idx ON generations(status);
CREATE INDEX generations_created_at_idx ON generations(created_at);

-- Add constraint to ensure project belongs to the same user
ALTER TABLE generations
    ADD CONSTRAINT generations_project_user_match
    FOREIGN KEY (project_id, user_id)
    REFERENCES projects(id, user_id)
    ON DELETE CASCADE;
