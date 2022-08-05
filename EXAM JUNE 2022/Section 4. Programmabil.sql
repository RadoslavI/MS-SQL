--11 All Volunteers in a Department
CREATE FUNCTION udf_GetVolunteersCountFromADepartment (@VolunteersDepartment VARCHAR(50))
RETURNS INT
AS
BEGIN
	DECLARE @returnvalue INT;
	
	SELECT @returnvalue = COUNT(*)
	FROM Volunteers as v
	JOIN VolunteersDepartments as vd
	ON vd.Id = v.DepartmentId
	WHERE vd.DepartmentName = @VolunteersDepartment
	
	RETURN(@returnvalue)
END

SELECT dbo.udf_GetVolunteersCountFromADepartment ('Zoo events')

--12 Animals with Owner or Not

CREATE PROC usp_AnimalsWithOwnersOrNot(@AnimalName VARCHAR(50)) 
AS
BEGIN
	
	SELECT 
	a.Name, 
	CASE
		WHEN o.Name IS NULL
			THEN 'For adoption'
		ELSE o.Name
	END as OwnersName
	FROM Owners AS o
	RIGHT JOIN Animals AS a
	ON a.OwnerId = o.Id
	WHERE a.Name = @AnimalName

END

EXEC usp_AnimalsWithOwnersOrNot 'Brown bear'