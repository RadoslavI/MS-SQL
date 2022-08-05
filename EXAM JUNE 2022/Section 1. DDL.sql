--Create a database called Zoo. You need to create 7 tables:
--•	Owners – contains information about the owners of the animals
--•	AnimalTypes – contains information about the different animal types in the zoo
--•	Cages – contains information about the animal cages
--•	Animals – contains information about the animals
--•	AnimalsCages – a many to many mapping table between the animals and the cages
--•	VolunteersDepartments – contains information about the departments of the volunteers
--•	Volunteers – contains information about the volunteers

--CREATE DATABASE Zoo


CREATE TABLE Owners
(
	Id INT IDENTITY PRIMARY KEY, 
	[Name] VARCHAR(50) NOT NULL,
	PhoneNumber VARCHAR(15) NOT NULL,
	[Address] VARCHAR(50)
)

CREATE TABLE AnimalTypes
(
	Id INT IDENTITY PRIMARY KEY, 
	AnimalType VARCHAR(30) NOT NULL,
)

CREATE TABLE Cages
(
	Id INT IDENTITY PRIMARY KEY, 
	AnimalTypeId INT FOREIGN KEY REFERENCES AnimalTypes(Id) NOT NULL
)

CREATE TABLE Animals
(
	Id INT IDENTITY PRIMARY KEY, 
	[Name] VARCHAR(30) NOT NULL,
	BirthDate DATE NOT NULL,
	OwnerId INT FOREIGN KEY REFERENCES Owners(Id),
	AnimalTypeId INT FOREIGN KEY REFERENCES AnimalTypes(Id) NOT NULL
)

CREATE TABLE AnimalsCages
(
	CageId INT FOREIGN KEY REFERENCES Cages(Id) NOT NULL, 
	AnimalId INT FOREIGN KEY REFERENCES Animals(Id) NOT NULL,
	PRIMARY KEY(CageId, AnimalId)
)

CREATE TABLE VolunteersDepartments
(
	Id INT IDENTITY PRIMARY KEY, 
	DepartmentName VARCHAR(30) NOT NULL
)

CREATE TABLE Volunteers
(
	Id INT IDENTITY PRIMARY KEY, 
	[Name] VARCHAR(50) NOT NULL,
	PhoneNumber VARCHAR(15) NOT NULL,
	[Address] VARCHAR(50),
	AnimalId INT FOREIGN KEY REFERENCES Animals(Id),
	DepartmentId INT FOREIGN KEY REFERENCES VolunteersDepartments(Id) NOT NULL,
)