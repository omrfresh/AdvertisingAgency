-- Creating the "Employees" table
CREATE TABLE Employees (
    EmployeeID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    Position NVARCHAR(50)
);

-- Creating the "Clients" table
CREATE TABLE Clients (
    ClientID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    Address NVARCHAR(200),
    PhoneNumber NVARCHAR(20)
);

-- Creating the "AdTypes" table
CREATE TABLE AdTypes (
    AdTypeID INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(50),
    Description NVARCHAR(200)
);

-- Creating the "AdditionalServices" table
CREATE TABLE AdditionalServices (
    ServiceID INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(50),
    Description NVARCHAR(200),
    Cost DECIMAL(10, 2)
);

-- Creating the "Locations" table
CREATE TABLE Locations (
    LocationID INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(50),
    LocationDescription NVARCHAR(100),
    AdTypeID INT,
    AdDescription NVARCHAR(200),
    Cost DECIMAL(10, 2),
    CONSTRAINT FK_Locations_AdTypes FOREIGN KEY (AdTypeID) REFERENCES AdTypes(AdTypeID)
);

-- Creating the "Orders" table
CREATE TABLE Orders (
    OrderID INT IDENTITY(1,1) PRIMARY KEY,
    OrderDate DATE,
    StartDate DATE,
    EndDate DATE,
    ClientID INT,
    LocationID INT,
    EmployeeID INT,
    TotalCost DECIMAL(10, 2),
    Paid BIT,
    CONSTRAINT FK_Orders_Clients FOREIGN KEY (ClientID) REFERENCES Clients(ClientID),
    CONSTRAINT FK_Orders_Locations FOREIGN KEY (LocationID) REFERENCES Locations(LocationID),
    CONSTRAINT FK_Orders_Employees FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

-- Creating the "OrderServices" table
CREATE TABLE OrderServices (
    OrderID INT,
    ServiceID INT,
    Quantity INT,
    TotalCost DECIMAL(10, 2),
    PRIMARY KEY (OrderID, ServiceID),
    CONSTRAINT FK_OrderServices_Orders FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    CONSTRAINT FK_OrderServices_AdditionalServices FOREIGN KEY (ServiceID) REFERENCES AdditionalServices(ServiceID)
);
