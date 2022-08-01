--1
SELECT TOP 5
EmployeeID, JobTitle, e.AddressID, a.AddressText
FROM Employees AS e
JOIN Addresses AS a
ON e.AddressID = a.AddressID
ORDER BY AddressID

--2
SELECT TOP 50
FirstName, LastName, t.[Name] AS "Town", a.AddressText
FROM Employees AS e
JOIN Addresses AS a
ON e.AddressID = a.AddressID
JOIN Towns AS t
ON t.TownID = a.TownID
ORDER BY e.FirstName, e.LastName

--3
SELECT 
EmployeeID, FirstName, LastName, d.[Name] AS "DepartmentName"
FROM Employees AS e
JOIN Departments AS d
ON d.DepartmentID = e.DepartmentID
WHERE d.[Name] = 'Sales'
ORDER BY e.EmployeeID

--4
SELECT TOP 5
EmployeeID, FirstName, Salary, d.[Name] AS "DepartmentName"
FROM Employees AS e
JOIN Departments AS d
ON d.DepartmentID = e.DepartmentID
WHERE e.Salary > 15000
ORDER BY d.DepartmentID

--5
SELECT TOP 3
e.EmployeeID, FirstName
FROM Employees AS e
LEFT JOIN EmployeesProjects AS ep
ON e.EmployeeID = ep.EmployeeID
WHERE ep.ProjectID IS NULL
ORDER BY e.EmployeeID

--6
SELECT
FirstName, LastName, HireDate, d.[Name] AS "DeptName"
FROM Employees AS e
JOIN Departments AS d
ON e.DepartmentID = d.DepartmentID
WHERE YEAR(e.HireDate) > 1998
AND d.Name IN ('Sales', 'Finance')
ORDER BY e.HireDate

--7
SELECT TOP 5
e.EmployeeID, FirstName, p.[Name]
FROM Employees AS e
JOIN EmployeesProjects AS ep
ON e.EmployeeID = ep.EmployeeID
JOIN Projects AS p
ON p.ProjectID = ep.ProjectID
WHERE p.StartDate > 13/08/2002
AND p.EndDate IS NULL
ORDER BY e.EmployeeID ASC

--8
SELECT 
[e].[EmployeeID], [e].[FirstName],
	CASE WHEN DATEPART(YEAR, [p].[StartDate]) >= 2005 
			THEN NULL
			ELSE [p].[Name]
	   END AS [ProjectName]
FROM [Employees] AS [e]
JOIN [EmployeesProjects] AS [ep] 
ON [e].[EmployeeID] = [ep].[EmployeeID]
JOIN [Projects] AS [p]
ON [ep].[ProjectID] = [p].[ProjectID]
WHERE [e].[EmployeeID] = 24

--9
SELECT
e.EmployeeID, FirstName, ManagerID,
CASE WHEN ManagerID = 3 
			THEN 'Roberto'
			ELSE 'JoLynn'
	   END AS [ManagerName]
FROM Employees AS e
WHERE ManagerID IN (3, 7)
ORDER BY e.EmployeeID

--10
SELECT TOP 50
e.[EmployeeID],
CONCAT(e.[FirstName], ' ', e.[LastName]) AS [EmployeeName],
CONCAT(em.[FirstName], ' ', em.[LastName]) AS [ManagerName],
[d].[Name] AS [DepartmentName]
FROM [Employees] AS [e]
JOIN [Employees] AS [em] 
ON [e].[ManagerID] = [em].[EmployeeID]
JOIN [Departments] AS [d]
ON [e].[DepartmentID] = [d].[DepartmentID]
ORDER BY [e].[EmployeeID] ASC

--11
SELECT TOP 1
AVG(Salary) as avarage
FROM Employees as e
JOIN Departments as d
ON e.DepartmentID = d.DepartmentID
GROUP BY d.[Name]
ORDER BY avarage ASC

--12
SELECT c.CountryCode, MountainRange, PeakName, Elevation
FROM Countries as c
JOIN MountainsCountries as mc
ON c.CountryCode = mc.CountryCode
JOIN Mountains as m
ON m.Id = mc.MountainId
JOIN Peaks as p
ON p.MountainId = m.Id
WHERE p.Elevation > 2835
AND c.CountryName = 'Bulgaria'
ORDER BY p.Elevation DESC

--13
SELECT c.CountryCode, COUNT(MountainRange) AS "MountainRanges"
FROM Countries as c
JOIN MountainsCountries as mc
ON c.CountryCode = mc.CountryCode
JOIN Mountains as m
ON mc.MountainId = m.Id
WHERE c.CountryName IN ('Bulgaria', 'Russia', 'United States')
GROUP BY c.CountryCode

--14
SELECT TOP 5
c.CountryName, r.RiverName
FROM Countries as c
LEFT JOIN CountriesRivers as cr
ON c.CountryCode = cr.CountryCode
LEFT JOIN Rivers as r
ON cr.RiverId = r.Id
WHERE c.ContinentCode = 'AF'
ORDER BY c.CountryName ASC 

--17
SELECT TOP 5 
[c].[CountryName],
MAX([p].[Elevation]) AS [HighestPeakElevation],
MAX([r].[Length]) AS [LongestRiverLength]
FROM [Countries] AS [c]
LEFT JOIN [MountainsCountries] AS [mc]
ON [c].[CountryCode] = [mc].[CountryCode]
LEFT JOIN [Mountains] AS [m]
ON [mc].[MountainId] = [m].[Id]
LEFT JOIN [Peaks] AS [p]
ON [m].[Id] = [p].[MountainId]
LEFT JOIN [CountriesRivers] AS [cr]
ON [c].[CountryCode] = [cr].[CountryCode]
LEFT JOIN [Rivers] AS [r]
ON [cr].[RiverId] = [r].[Id]
GROUP BY [c].[CountryName]
ORDER BY [HighestPeakElevation] DESC,
	[LongestRiverLength] DESC,
	[CountryName] ASC