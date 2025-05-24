-- Create projects table
CREATE TABLE projects (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL,
    name TEXT NOT NULL,
    description TEXT,
    cover_image_url TEXT,
    current_model_id UUID,
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
    project_id UUID,
    user_id UUID,
    model_url TEXT NOT NULL,
    model_version TEXT DEFAULT 'v1',
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
CREATE INDEX models_created_at_idx ON models(created_at);

-- Create training table
CREATE TABLE training (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    project_id UUID,
    user_id UUID,
    training_data_id UUID,
    status training_status_type DEFAULT 'not_started',
    training_started_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()),
    training_completed_at TIMESTAMP WITH TIME ZONE,
    error_message TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- Enable Row Level Security for training
ALTER TABLE training ENABLE ROW LEVEL SECURITY;

-- Create policies for training
-- Users can view training records for their own projects
CREATE POLICY "Users can view training records for their own projects" ON training
    FOR SELECT
    TO authenticated
    USING (
        auth.uid() = user_id OR
        EXISTS (
            SELECT 1 FROM projects
            WHERE projects.id = training.project_id
            AND projects.user_id = auth.uid()
        )
    );

-- Users can insert training records for their own projects
CREATE POLICY "Users can insert training records for their own projects" ON training
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

-- Users can update training records for their own projects
CREATE POLICY "Users can update training records for their own projects" ON training
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

-- Users can delete training records for their own projects
CREATE POLICY "Users can delete training records for their own projects" ON training
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
CREATE INDEX training_project_id_idx ON training(project_id);
CREATE INDEX training_user_id_idx ON training(user_id);
CREATE INDEX training_training_data_id_idx ON training(training_data_id);
CREATE INDEX training_status_idx ON training(status);
CREATE INDEX training_created_at_idx ON training(created_at);

-- Create training_data table
CREATE TABLE training_data (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    project_id UUID,
    user_id UUID,
    zip_url TEXT NOT NULL,
    num_images INTEGER,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- Enable Row Level Security for training_data
ALTER TABLE training_data ENABLE ROW LEVEL SECURITY;

-- Create policies for training_data
-- Users can view training data for their own projects
CREATE POLICY "Users can view training data for their own projects" ON training_data
    FOR SELECT
    TO authenticated
    USING (
        auth.uid() = user_id OR
        EXISTS (
            SELECT 1 FROM projects
            WHERE projects.id = training_data.project_id
            AND projects.user_id = auth.uid()
        )
    );

-- Users can insert training data for their own projects
CREATE POLICY "Users can insert training data for their own projects" ON training_data
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

-- Users can update training data for their own projects
CREATE POLICY "Users can update training data for their own projects" ON training_data
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

-- Users can delete training data for their own projects
CREATE POLICY "Users can delete training data for their own projects" ON training_data
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
CREATE INDEX training_data_project_id_idx ON training_data(project_id);
CREATE INDEX training_data_user_id_idx ON training_data(user_id);
CREATE INDEX training_data_created_at_idx ON training_data(created_at);

-- Add foreign key constraints after all tables are created
ALTER TABLE projects
    ADD CONSTRAINT fk_projects_user_id
    FOREIGN KEY (user_id)
    REFERENCES auth.users(id)
    ON DELETE CASCADE,
    ADD CONSTRAINT fk_projects_current_model_id
    FOREIGN KEY (current_model_id)
    REFERENCES models(id)
    ON DELETE SET NULL;

ALTER TABLE models
    ADD CONSTRAINT fk_models_project_id
    FOREIGN KEY (project_id)
    REFERENCES projects(id)
    ON DELETE CASCADE,
    ADD CONSTRAINT fk_models_user_id
    FOREIGN KEY (user_id)
    REFERENCES auth.users(id)
    ON DELETE CASCADE;

ALTER TABLE training
    ADD CONSTRAINT fk_training_project_id
    FOREIGN KEY (project_id)
    REFERENCES projects(id)
    ON DELETE CASCADE,
    ADD CONSTRAINT fk_training_user_id
    FOREIGN KEY (user_id)
    REFERENCES auth.users(id)
    ON DELETE CASCADE,
    ADD CONSTRAINT fk_training_training_data_id
    FOREIGN KEY (training_data_id)
    REFERENCES training_data(id)
    ON DELETE CASCADE;

ALTER TABLE training_data
    ADD CONSTRAINT fk_training_data_project_id
    FOREIGN KEY (project_id)
    REFERENCES projects(id)
    ON DELETE CASCADE,
    ADD CONSTRAINT fk_training_data_user_id
    FOREIGN KEY (user_id)
    REFERENCES auth.users(id)
    ON DELETE CASCADE;
