DROP TABLE IF EXISTS Teachers

CREATE TABLE Teachers
(
	TeacherID INT IDENTITY(101, 1) PRIMARY KEY,
	[Name] VARCHAR(10) NOT NULL,
	ManagerID INT FOREIGN KEY REFERENCES Teachers(TeacherID)	
)


INSERT INTO [dbo].[Teachers]
( -- Columns to insert data into
    [Name]
    , [ManagerID]
)
VALUES
( -- First row: values for the columns in the list below
    'John'
    , NULL
),
( -- Second row: values for the columns in the list below
    'Maya'
    , 106
),
( -- Third row: values for the colums in the list below
    'Silvia'
    , 106
),
( -- Fourth row: values for the colums in the list below
    'Ted'
    , 105
),
( -- Fifth row: values for the colums in the list below
    'Mark'
    , 101
),
( -- Sixth row: values for the colums in the list below
    'Greta'
    , 101
)

