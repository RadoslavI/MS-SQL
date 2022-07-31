--1
SELECT FirstName, LastName 
FROM Employees
WHERE FirstName Like 'Sa%'

--2
SELECT FirstName, LastName 
FROM Employees
WHERE LastName Like '%ei%'

--3
SELECT FirstName 
FROM Employees
WHERE DepartmentID IN (3, 10)
AND year(HireDate) BETWEEN 1995 AND 2005

--4
SELECT FirstName, LastName 
FROM Employees
WHERE JobTitle NOT LIKE '%engineer%'

--5
SELECT [Name]
FROM Towns
WHERE DATALENGTH(Name) IN (5, 6)
ORDER BY Name

--6
SELECT TownID, [Name]
FROM Towns
WHERE [Name] Like 'M%' OR [Name] LIKE 'K%' OR [Name] LIKE 'B%' OR [Name] LIKE 'E%'
ORDER BY Name

--7
SELECT TownID, [Name]
FROM Towns
WHERE [Name] NOT LIKE 'R%' AND [Name] NOT LIKE 'B%' AND [Name] NOT LIKE 'D%'
ORDER BY Name

--8
CREATE VIEW V_EmployeesHiredAfter2000 AS
SELECT FirstName, LastName
FROM Employees
WHERE YEAR(HireDate) > 2000

--9 
SELECT 
	EmployeeID, 
	FirstName, 
	LastName, 
	Salary,
	DENSE_RANK() OVER (Partition by Salary ORDER BY EmployeeID) AS "Rank"
FROM Employees
WHERE Salary BETWEEN 10000 AND 50000
ORDER BY Salary DESC

--10
SELECT 
	EmployeeID, 
	FirstName, 
	LastName, 
	Salary,
	DENSE_RANK() OVER (Partition by Salary ORDER BY EmployeeID) AS [Rank]
FROM Employees
WHERE Salary BETWEEN 10000 AND 50000
AND [Rank] = 2
ORDER BY Salary DESC


--12
SELECT 
CountryName, IsoCode
FROM Countries
WHERE LOWER(CountryName) LIKE '%a%a%a%'
ORDER BY IsoCode

--13
SELECT 
	[p].[PeakName],
	[r].[RiverName],
	LOWER(CONCAT(LEFT([p].[PeakName], LEN([p].[PeakName]) - 1), [r].[RiverName])) AS [Mix]
FROM [Rivers] AS [r],
	[Peaks] AS [p]
WHERE RIGHT([p].[PeakName], 1) = LEFT([r].[RiverName], 1)
ORDER BY [Mix] ASC

--14
SELECT TOP 50
[Name], FORMAT(Start, 'yyyy-MM-dd') AS Start
FROM Games
WHERE YEAR(Start) IN (2011, 2012)
ORDER BY Start, [Name]

--15
SELECT [Username],
	SUBSTRING([Email], CHARINDEX('@', [Email]) + 1, LEN([Email]) - CHARINDEX('@', [Email]))
    AS [Email Provider]
FROM [Users]
ORDER BY [Email Provider] ASC,
	[Username] ASC

--16
SELECT [Username],
	   [IpAddress]
FROM [Users]
WHERE [IpAddress] LIKE '___.1%.%.___'
ORDER BY [Username] ASC

--17
SELECT [Name] AS [Game]
    , CASE 
        WHEN DATEPART(HOUR, [Start])
            BETWEEN 0 AND 11
            THEN 'Morning'
        WHEN DATEPART(HOUR, [Start])
            BETWEEN 12 AND 17
            THEN 'Afternoon'
        ELSE 'Evening'
    END AS [Part of the Day]

    , CASE 
        WHEN [Duration] <= 3 
            THEN 'Extra Short'
        WHEN [Duration]
            BETWEEN 4 AND 6
            THEN 'Short'
        WHEN [Duration] > 6
            THEN 'Long'
        ELSE 'Extra Long'
    END AS [Duration]
FROM [Games] AS [g]

ORDER BY [g].[Name] ASC,
		[Duration] ASC,
		[Part of the Day] ASC

--18
SELECT [ProductName],
	[OrderDate],
	DATEADD(DAY, 3, [OrderDate]) AS [Pay Due],
	DATEADD(MONTH, 1, [OrderDate]) AS [Deliver Due]
FROM [Orders]