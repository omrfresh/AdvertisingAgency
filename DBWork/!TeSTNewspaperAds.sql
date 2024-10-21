CREATE VIEW NewspaperAds AS
SELECT L.LocationID, L.Name AS LocationName, L.LocationDescription, A.AdTypeID, A.Name AS AdTypeName, A.Description AS AdTypeDescription, L.Cost, O.OrderID, O.OrderDate, O.StartDate, O.EndDate, O.ClientID
FROM Locations L
JOIN AdTypes A ON L.AdTypeID = A.AdTypeID
JOIN Orders O ON L.LocationID = O.LocationID
WHERE A.Name = 'Print Ad';
