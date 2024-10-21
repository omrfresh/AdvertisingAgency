CREATE VIEW vw_NewspaperAdsCurrentMonth AS
SELECT L.LocationID, L.Name AS LocationName, L.LocationDescription, A.AdTypeID, A.Name AS AdTypeName, A.Description AS AdTypeDescription, L.Cost, O.OrderID, O.OrderDate, O.StartDate, O.EndDate, O.ClientID
FROM Locations L
JOIN AdTypes A ON L.AdTypeID = A.AdTypeID
JOIN Orders O ON L.LocationID = O.LocationID
WHERE A.Name LIKE 'Print Ad%'
AND O.OrderDate >= DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()), 0)
AND O.OrderDate < DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()) + 1, 0);
