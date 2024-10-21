CREATE PROCEDURE InsertEmployee
    @FirstName NVARCHAR(50),
    @LastName NVARCHAR(50),
    @Position NVARCHAR(50)
AS
BEGIN
    INSERT INTO Employees (FirstName, LastName, Position)
    VALUES (@FirstName, @LastName, @Position);
END
