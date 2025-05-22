-- Model support types for plans
CREATE TYPE model_support_type AS ENUM ('none', 'basic', 'full');

-- Resolution types for plans and generations
CREATE TYPE resolution_type AS ENUM ('720p', '1080p', '4k');

-- Model status types for projects
CREATE TYPE model_status_type AS ENUM ('not_started', 'training', 'ready', 'pending', 'failed');

-- Generation status types
CREATE TYPE generation_status_type AS ENUM ('pending', 'success', 'failed');

-- Scene types for generations
CREATE TYPE scene_type_type AS ENUM ('studio', 'lifestyle', 'modeling'); 