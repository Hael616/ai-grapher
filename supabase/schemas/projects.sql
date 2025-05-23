-- Create projects table
CREATE TABLE projects (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    name TEXT NOT NULL,
    description TEXT,
    cover_image_url TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL,
    UNIQUE(id, user_id)
);

-- Enable Row Level Security
ALTER TABLE projects ENABLE ROW LEVEL SECURITY;

-- Create policies
-- Users can view their own projects
CREATE POLICY "Users can view their own projects" ON projects
    FOR SELECT
    TO authenticated
    USING (auth.uid() = user_id);

-- Users can insert their own projects
CREATE POLICY "Users can insert their own projects" ON projects
    FOR INSERT
    TO authenticated
    WITH CHECK (auth.uid() = user_id);

-- Users can update their own projects
CREATE POLICY "Users can update their own projects" ON projects
    FOR UPDATE
    TO authenticated
    USING (auth.uid() = user_id)
    WITH CHECK (auth.uid() = user_id);

-- Users can delete their own projects
CREATE POLICY "Users can delete their own projects" ON projects
    FOR DELETE
    TO authenticated
    USING (auth.uid() = user_id);

-- Create indexes for better query performance
CREATE INDEX projects_user_id_idx ON projects(user_id);
CREATE INDEX projects_created_at_idx ON projects(created_at);

-- Create models table
CREATE TABLE models (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    project_id UUID REFERENCES projects(id) ON DELETE CASCADE,
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
    training_data_url TEXT NOT NULL,
    num_images INTEGER DEFAULT 0,
    training_started_at TIMESTAMP WITH TIME ZONE,
    training_completed_at TIMESTAMP WITH TIME ZONE,
    training_status training_status_type DEFAULT 'pending',
    model_url TEXT,
    model_version TEXT DEFAULT 'v1',
    notes TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- Enable Row Level Security for models
ALTER TABLE models ENABLE ROW LEVEL SECURITY;

-- Create policies for models
-- Users can view models for their own projects
CREATE POLICY "Users can view models for their own projects" ON models
    FOR SELECT
    TO authenticated
    USING (
        auth.uid() = user_id OR
        EXISTS (
            SELECT 1 FROM projects
            WHERE projects.id = models.project_id
            AND projects.user_id = auth.uid()
        )
    );

-- Users can insert models for their own projects
CREATE POLICY "Users can insert models for their own projects" ON models
    FOR INSERT
    TO authenticated
    WITH CHECK (
        auth.uid() = user_id AND
        EXISTS (
            SELECT 1 FROM projects
            WHERE projects.id = project_id
            AND projects.user_id = auth.uid()
        )
    );

-- Users can update models for their own projects
CREATE POLICY "Users can update models for their own projects" ON models
    FOR UPDATE
    TO authenticated
    USING (
        auth.uid() = user_id AND
        EXISTS (
            SELECT 1 FROM projects
            WHERE projects.id = project_id
            AND projects.user_id = auth.uid()
        )
    )
    WITH CHECK (
        auth.uid() = user_id AND
        EXISTS (
            SELECT 1 FROM projects
            WHERE projects.id = project_id
            AND projects.user_id = auth.uid()
        )
    );

-- Users can delete models for their own projects
CREATE POLICY "Users can delete models for their own projects" ON models
    FOR DELETE
    TO authenticated
    USING (
        auth.uid() = user_id AND
        EXISTS (
            SELECT 1 FROM projects
            WHERE projects.id = project_id
            AND projects.user_id = auth.uid()
        )
    );

-- Create indexes for better query performance
CREATE INDEX models_project_id_idx ON models(project_id);
CREATE INDEX models_user_id_idx ON models(user_id);
CREATE INDEX models_training_status_idx ON models(training_status);
CREATE INDEX models_created_at_idx ON models(created_at);
