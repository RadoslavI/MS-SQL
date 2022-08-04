--1
CREATE TABLE Logs 
(
	LogId INT IDENTITY PRIMARY KEY, 
	AccountId INT,
	OldSum DECIMAL(16, 2),
	NewSum DECIMAL(16, 2)
)

GO
CREATE TRIGGER tr_AddLogsOnAccountUpdateSum
ON Accounts FOR UPDATE
AS
	INSERT INTO Logs(AccountId, OldSum, NewSum)
	SELECT i.Id, d.Balance, i.Balance
	FROM inserted AS i
	JOIN deleted AS d
	ON i.Id = d.Id
	WHERE i.Balance != d.Balance
GO

--2
CREATE TABLE NotificationEmails 
(
	Id INT IDENTITY PRIMARY KEY, 
	Recipient INT,
	[Subject] VARCHAR(100),
	Body VARCHAR(200)
)

GO
CREATE TRIGGER tr_AddEmails
ON Logs FOR INSERT
AS
	INSERT INTO NotificationEmails(Recipient, [Subject], Body)
	SELECT i.AccountId, 
	CONCAT('Balance change for account: ', [i].[AccountId]),
	CONCAT(
	'On '
	,FORMAT(GETDATE()
	, 'MMM dd yyyy hh:mmtt') 
	, 'your balance was changed from '
	, ROUND([i].[OldSum], 2)
	, ' to '
	, ROUND([i].[NewSum], 2)
	)
	FROM inserted AS i
GO

--3
CREATE PROC [usp_DepositMoney] (@accountId INT, @moneyAmount DECIMAL(9, 4))
AS
BEGIN TRANSACTION
	UPDATE [dbo].[Accounts]
	SET [Balance] += @moneyAmount
	WHERE [Id] = @accountId
	IF (@moneyAmount <= 0)
	BEGIN
		ROLLBACK
		RETURN
	END
COMMIT

--4
CREATE PROCEDURE [usp_WithdrawMoney] (@accountId INT, @moneyAmount DECIMAL(9, 4))
AS
BEGIN TRANSACTION
	UPDATE [Accounts]
	SET [Balance] -= @moneyAmount
	WHERE [Id] = @accountId

	IF (@moneyAmount <= 0)
	BEGIN
		ROLLBACK
		RETURN
	END
COMMIT

--5
CREATE PROC [usp_TransferMoney]
		    (@senderId INT, @receiverId INT, @moneyAmount DECIMAL(9, 4))
AS
BEGIN
	EXEC [dbo].[usp_WithdrawMoney] @senderId, @moneyAmount
	EXEC [dbo].[usp_DepositMoney] @receiverId, @moneyAmount
END

--7
CREATE OR ALTER PROC [usp_AssignProject]
                     (@emloyeeId INT, @projectID INT)
AS
BEGIN TRANSACTION
	IF (
		 SELECT COUNT([ProjectID]) 
		 FROM [EmployeesProjects] 
		 WHERE [EmployeeID] = @emloyeeId
	   ) >= 3 
	BEGIN
		ROLLBACK
		RAISERROR('The employee has too many projects!', 16, 1) 
		RETURN
	END

	INSERT INTO [EmployeesProjects] 
	VALUES (@emloyeeId, @projectID)
COMMIT

--8
CREATE TABLE [Deleted_Employees] (
	[EmployeeId] INT PRIMARY KEY IDENTITY
	, [FirstName] VARCHAR(50) NOT NULL
	, [LastName] VARCHAR(50) NOT NULL
	, [MiddleName] VARCHAR(50)
	, [JobTitle] VARCHAR(50) NOT NULL
	, [DepartmentId] INT NOT NULL
	, [Salary] MONEY NOT NULL
)

GO

CREATE TRIGGER [tr_AddDeletedEmployeeInformation]
ON [Employees] FOR DELETE
AS
	INSERT INTO [Deleted_Employees]([FirstName], [LastName], [MiddleName], [JobTitle], [DepartmentId], [Salary])

	     SELECT [FirstName]
			  , [LastName]
			  , [MiddleName]
			  , [JobTitle]
			  , [DepartmentID]
			  , [Salary]
		   FROM [deleted]