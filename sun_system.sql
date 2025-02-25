BEGIN;

CREATE TYPE LOCATION AS (
    x FLOAT,
    y FLOAT,
    z FLOAT
);

CREATE TABLE sun_systems (
    system_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    location LOCATION,
    description TEXT
);

CREATE TABLE planets (
    planet_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    location LOCATION,
    purpose TEXT,
    description TEXT,
    system_id INTEGER NOT NULL REFERENCES sun_systems(system_id)
);

CREATE TABLE characters (
    character_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    location LOCATION,
    occupation VARCHAR(255),
    hometown_planet_id INTEGER REFERENCES planets(planet_id)
);

CREATE TYPE ARG_TYPE AS ENUM (
    'scientific', 
    'ethical', 
    'economic', 
    'political', 
    'philosophical', 
    'others'
);

CREATE TABLE arguments (
    argument_id SERIAL PRIMARY KEY,
    argument_type ARG_TYPE NOT NULL,
    description TEXT NOT NULL
);

CREATE TYPE DEGREE AS ENUM (
    'high', 
    'medium', 
    'low', 
    'none'
);

CREATE TYPE SOURCE AS ENUM(
    'myself',
    'friends',
    'media',
    'myth',
    'schools',
    'myths', 
    'others'
);

CREATE TABLE characters_arguments (
    character_arg_id SERIAL PRIMARY KEY,
    character_id INTEGER NOT NULL REFERENCES characters(character_id),
    argument_id INTEGER REFERENCES arguments(argument_id),
    exposure_source SOURCE,
    confidence_level DEGREE,
    accepted_date DATE
);

CREATE TABLE planets_arguments (
    planet_arg_id SERIAL PRIMARY KEY,
    planet_id INTEGER NOT NULL REFERENCES planets(planet_id),
    argument_id INTEGER REFERENCES arguments(argument_id),
    widespread_level DEGREE,
    correctness_level DEGREE
);

COMMIT;
