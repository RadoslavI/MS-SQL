DROP TABLE IF EXISTS Manufacturers

CREATE TABLE Manufacturers
(
	ManufacturerID INT IDENTITY PRIMARY KEY,
	[Name] VARCHAR(5) NOT NULL,
	EstablishedOn DATE
)

DROP TABLE IF EXISTS Models
CREATE TABLE Models
(
	ModelID INT IDENTITY PRIMARY KEY,
	[Name] VARCHAR(10) NOT NULL,
	ManufacturerID INT FOREIGN KEY REFERENCES Manufacturers(ManufacturerID)
)


INSERT INTO [dbo].[Manufacturers]
( -- Columns to insert data into
    [Name]
    , [EstablishedOn]
)
VALUES
( -- First row: values for the columns in the list below
    'BMW'
    , '1916/03/07'
),
( -- Second row: values for the columns in the list below
    'Tesla'
    , '2003/01/01'
),
( -- Third row: values for the colums in the list below
    'Lada'
    , '1966/05/01'
)


INSERT INTO [dbo].[Models]
( -- Columns to insert data into
    [Name]
    , [ManufacturerID]
)
VALUES
( -- First row: values for the columns in the list below
    'X1'
    , 1
),
( -- Second row: values for the columns in the list below
    'i6'
    , 1
),
( -- Third row: values for the colums in the list below
    'Model S'
    , 2
),
( -- Fourth row: values for the colums in the list below
    'Model X'
    , 2
),
( -- Fifth row: values for the colums in the list below
    'Model 3'
    , 2
),
( -- Sixth row: values for the colums in the list below
    'Nova'
    , 3
)
