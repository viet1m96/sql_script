SET search_path TO :schema_name;
DO $$
BEGIN
    INSERT INTO sun_systems (name, location, description) VALUES
    ('Sol', ROW(0.3, 0.5, 0.1)::LOCATION, 'Our Solar System'),
    ('Alpha Centauri', ROW(4.37, 0.0, 0.0)::LOCATION, 'Nearest star system to Sol'),
    ('Sirius', ROW(8.6, 0.0, 0.0)::LOCATION, 'Brightest star in the night sky');

    INSERT INTO planets (name, location, purpose, description, system_id) VALUES
    ('Earth', ROW(1.0, 0.0, 0.0)::LOCATION, 'Sustaining life', 'Our home planet', (SELECT system_id FROM sun_systems WHERE name = 'Sol')),
    ('Mars', ROW(1.52, 0.0, 0.0)::LOCATION, 'Potential for colonization', 'The Red Planet', (SELECT system_id FROM sun_systems WHERE name = 'Sol')),
    ('Proxima Centauri b', ROW(0.05, 0.0, 0.0)::LOCATION, 'Exoplanet', 'Potentially habitable exoplanet orbiting Proxima Centauri', (SELECT system_id FROM sun_systems WHERE name = 'Alpha Centauri'));

    INSERT INTO characters (name, location, occupation, hometown_planet_id) VALUES
    ('Alice', ROW(0.0, 0.0, 0.0)::LOCATION, 'Scientist', 1),
    ('Bob', ROW(0.0, 0.0, 0.0)::LOCATION, 'Engineer', 2),
    ('Charlie', ROW(0.0, 0.0, 0.0)::LOCATION, 'Diplomat', 3);

    INSERT INTO arguments (argument_type, description) VALUES
    ('scientific', 'Climate change is primarily caused by human activity.'),
    ('ethical', 'Colonizing other planets is morally justifiable to ensure the survival of humanity.'),
    ('economic', 'Investing in space exploration generates long-term economic benefits.');

    INSERT INTO characters_arguments (character_id, argument_id, exposure_source, confidence_level, accepted_date) VALUES
    (1, 1, 'media', 'high', '2024-01-15'),
    (2, 3, 'schools', 'medium', '2023-05-20'),
    (3, 2, 'myself', 'low', '2024-03-10');

    INSERT INTO planets_arguments (planet_id, argument_id, widespread_level, correctness_level) VALUES
    (1, 3, 'high', 'high'),
    (2, 2, 'medium', 'low'),
    (3, 1, 'low', 'none');
  EXCEPTION 
    WHEN OTHERS THEN
      ROLLBACK;
      RAISE;
END $$;
