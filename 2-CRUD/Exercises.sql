--2
SELECT * 
FROM [Departments]
--3
SELECT Name 
FROM [Departments]

--4 
SELECT FirstName, LastName, Salary 
FROM Employees

--5 
SELECT FirstName, MiddleName, LastName
FROM Employees

--6
SELECT 
CONCAT(FirstName, '.', LastName, '@softuni.bg') AS [Full Email Address]
FROM Employees

SELECT * FROM Employees
--7
SELECT DISTINCT Salary
FROM Employees

--8
SELECT * 
FROM Employees
WHERE JobTitle = 'Sales Representative'

--9
SELECT FirstName, LastName, JobTitle
FROM Employees
WHERE Salary BETWEEN 20000 AND 30000

--11
SELECT 
FirstName, LastName
FROM Employees
WHERE ManagerID IS NULL

--12
SELECT 
FirstName, LastName, Salary
FROM Employees
WHERE Salary > 50000
ORDER BY Salary DESC

--13
SELECT TOP 5
FirstName, LastName
FROM Employees
ORDER BY Salary DESC

--14
SELECT
FirstName, LastName
FROM Employees
WHERE DepartmentID <> 4

--15
SELECT *
FROM Employees
ORDER BY Salary DESC, FirstName ASC, LastName DESC, MiddleName ASC

--16
CREATE VIEW [V_EmployeesSalaries] AS
SELECT FirstName, LastName, Salary
FROM Employees

Select * From V_EmployeesSalaries

--17
CREATE VIEW V_EmployeeNameJobTitle AS
SELECT CONCAT(FirstName, ' ', MiddleName, ' ', LastName) AS [Full Name]
, JobTitle AS [Job Title]
FROM Employees

Select * From V_EmployeeNameJobTitle

--18
SELECT DISTINCT
JobTitle
FROM Employees

--19 
SELECT TOP 10
ProjectID AS ID, Name, Description, StartDate, EndDate
FROM Projects
ORDER BY StartDate, Name

--20
SELECT TOP 7
FirstName, LastName, HireDate
FROM Employees
ORDER BY HireDate DESC

--21
UPDATE Employees
SET Salary *= 1.12
WHERE DepartmentID IN (1, 2, 4, 11)

SELECT Salary
FROM Employees

--22

USE Geography

SELECT PeakName
FROM PEAKS
ORDER By PeakName

--23
SELECT TOP 30
CountryName, Population
FROM Countries
WHERE ContinentCode = 'EU'
ORDER BY Population DESC, CountryName

--25
USE Diablo

SELECT Name
FROM Characters
ORDER BY Name ASC
