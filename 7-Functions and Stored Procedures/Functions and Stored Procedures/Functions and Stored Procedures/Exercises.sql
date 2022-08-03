--1
CREATE PROCEDURE usp_GetEmployeesSalaryAbove35000 AS
SELECT FirstName, LastName
FROM Employees
WHERE Salary > 35000

exec usp_GetEmployeesSalaryAboveNumber(15000)

--2
CREATE OR ALTER PROCEDURE usp_GetEmployeesSalaryAboveNumber (@number DECIMAL(18,4)) 
AS
BEGIN
SELECT FirstName, LastName
FROM Employees
WHERE Salary >= @number
END

--3
CREATE PROCEDURE usp_GetTownsStartingWith  (@string VARCHAR(30)) 
AS
BEGIN
SELECT Towns.Name as Town
FROM Towns
WHERE LEFT(Name, LEN(@string)) = @string
END

--4
CREATE PROCEDURE usp_GetEmployeesFromTown  (@TName VARCHAR(30)) 
AS
BEGIN
SELECT FirstName, LastName
FROM Employees AS e
JOIN Addresses AS a
ON a.AddressID = e.AddressID
JOIN Towns AS t
ON t.TownID = a.TownID
WHERE t.Name = @TName
END

--5
--CREATE FUNCTION ufn_GetSalaryLevel(@salary DECIMAL(18,4)) 
--RETURNS TABLE
--AS
--RETURN(
--SELECT @salary AS Salary,
--	[Salary Level] = CASE	
--		WHEN @salary < 30000 THEN 'Low'
--		WHEN @salary BETWEEN 30000 AND 50000 THEN 'Avarage' 
--		WHEN @salary > 50000 THEN 'High'
--	END  
--)

CREATE OR ALTER FUNCTION ufn_GetSalaryLevel(@salary DECIMAL(18,4))
RETURNS VARCHAR(7)
AS
BEGIN
	--DECLARE @level VARCHAR(7)

	IF(@salary < 30000)
	BEGIN
		RETURN 'Low'
	END

	ELSE IF(@salary BETWEEN 30000 AND 50000)
	BEGIN
		RETURN 'Average'
	END

	RETURN 'High'

END

--6
CREATE PROC usp_EmployeesBySalaryLevel (@level VARCHAR(7))
AS
BEGIN
	SELECT FirstName, LastName
	FROM Employees
	WHERE dbo.ufn_GetSalaryLevel(Salary) = @level 
END

--7
CREATE FUNCTION ufn_IsWordComprised (@setOfLetters VARCHAR(20), @word VARCHAR(20)) 
RETURNS BIT
AS
BEGIN
	DECLARE @i INT = 1
	WHILE (@i <= LEN(@word))
	BEGIN
		DECLARE @currLetter CHAR(1) = SUBSTRING(@word, @i, 1)
		IF (CHARINDEX(@currLetter, @setOfLetters) = 0)
		BEGIN
			RETURN 0
		END
		SET @i += 1
	END
	RETURN 1
END

--8
CREATE PROC [usp_DeleteEmployeesFromDepartment] (@departmentId INT)
AS
BEGIN
	ALTER TABLE [Departments]
	ALTER COLUMN [ManagerID] INT NULL

	DELETE FROM [EmployeesProjects]
    WHERE [EmployeeID] 
	IN (
		 SELECT [EmployeeID] 
		   FROM [Employees] 
		  WHERE [DepartmentID] = @departmentId
	   )

	UPDATE [Employees]
	SET [ManagerID] = NULL
	WHERE [EmployeeID] 
	IN (
		 SELECT [EmployeeID] 
		   FROM [Employees] 
		  WHERE [DepartmentID] = @departmentId
	   )

	UPDATE [Employees]
	SET [ManagerID] = NULL
	WHERE [ManagerID] 
	IN (
		 SELECT [EmployeeID] 
		   FROM [Employees] 
		  WHERE [DepartmentID] = @departmentId
	   )

	UPDATE [Departments]
	SET [ManagerID] = NULL
	WHERE [ManagerID] 
	IN (
		SELECT [EmployeeID] 
		FROM [Employees] 
		WHERE [DepartmentID] = @departmentId
	   )

	DELETE FROM [Employees]
    WHERE [DepartmentID] = @departmentId

	DELETE FROM [Departments]
	WHERE [DepartmentID] = @departmentId

	SELECT COUNT(*) 
    FROM [Employees]
    WHERE [DepartmentID] = @departmentId

END

--9
CREATE PROC usp_GetHoldersFullName 
AS
BEGIN
	SELECT 
	CONCAT(FirstName, ' ', LastName) AS 'Full Name'
	FROM AccountHolders
END

--10
CREATE PROC usp_GetHoldersWithBalanceHigherThan(@amount DECIMAL(18, 4))
AS
BEGIN
	SELECT 
	FirstName, LastName
	FROM AccountHolders AS ah
	JOIN Accounts AS a
	ON a.AccountHolderId = ah.Id
	GROUP BY FirstName, LastName
	HAVING SUM(Balance) > @amount
	ORDER BY FirstName, LastName
END

--11
CREATE FUNCTION [ufn_CalculateFutureValue] (@sum DECIMAL(18, 4), @yearlyInterestRate FLOAT, @numberOfYears INT)
RETURNS DECIMAL(18, 4)
AS
BEGIN
	RETURN @sum * (POWER(1 + @yearlyInterestRate, @numberOfYears))
END



--12
CREATE PROC [usp_CalculateFutureValueForAccount] (@accID INT, @rate FLOAT)
AS
BEGIN
	SELECT 
	[ah].[Id] AS [Account Id],
	[ah].[FirstName] AS [First Name],
	[ah].[LastName] AS [Last Name],
	[a].[Balance] AS [Current Balance],
	[dbo].[ufn_CalculateFutureValue]([a].[Balance], @rate, 5) AS [Balance in 5 years]
	FROM [AccountHolders] AS [ah]
	JOIN [Accounts] AS [a]
	ON [ah].[Id] = [a].[AccountHolderId]
	WHERE [a].[Id] = @accID
END