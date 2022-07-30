CREATE TABLE [Users]
(
[Id] INT IDENTITY PRIMARY KEY,
[Username] VARCHAR(30) NOT NULL,
[Password] VARCHAR(26) NOT NULL,
[PICTURE] VARBINARY(max),
[LastLoginTime] DATETIME2,
[isDeleted] BIT
)

INSERT INTO [Users]
(
	[Username],
	[Password],
	[isDeleted]
)
VALUES 
	('Kevin', 111444, 1) ,
	('Ben', 12212, 1) ,
	('Denis', 123321, 0) ,
	('Andrej', 321123, 0) , 
	('Narumaki', 01230221347, 1)


SELECT * 
FROM [Users]

--DROP TABLE [Users]