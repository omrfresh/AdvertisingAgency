CREATE VIEW vw_UnpaidOrdersEmployees AS
SELECT E.EmployeeID, E.FirstName, E.LastName, E.Position, O.OrderID, O.OrderDate, O.StartDate, O.EndDate, O.ClientID, O.LocationID, O.TotalCost
FROM Employees E
JOIN Orders O ON E.EmployeeID = O.EmployeeID
WHERE O.Paid = 0;