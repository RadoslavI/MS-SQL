CREATE TABLE [People]
(
[Id] INT IDENTITY PRIMARY KEY,
[Name] NVARCHAR(200) NOT NULL,
[PICTURE] IMAGE,
[Height] DECIMAL(3, 2),
[Weight] DECIMAL(5, 2),
[Gender] CHAR(1) NOT NULL,
[Birthdate] DATE NOT NULL,
[Bigraphy] NVARCHAR(max)
)

INSERT INTO [People]
(
	[Name],
	[Height],
	[Weight],
	[Gender],
	[Birthdate]
)
VALUES 
	('Kevin', 1.77, 75.2, 'm', '1998-05-25') ,
	('Ben', 1.50, 90.0, 'm', '2001-02-01') ,
	('Denis', 1.83, 64.8, 'm', '2003-10-06') ,
	('Andrej', 1.75, 65.1, 'm', '2003-02-03') , 
	('Narumaki', 1.80, 63.0, 'm', '2001-01-30')


SELECT * 
FROM People

--DROP TABLE People