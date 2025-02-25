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
    ('Alice', ROW(0.0, 0.0, 0.0)::LOCATION, 'Scientist', (SELECT planet_id FROM planets WHERE name = 'Earth')),
    ('Bob', ROW(0.0, 0.0, 0.0)::LOCATION, 'Engineer', (SELECT planet_id FROM planets WHERE name = 'Mars')),
    ('Charlie', ROW(0.0, 0.0, 0.0)::LOCATION, 'Diplomat', (SELECT planet_id FROM planets WHERE name = 'Proxima Centauri b'));

    INSERT INTO arguments (argument_type, description) VALUES
    ('scientific', 'Climate change is primarily caused by human activity.'),
    ('ethical', 'Colonizing other planets is morally justifiable to ensure the survival of humanity.'),
    ('economic', 'Investing in space exploration generates long-term economic benefits.');

    INSERT INTO characters_arguments (character_id, argument_id, exposure_source, confidence_level, accepted_date) VALUES
    ((SELECT character_id FROM characters WHERE name = 'Alice'), (SELECT argument_id FROM arguments WHERE argument_type = 'scientific'), 'media', 'high', '2024-01-15'),
    ((SELECT character_id FROM characters WHERE name = 'Bob'), (SELECT argument_id FROM arguments WHERE argument_type = 'ethical'), 'schools', 'medium', '2023-05-20'),
    ((SELECT character_id FROM characters WHERE name = 'Charlie'), (SELECT argument_id FROM arguments WHERE argument_type = 'economic'), 'myself', 'low', '2024-03-10');

    INSERT INTO planets_arguments (planet_id, argument_id, widespread_level, correctness_level) VALUES
    ((SELECT planet_id FROM planets WHERE name = 'Earth'), (SELECT argument_id FROM arguments WHERE argument_type = 'scientific'), 'high', 'high'),
    ((SELECT planet_id FROM planets WHERE name = 'Mars'), (SELECT argument_id FROM arguments WHERE argument_type = 'ethical'), 'medium', 'low'),
    ((SELECT planet_id FROM planets WHERE name = 'Proxima Centauri b'), (SELECT argument_id FROM arguments WHERE argument_type = 'economic'), 'low', 'none');
  EXCEPTION WHEN OTHERS THEN
    ROLLBACK;
    RAISE;
END $$;
