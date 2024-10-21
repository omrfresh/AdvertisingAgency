DECLARE @EmployeeID INT = 1;
DECLARE @FirstName NVARCHAR(50);
DECLARE @LastName NVARCHAR(50);
DECLARE @Position NVARCHAR(50);

DECLARE @FirstNames TABLE (FirstName NVARCHAR(50));
DECLARE @LastNames TABLE (LastName NVARCHAR(50));
DECLARE @Positions TABLE (Position NVARCHAR(50));

-- Insert first names into the @FirstNames table
INSERT INTO @FirstNames (FirstName)
VALUES
('John'),
('Jane'),
('Michael'),
('Emily'),
('Daniel'),
('Olivia'),
('Matthew'),
('Sophia'),
('Andrew'),
('Emma');

-- Insert last names into the @LastNames table
INSERT INTO @LastNames (LastName)
VALUES
('Doe'),
('Smith'),
('Johnson'),
('Williams'),
('Brown'),
('Jones'),
('Miller'),
('Davis'),
('Garcia'),
('Rodriguez');

-- Insert positions into the @Positions table
INSERT INTO @Positions (Position)
VALUES
('Sales Representative'),
('Account Manager'),
('Marketing Specialist'),
('Graphic Designer'),
('Content Writer'),
('SEO Specialist'),
('PPC Manager'),
('Social Media Manager'),
('Email Marketing Specialist'),
('Customer Service Representative');

WHILE @EmployeeID <= 250
BEGIN
    -- Select a random first name from the @FirstNames table
    SELECT TOP 1 @FirstName = FirstName
    FROM @FirstNames
    ORDER BY NEWID();

    -- Select a random last name from the @LastNames table
    SELECT TOP 1 @LastName = LastName
    FROM @LastNames
    ORDER BY NEWID();

    -- Select a random position from the @Positions table
    SELECT TOP 1 @Position = Position
    FROM @Positions
    ORDER BY NEWID();

    -- Insert the random record into the Employees table
    INSERT INTO Employees (FirstName, LastName, Position)
    VALUES (@FirstName, @LastName, @Position);

    -- Increment the EmployeeID for the next record
    SET @EmployeeID = @EmployeeID + 1;
END
