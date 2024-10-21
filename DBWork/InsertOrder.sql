CREATE PROCEDURE InsertOrder
    @OrderDate DATE,
    @StartDate DATE,
    @EndDate DATE,
    @ClientID INT,
    @LocationID INT,
    @EmployeeID INT,
    @TotalCost DECIMAL(10, 2),
    @Paid BIT
AS
BEGIN
    INSERT INTO Orders (OrderDate, StartDate, EndDate, ClientID, LocationID, EmployeeID, TotalCost, Paid)
    VALUES (@OrderDate, @StartDate, @EndDate, @ClientID, @LocationID, @EmployeeID, @TotalCost, @Paid);
END
