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