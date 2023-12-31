/* Database schema to keep the structure of entire database. */

CREATE TABLE animals(
	id 	INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY NOT NULL,
	name VARCHAR(25) NOT NULL,
	date_of_birth DATE,
	escape_attempts INT,
	neutered BOOLEAN,
	weight_kg DECIMAL
);

ALTER TABLE animals

ADD COLUMN species VARCHAR(25);

CREATE TABLE owners(
	id INT NOT NULL GENERATED ALWAYS AS IDENTITY,
	full_name VARCHAR(50),
	age INT);

CREATE TABLE species(
	id INT PRIMARY KEY NOT NULL GENERATED ALWAYS AS IDENTITY,
	name VARCHAR(50));

ALTER TABLE animals DROP COLUMN species;

ALTER TABLE animals ADD species_id INT, ADD CONSTRAINT FK_SPECIES FOREIGN KEY(species_id) REFERENCES species(id) ON DELETE CASCADE;

ALTER TABLE owners ADD CONSTRAINT owners_pkey PRIMARY KEY(id);

ALTER TABLE animals ADD owner_id INT, ADD CONSTRAINT FK_OWNERS FOREIGN KEY(owner_id) REFERENCES owners(id) ON DELETE CASCADE;

CREATE TABLE vets(
	id SERIAL PRIMARY KEY,
	name VARCHAR(50),
	age INT,
	date_of_graduation DATE
);

CREATE TABLE specializations(
	vet_id INT REFERENCES vets(id),
	species_id INT REFERENCES species(id),
	PRIMARY KEY(vet_id, species_id)
);

CREATE TABLE visits(
	animal_id INT REFERENCES animals(id),
	vet_id INT REFERENCES vets(id),
	date_of_visit DATE
);