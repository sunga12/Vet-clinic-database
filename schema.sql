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