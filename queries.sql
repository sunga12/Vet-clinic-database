/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';

SELECT * FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';

SELECT * FROM animals WHERE neutered IS true AND escape_attempts < 3;

SELECT * FROM animals WHERE name IN ('Agumon', 'Pikachu');

SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;

SELECT * FROM animals WHERE neutered IS true;

SELECT * FROM animals WHERE name NOT IN ('Gabumon');

SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

/* Query & Update Tables */

/* Transactions */

BEGIN;
UPDATE animals
SET species = 'unspecified';
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

BEGIN;
UPDATE animals
SET species = 'digimon'
WHERE name LIKE '%mon';
UPDATE animals
SET species = 'pokemon'
WHERE name NOT LIKE '%mon';
COMMIT;
SELECT * FROM animals;

BEGIN;
DELETE FROM animals;
ROLLBACK;
SELECT * FROM animals;

BEGIN;
DELETE FROM animals
WHERE date_of_birth > '2022-01-01';
SAVEPOINT SP1;
SELECT * FROM animals;
UPDATE animals
SET weight_kg = weight_kg * -1;
ROLLBACK TO SAVEPOINT SP1;
UPDATE animals
SET weight_kg = weight_kg * -1
WHERE weight_kg < 0;
COMMIT;

/* Queries */

SELECT COUNT(id) FROM animals;

SELECT COUNT(*) FROM animals
WHERE escape_attempts = 0;

SELECT AVG(weight_kg) FROM animals;

SELECT neutered, MAX(escape_attempts) AS max_escape_attempts FROM animals
GROUP BY neutered;

SELECT species, MAX(weight_kg), MIN(weight_kg) FROM animals
GROUP BY species;

SELECT species, AVG(escape_attempts) AS Average_escape_attempts_per_animal_type 
FROM animals
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31'
GROUP BY species;

/* Query Multiple Tables*/

SELECT name from animals
JOIN owners
ON animals.owner_id = owners.id
WHERE full_name = 'Melody Pond';

SELECT animals.name from animals
JOIN species
ON animals.species_id = species.id
WHERE species.name = 'Pokemon';

SELECT owners.full_name AS Owner_name, animals.name AS animal FROM animals
RIGHT JOIN owners
ON
animals.owner_id = owners.id;

SELECT species.name, COUNT(*) AS Total_Per_species FROM species
JOIN animals
ON
species.id = animals.species_id
GROUP BY species.name;


SELECT animals.name FROM animals
JOIN owners
ON
animals.owner_id = owners.id
JOIN species
ON
animals.species_id = species.id
WHERE owners.full_name = 'Jennifer Orwell' and species.name = 'Digimon';

SELECT animals.name FROM animals
JOIN owners
ON
animals.owner_id = owners.id
JOIN species
ON
animals.species_id = species.id
WHERE owners.full_name = 'Dean Winchester' and animals.escape_attempts = 0;


SELECT owners.full_name, COUNT(*) as Total_Owned from owners
JOIN animals
ON owners.id = animals.owner_id
GROUP BY owners.full_name
ORDER BY COUNT(*) DESC LIMIT 1;

SELECT name FROM animals WHERE id = 
(SELECT animal_id FROM visits
JOIN vets
ON
visits.vet_id = vets.id
WHERE name = 'William Tatcher'
ORDER BY date_of_visit
DESC LIMIT 1
);

SELECT COUNT(DISTINCT animal_id) FROM visits
JOIN vets
ON visits.vet_id = vets.id
WHERE name = 'Stephanie Mendez';

SELECT name, (SELECT name FROM species WHERE id = specializations.species_id) AS species
FROM vets
LEFT JOIN specializations
ON specializations.vet_id = vets.id;

SELECT (SELECT name FROM animals WHERE id = visits.animal_id)
FROM visits
WHERE vet_id = (SELECT id FROM vets WHERE name = 'Stephanie Mendez')
AND date_of_visit BETWEEN '2020-04-01' and '2020-08-30';

SELECT animals.name, COUNT(visits.animal_id) AS number_of_visits
FROM visits
JOIN animals
ON animals.id = visits.animal_id
GROUP BY visits.animal_id, animals.name
ORDER BY number_of_visits DESC LIMIT 1;

SELECT animals.name, visits.date_of_visit
FROM visits
JOIN animals ON animals.id = visits.animal_id
JOIN vets ON vets.id = visits.vet_id
WHERE vets.name = 'Maisy Smith'
ORDER BY visits.date_of_visit ASC LIMIT 1;

SELECT animals.*, vets.*, visits.date_of_visit
FROM visits
JOIN animals ON animals.id = visits.animal_id
JOIN vets ON vets.id = visits.vet_id
WHERE visits.date_of_visit = (SELECT MAX(date_of_visit) FROM visits)
LIMIT 1;

SELECT animals.*, vets.*, visits.date_of_visit
FROM visits
JOIN animals ON animals.id = visits.animal_id
JOIN vets ON vets.id = visits.vet_id
WHERE visits.date_of_visit = (SELECT MAX(date_of_visit) FROM visits)
LIMIT 1;

SELECT COUNT(*)
FROM visits 
JOIN animals ON visits.animal_id = animals.id
LEFT JOIN specializations ON visits.vet_id = specializations.vet_id AND animals.species_id = specializations.species_id
WHERE specializations.species_id IS NULL

SELECT species.name
FROM visits
JOIN animals ON visits.animal_id = animals.id
JOIN species ON species.id = animals.species_id
WHERE visits.vet_id = (SELECT id FROM vets WHERE name = 'Maisy Smith')
GROUP BY species.name
ORDER BY COUNT(*) DESC LIMIT 1;