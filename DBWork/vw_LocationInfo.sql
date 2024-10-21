CREATE VIEW vw_LocationInfo AS
SELECT L.LocationID, L.Name AS LocationName, L.LocationDescription, A.AdTypeID, A.Name AS AdTypeName, A.Description AS AdTypeDescription, L.Cost
FROM Locations L
JOIN AdTypes A ON L.AdTypeID = A.AdTypeID;