--5 Volunteers
SELECT
[Name], PhoneNumber, [Address], AnimalId, DepartmentId
FROM Volunteers
ORDER BY [Name], AnimalId, DepartmentId

--6 Animals data
SELECT
[Name], AnimalType, FORMAT(BirthDate, 'dd.MM.yyyy')
FROM Animals AS a
JOIN AnimalTypes AS at
ON at.Id = a.AnimalTypeId
ORDER BY [Name]

--7 Owners and Their Animals
SELECT TOP 5
o.[Name] AS [Owner], COUNT(a.Id) AS [CountOfAnimals]
FROM Owners as o
JOIN Animals as a
ON a.OwnerId = o.Id
GROUP BY ?o.[Name]
ORDER BY CountOfAnimals DESC

?
--8 Owners, Animals and Cages
SELECT
CONCAT(o.[Name], '-', a.[Name]) AS OwnersAnimals,
o.PhoneNumber,
ac.CageId AS CageId
FROM Owners AS o
JOIN Animals AS a
ON o.Id = a.OwnerId
JOIN AnimalTypes AS at
ON at.Id = a.AnimalTypeId
JOIN AnimalsCages AS ac
ON ac.AnimalId = a.Id
WHERE at.AnimalType = 'Mammals'
ORDER BY o.Name ASC, a.Name DESC

--9 Volunteers in Sofia

SELECT
[Name], PhoneNumber, TRIM(' Sofia,' FROM [Address]) as Address
FROM Volunteers as v
JOIN VolunteersDepartments as vd
ON v.DepartmentId = vd.Id
WHERE vd.DepartmentName = 'Education program assistant' 
AND v.[Address] LIKE '%Sofia%'
ORDER BY [Name]

--10 Animals for Adoption

SELECT 
	a.[Name], 
	YEAR(a.BirthDate) AS BirthYear,
	at.AnimalType
FROM Animals AS a
JOIN AnimalTypes AS at
ON at.Id = a.AnimalTypeId
WHERE a.OwnerId IS NULL
AND (2022 - YEAR(a.BirthDate)) < 5
AND at.AnimalType != 'Birds'
ORDER BY a.Name
