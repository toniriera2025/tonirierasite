CREATE TABLE upload_service_status (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    service_name TEXT NOT NULL UNIQUE,
    is_active BOOLEAN DEFAULT true,
    last_check TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text,
    now()),
    response_time INTEGER,
    error_message TEXT,
    success_rate DECIMAL(5,2) DEFAULT 100.00,
    total_uploads INTEGER DEFAULT 0,
    successful_uploads INTEGER DEFAULT 0,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text,
    now()) NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text,
    now()) NOT NULL
);