-- Create language configuration table
-- This table stores language-specific configuration and metadata

CREATE TABLE IF NOT EXISTS language_config (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    language_code VARCHAR(2) NOT NULL UNIQUE,
    language_name VARCHAR(50) NOT NULL,
    native_name VARCHAR(50) NOT NULL,
    flag_emoji VARCHAR(10),
    is_enabled BOOLEAN DEFAULT true,
    is_default BOOLEAN DEFAULT false,
    sort_order INTEGER DEFAULT 0,
    date_format VARCHAR(20) DEFAULT 'YYYY-MM-DD',
    time_format VARCHAR(20) DEFAULT 'HH:mm',
    currency_code VARCHAR(3) DEFAULT 'EUR',
    timezone VARCHAR(50) DEFAULT 'Europe/Madrid',
    rtl BOOLEAN DEFAULT false,
    locale VARCHAR(10),
    created_at TIMESTAMPTZ DEFAULT now(),
    updated_at TIMESTAMPTZ DEFAULT now()
);

-- Insert supported languages
INSERT INTO language_config (language_code, language_name, native_name, flag_emoji, is_enabled, is_default, sort_order, locale) VALUES
('en', 'English', 'English', '🇺🇸', true, true, 1, 'en-US'),
('es', 'Spanish', 'Español', '🇪🇸', true, false, 2, 'es-ES'),
('ca', 'Catalan', 'Català', '🏴󠁥󠁳󠁣󠁴󠁿', true, false, 3, 'ca-ES')
ON CONFLICT (language_code) DO UPDATE SET
    language_name = EXCLUDED.language_name,
    native_name = EXCLUDED.native_name,
    flag_emoji = EXCLUDED.flag_emoji,
    locale = EXCLUDED.locale,
    updated_at = now();

-- Create indexes
CREATE INDEX IF NOT EXISTS idx_language_config_enabled ON language_config (is_enabled);
CREATE INDEX IF NOT EXISTS idx_language_config_sort ON language_config (sort_order);

-- Ensure only one default language
CREATE UNIQUE INDEX IF NOT EXISTS unique_default_language ON language_config (is_default) WHERE is_default = true;

-- Add trigger to update updated_at timestamp
CREATE OR REPLACE FUNCTION update_language_config_updated_at()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW;
END;
$$ language 'plpgsql';

CREATE TRIGGER update_language_config_updated_at_trigger
    BEFORE UPDATE ON language_config
    FOR EACH ROW
    EXECUTE FUNCTION update_language_config_updated_at();

-- Add comments
COMMENT ON TABLE language_config IS 'Configuration and metadata for supported languages';
COMMENT ON COLUMN language_config.language_code IS 'ISO 639-1 language code';
COMMENT ON COLUMN language_config.language_name IS 'Language name in English';
COMMENT ON COLUMN language_config.native_name IS 'Language name in its native form';
COMMENT ON COLUMN language_config.flag_emoji IS 'Flag emoji for the language/region';
COMMENT ON COLUMN language_config.rtl IS 'Whether this language is right-to-left';
COMMENT ON COLUMN language_config.locale IS 'Full locale identifier for formatting';