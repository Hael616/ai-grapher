-- Create plans table
CREATE TABLE plans (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name TEXT NOT NULL,
    monthly_credits INTEGER NOT NULL,
    max_projects INTEGER DEFAULT 1,
    max_resolution resolution_type NOT NULL,
    model_support model_support_type NOT NULL,
    price_monthly INTEGER NOT NULL,
    most_popular BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- Enable Row Level Security
ALTER TABLE plans ENABLE ROW LEVEL SECURITY;

-- Create policies
-- Allow anyone to read plans (public access)
CREATE POLICY "Plans are viewable by everyone" ON plans
    FOR SELECT
    USING (true);

-- Only allow authenticated users with admin role to insert/update/delete plans
CREATE POLICY "Only admins can insert plans" ON plans
    FOR INSERT
    TO authenticated
    WITH CHECK (auth.jwt() ->> 'role' = 'admin');

CREATE POLICY "Only admins can update plans" ON plans
    FOR UPDATE
    TO authenticated
    USING (auth.jwt() ->> 'role' = 'admin')
    WITH CHECK (auth.jwt() ->> 'role' = 'admin');

CREATE POLICY "Only admins can delete plans" ON plans
    FOR DELETE
    TO authenticated
    USING (auth.jwt() ->> 'role' = 'admin');

-- Create indexes for better query performance
CREATE INDEX plans_name_idx ON plans(name);
CREATE INDEX plans_price_monthly_idx ON plans(price_monthly);
