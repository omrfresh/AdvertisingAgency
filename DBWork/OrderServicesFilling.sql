DECLARE @OrderID INT;
DECLARE @ServiceID INT;
DECLARE @Quantity INT;
DECLARE @TotalCost DECIMAL(10, 2);

DECLARE @OrderIDs TABLE (OrderID INT);
DECLARE @ServiceIDs TABLE (ServiceID INT);

-- Insert OrderIDs into the @OrderIDs table
-- Assuming that there are 250 records in the Orders table
INSERT INTO @OrderIDs (OrderID)
SELECT OrderID
FROM Orders;

-- Insert ServiceIDs into the @ServiceIDs table
-- Assuming that there are 250 records in the AdditionalServices table
INSERT INTO @ServiceIDs (ServiceID)
SELECT ServiceID
FROM AdditionalServices;

WHILE (SELECT COUNT(*) FROM OrderServices) < 250
BEGIN
    -- Select a random OrderID from the @OrderIDs table
    SELECT TOP 1 @OrderID = OrderID
    FROM @OrderIDs
    ORDER BY NEWID();

    -- Select a random ServiceID from the @ServiceIDs table
    SELECT TOP 1 @ServiceID = ServiceID
    FROM @ServiceIDs
    ORDER BY NEWID();

    -- Generate a random quantity between 1 and 10
    SET @Quantity = FLOOR(RAND() * 10) + 1;

    -- Calculate the total cost by multiplying the quantity by the cost of the service
    SELECT @TotalCost = @Quantity * Cost
    FROM AdditionalServices
    WHERE ServiceID = @ServiceID;

    -- Check if the combination of OrderID and ServiceID already exists in the OrderServices table
    IF NOT EXISTS (SELECT 1 FROM OrderServices WHERE OrderID = @OrderID AND ServiceID = @ServiceID)
    BEGIN
        -- Insert the random record into the OrderServices table
        INSERT INTO OrderServices (OrderID, ServiceID, Quantity, TotalCost)
        VALUES (@OrderID, @ServiceID, @Quantity, @TotalCost);
    END
END
