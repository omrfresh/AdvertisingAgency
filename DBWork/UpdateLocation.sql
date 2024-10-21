CREATE PROCEDURE UpdateLocation
    @LocationID INT,
    @Name NVARCHAR(50),
    @LocationDescription NVARCHAR(100),
    @AdTypeID INT,
    @AdDescription NVARCHAR(200),
    @Cost DECIMAL(10, 2)
AS
BEGIN
    UPDATE Locations
    SET Name = @Name,
        LocationDescription = @LocationDescription,
        AdTypeID = @AdTypeID,
        AdDescription = @AdDescription,
        Cost = @Cost
    WHERE LocationID = @LocationID;
END
