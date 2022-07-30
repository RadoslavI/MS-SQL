--CREATE DATABASE [Movies]

CREATE TABLE [Directors]
(
	[Id] INT IDENTITY PRIMARY KEY,
	[DirectorName] NVARCHAR(20) NOT NULL,
	[Notes] VARCHAR(400) 
)

CREATE TABLE [Genres]
(
	[Id] INT IDENTITY PRIMARY KEY,
	[GenreName] NVARCHAR(20) NOT NULL,
	[Notes] VARCHAR(400) 
)

CREATE TABLE [Categories]
(
	[Id] INT IDENTITY PRIMARY KEY,
	[CategoryName] NVARCHAR(20) NOT NULL,
	[Notes] VARCHAR(400) 
)

CREATE TABLE [Movies]
(
	[Id] INT IDENTITY PRIMARY KEY,
	[Title] NVARCHAR(50) NOT NULL,
	[DirectorId] INT FOREIGN KEY REFERENCES [Directors]([Id]),
	[CopyrightYear] TINYINT,
	[Lenght] TINYINT,
	[GenreId] INT FOREIGN KEY REFERENCES [Genres]([Id]),
	[CategoryId] INT FOREIGN KEY REFERENCES [Categories]([Id]),
	[Rating] DECIMAL(2,1),
	[Notes] VARCHAR(400) 
)

INSERT INTO [Directors]
([DirectorName])
VALUES
('Ivan'),
('Gosho'),
('Brat Pitt'),
('Arm Pitt'),
('Sasho Kusoto')

INSERT INTO [Genres]
([GenreName])
VALUES
('Thriller'),
('Action'),
('Comedy'),
('Romance'),
('Drama')

INSERT INTO [Categories]
([CategoryName])
VALUES
('Car'),
('Gun'),
('Shooting'),
('Bar'),
('BestSeller')

INSERT INTO [Movies]
([Title], [DirectorId], [GenreId], [CategoryId], [Rating])
VALUES
('Cars', 2, 3, 5, 5.8),
('Lost', 3, 1, 4, 6),
('Friends', 4, 3, 1, 3.8),
('How I met your mother', 5, 3, 2, 9.9),
('Note', 1, 3, 3, 1.8)


SELECT *
FROM [Movies]
