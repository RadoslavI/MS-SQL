DROP TABLE IF EXISTS Students

CREATE TABLE Students
(
	StudentID INT IDENTITY PRIMARY KEY,
	[Name] VARCHAR(5) NOT NULL
)


DROP TABLE IF EXISTS Exams

CREATE TABLE Exams
(
	ExamID INT IDENTITY(101, 1) PRIMARY KEY,
	[Name] VARCHAR(15) NOT NULL
)

DROP TABLE IF EXISTS StudentsExams

CREATE TABLE StudentsExams
(
	StudentID INT FOREIGN KEY REFERENCES Students(StudentID),
	ExamID INT FOREIGN KEY REFERENCES Exams(ExamID),
	PRIMARY KEY(StudentID, ExamID)
)


INSERT INTO [dbo].[Students]
( -- Columns to insert data into
    [Name]
)
VALUES
( -- First row: values for the columns in the list below
    'Mila'
),
( -- Second row: values for the columns in the list below
    'Toni'
),
( -- Third row: values for the colums in the list below
    'Ron'
)

INSERT INTO [dbo].[Exams]
( -- Columns to insert data into
    [Name]
)
VALUES
( -- First row: values for the columns in the list below
    'SpringMVC'
),
( -- Second row: values for the columns in the list below
    'Neo4j'
),
( -- Third row: values for the colums in the list below
    'Oracle 11g'
)

INSERT INTO [dbo].[StudentsExams]
( -- Columns to insert data into
    [StudentID]
    , [ExamID]
)
VALUES
( -- First row: values for the columns in the list below
    1
    , 101
),
( -- Second row: values for the columns in the list below
    1
    , 102
),
( -- Third row: values for the colums in the list below
    2
    , 101
),
( -- Fourth row: values for the colums in the list below
    3
    , 103
),
( -- Fifth row: values for the colums in the list below
    2
    , 102
),
( -- Sixth row: values for the colums in the list below
    2
    , 103
)