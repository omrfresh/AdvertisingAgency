DECLARE @OrderID INT = 1;
DECLARE @OrderDate DATE;
DECLARE @StartDate DATE;
DECLARE @EndDate DATE;
DECLARE @ClientID INT;
DECLARE @LocationID INT;
DECLARE @EmployeeID INT;
DECLARE @TotalCost DECIMAL(10, 2);
DECLARE @Paid BIT;

DECLARE @ClientIDs TABLE (ClientID INT);
DECLARE @LocationIDs TABLE (LocationID INT);
DECLARE @EmployeeIDs TABLE (EmployeeID INT);

-- Insert ClientIDs into the @ClientIDs table
-- Assuming that there are 250 records in the Clients table
INSERT INTO @ClientIDs (ClientID)
SELECT ClientID
FROM Clients;

-- Insert LocationIDs into the @LocationIDs table
-- Assuming that there are 250 records in the Locations table
INSERT INTO @LocationIDs (LocationID)
SELECT LocationID
FROM Locations;

-- Insert EmployeeIDs into the @EmployeeIDs table
-- Assuming that there are 250 records in the Employees table
INSERT INTO @EmployeeIDs (EmployeeID)
SELECT EmployeeID
FROM Employees;

WHILE @OrderID <= 25000
BEGIN
    -- Generate a random order date between 2022-01-01 and 2022-12-31
    SET @OrderDate = DATEADD(DAY, FLOOR(RAND() * 365), '2022-01-01');

    -- Generate a random start date between the order date and the order date plus 30 days
    SET @StartDate = DATEADD(DAY, FLOOR(RAND() * 30), @OrderDate);

    
    SET @EndDate = DATEADD(DAY, FLOOR(RAND() * 30), @StartDate);

    -- Select a random ClientID from the @ClientIDs table
    SELECT TOP 1 @ClientID = ClientID
    FROM @ClientIDs
    ORDER BY NEWID();

    -- Select a random LocationID from the @LocationIDs table
    SELECT TOP 1 @LocationID = LocationID
    FROM @LocationIDs
    ORDER BY NEWID();

    -- Select a random EmployeeID from the @EmployeeIDs table
    SELECT TOP 1 @EmployeeID = EmployeeID
    FROM @EmployeeIDs
    ORDER BY NEWID();

    -- Calculate the total cost by adding the cost of the location and the total cost of the additional services
    SELECT @TotalCost = L.Cost + ISNULL(SUM(OS.TotalCost), 0)
    FROM Locations L
    LEFT JOIN OrderServices OS ON L.LocationID = OS.OrderID
    WHERE L.LocationID = @LocationID
    GROUP BY L.LocationID, L.Cost;

    -- Generate a random paid value (0 or 1)
    SET @Paid = FLOOR(RAND() * 2);

    -- Insert the random record into the Orders table
    INSERT INTO Orders (OrderDate, StartDate, EndDate, ClientID, LocationID, EmployeeID, TotalCost, Paid)
    VALUES (@OrderDate, @StartDate, @EndDate, @ClientID, @LocationID, @EmployeeID, @TotalCost, @Paid);

    -- Increment the OrderID for the next record
    SET @OrderID = @OrderID + 1;
END
