CREATE Table rangers (
    ranger_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    region VARCHAR(50) NOT NULL
)


CREATE Table species (
    species_id SERIAL PRIMARY KEY,
    common_name VARCHAR(50) NOT NULL,
    scientific_name VARCHAR(50) NOT NULL,
    discovery_date DATE NOT NULL,
    conservation_status VARCHAR(25)
)


CREATE Table sightings (
    sighting_id SERIAL PRIMARY KEY,
    ranger_id INT REFERENCES rangers(ranger_id),
    species_id INT REFERENCES species(species_id),
    sighting_time TIMESTAMP without time zone NOT NULL,
    location VARCHAR(50) NOT NULL,
    notes TEXT
)

INSERT INTO rangers (name, region) VALUES 
('Alice Green', 'Northern Hills'),
('Bob White', 'River Delta'),
('Carol King', 'Mountain Range');


INSERT INTO species (common_name, scientific_name, discovery_date, conservation_status) VALUES 
('Snow Leopard', 'Panthera uncia', '1775-01-01', 'Endangered'),
('Bengal Tiger', 'Panthera tigris tigris', '1758-01-01', 'Endangered'),
('Red Panda', 'Ailurus fulgens', '1825-01-01', 'Vulnerable'),
('Asiatic Elephant', 'Elephas maximus indicus', '1758-01-01', 'Endangered');


INSERT INTO sightings (ranger_id, species_id, location, sighting_time, notes) VALUES 
(1, 1, 'Peak Ridge', '2024-05-10 07:45:00', 'Camera trap image captured'),
(2, 2, 'Bankwood Area', '2024-05-12 16:20:00', 'Juvenile seen'),
(3, 3, 'Bamboo Grove East', '2024-05-15 09:10:00', 'Feeding observed'),
(2, 1, 'Snowfall Pass', '2024-05-18 18:30:00', NULL);

SELECT * FROM rangers;
SELECT * FROM species;
SELECT * FROM sightings;


-- Problem 1
INSERT into rangers (name, region) VALUES('Derek Fox', 'Coastal Plains');
SELECT * FROM rangers;

-- Problem 2
SELECT count(species_id) as unique_species_count FROM sightings
    GROUP BY species_id
        ORDER BY unique_species_count desc;

-- Problem 3
SELECT * FROM sightings
    WHERE location LIKE '%Pass%';

-- Problem 4
SELECT r.name, count(sig.ranger_id) as total_sightings FROM sightings as sig
    INNER JOIN rangers as r ON sig.ranger_id = r.ranger_id
        GROUP BY r.ranger_id, r.name;

-- Problem 5
SELECT s.common_name from species as s
    LEFT JOIN sightings as sig ON sig.species_id = s.species_id
        WHERE sig.species_id IS NULL;

-- Problem 6
SELECT s.common_name, sig.sighting_time, r.name FROM sightings as sig
    JOIN species as s ON sig.species_id = s.species_id
    JOIN rangers as r ON sig.ranger_id = r.ranger_id
        ORDER BY sighting_time desc
            LIMIT 2;

-- Problem 7

UPDATE species set conservation_status = 'Historic' 
    WHERE extract(year from discovery_date) <1800;
    
SELECT * FROM species;


-- Problem 8
SELECT 
    sighting_id,
    CASE 
        WHEN extract(hour FROM sighting_time) < 12 THEN 'Morning'
        WHEN extract(hour FROM sighting_time) >= 12 AND extract(hour FROM sighting_time) < 17 THEN 'Afternoon'
        ELSE 'Evening'
    END as time_of_day FROM sightings
        ORDER BY sighting_id asc;

-- Problem 9
DELETE FROM rangers
    WHERE ranger_id IN (
        SELECT r.ranger_id FROM rangers r
            LEFT JOIN sightings sig ON r.ranger_id = sig.ranger_id
                WHERE sig.ranger_id IS NULL
    );

SELECT * FROM rangers;
