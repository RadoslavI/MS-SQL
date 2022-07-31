CREATE TABLE Passports
(
	PassportID INT IDENTITY(101, 1) PRIMARY KEY,
	PassportNumber VARCHAR(8) NOT NULL
)


CREATE TABLE Persons
(
	PersonID INT IDENTITY PRIMARY KEY,
	FirstName VARCHAR(40) NOT NULL,
	Salary DECIMAL(7, 2) NOT NULL,
	PassportID INT FOREIGN KEY REFERENCES Passports(PassportID) UNIQUE
)

INSERT INTO [dbo].[Passports]
( -- Columns to insert data into
    [PassportNumber]
)
VALUES
( -- First row: values for the columns in the list below
    'N34FG21B'
),
( -- Second row: values for the columns in the list below
    'K65LO4R7'
),
( -- Third row: values for the colums in the list below
    'ZE657QP2'
)



INSERT INTO [dbo].[Persons]
( -- Columns to insert data into
    [FirstName]
    , [Salary]
    , [PassportID]
)
VALUES
( -- First row: values for the columns in the list below
    'Roberto'
    , 43300.00
    , 102
),
( -- Second row: values for the columns in the list below
    'Tom'
    , 56100.00
    , 103
),
( -- Third row: values for the colums in the list below
    'Yana'
    , 60200.00
    , 101
)

