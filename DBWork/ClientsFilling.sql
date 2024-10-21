DECLARE @ClientID INT = 1;
DECLARE @FirstName NVARCHAR(50);
DECLARE @LastName NVARCHAR(50);
DECLARE @Address NVARCHAR(200);
DECLARE @PhoneNumber NVARCHAR(20);

DECLARE @FirstNames TABLE (FirstName NVARCHAR(50));
DECLARE @LastNames TABLE (LastName NVARCHAR(50));
DECLARE @Addresses TABLE (Address NVARCHAR(200));

-- Insert first names into the @FirstNames table
INSERT INTO @FirstNames (FirstName)
VALUES
('John'),
('Jane'),
('Michael'),
('Emily'),
('David'),
('Sarah'),
('Daniel'),
('Olivia'),
('Matthew'),
('Emma'),
('Andrew'),
('Sophia'),
('Joshua'),
('Isabella'),
('Christopher'),
('Mia'),
('Samuel'),
('Charlotte'),
('Anthony'),
('Amelia'),
('William'),
('Harper'),
('Joseph'),
('Evelyn'),
('Ryan');

-- Insert last names into the @LastNames table
INSERT INTO @LastNames (LastName)
VALUES
('Smith'),
('Johnson'),
('Williams'),
('Brown'),
('Jones'),
('Miller'),
('Davis'),
('Garcia'),
('Rodriguez'),
('Wilson'),
('Martinez'),
('Anderson'),
('Taylor'),
('Thomas'),
('Hernandez'),
('Moore'),
('Martin'),
('Jackson'),
('Thompson'),
('White'),
('Lopez'),
('Lee'),
('Gonzalez'),
('Harris'),
('Clark');

-- Insert addresses into the @Addresses table
INSERT INTO @Addresses (Address)
VALUES
('123 Main St, Anytown, USA'),
('456 Elm St, Anytown, USA'),
('789 Oak St, Anytown, USA'),
('101 Pine St, Anytown, USA'),
('202 Cedar St, Anytown, USA'),
('303 Maple St, Anytown, USA'),
('404 Birch St, Anytown, USA'),
('505 Walnut St, Anytown, USA'),
('606 Spruce St, Anytown, USA'),
('707 Cherry St, Anytown, USA'),
('808 Willow St, Anytown, USA'),
('909 Hemlock St, Anytown, USA'),
('1111 Oakwood Dr, Anytown, USA'),
('2222 Birchwood Dr, Anytown, USA'),
('3333 Maplewood Dr, Anytown, USA'),
('4444 Cedarwood Dr, Anytown, USA'),
('5555 Pinewood Dr, Anytown, USA'),
('6666 Sprucewood Dr, Anytown, USA'),
('7777 Walnutwood Dr, Anytown, USA'),
('8888 Hemlockwood Dr, Anytown, USA'),
('9999 Willowwood Dr, Anytown, USA'),
('11111 Elmwood Dr, Anytown, USA'),
('22222 Oakwood Ave, Anytown, USA'),
('33333 Birchwood Ave, Anytown, USA'),
('44444 Maplewood Ave, Anytown, USA');

WHILE @ClientID <= 250
BEGIN
    -- Select a random first name from the @FirstNames table
    SELECT TOP 1 @FirstName = FirstName
    FROM @FirstNames
    ORDER BY NEWID();

    -- Select a random last name from the @LastNames table
    SELECT TOP 1 @LastName = LastName
    FROM @LastNames
    ORDER BY NEWID();

    -- Select a random address from the @Addresses table
    SELECT TOP 1 @Address = Address
    FROM @Addresses
    ORDER BY NEWID();

    -- Generate a random phone number
    SET @PhoneNumber = '(' + CAST(FLOOR(RAND() * 9) + 1 AS NVARCHAR(1)) + CAST(FLOOR(RAND() * 900) + 100 AS NVARCHAR(3)) + ')' + CAST(FLOOR(RAND() * 900) + 100 AS NVARCHAR(3)) + '-' + CAST(FLOOR(RAND() * 9000) + 1000 AS NVARCHAR(4));

    -- Insert the random record into the Clients table
    INSERT INTO Clients (FirstName, LastName, Address, PhoneNumber)
    VALUES (@FirstName, @LastName, @Address, @PhoneNumber);

    -- Increment the ClientID for the next record
    SET @ClientID = @ClientID + 1;
END
