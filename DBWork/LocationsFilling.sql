DECLARE @LocationID INT = 1;
DECLARE @Name NVARCHAR(50);
DECLARE @LocationDescription NVARCHAR(100);
DECLARE @AdTypeID INT;
DECLARE @AdDescription NVARCHAR(200);
DECLARE @Cost DECIMAL(10, 2);

DECLARE @Locations TABLE (Name NVARCHAR(50));
DECLARE @LocationDescriptions TABLE (Description NVARCHAR(100));

-- Insert locations into the @Locations table
INSERT INTO @Locations (Name)
VALUES
('Times Square'),
('Central Park'),
('Empire State Building'),
('Statue of Liberty'),
('Brooklyn Bridge'),
('Central Station'),
('Airport'),
('Mall'),
('Shopping Center'),
('Cinema'),
('Theater'),
('Convention Center'),
('Stadium'),
('Park'),
('Beach');

-- Insert location descriptions into the @LocationDescriptions table
INSERT INTO @LocationDescriptions (Description)
VALUES
('High-traffic area with high visibility.'),
('Popular tourist destination with many visitors.'),
('Iconic landmark with a large number of visitors.'),
('Historic monument with a significant number of tourists.'),
('Popular destination for pedestrians and cyclists.'),
('Busy transportation hub with many passengers.'),
('Area with high foot traffic and visibility.'),
('Shopping destination with many visitors.'),
('Retail center with a large number of stores.'),
('Entertainment venue with regular shows and events.'),
('Performing arts venue with a variety of shows.'),
('Venue for conventions, exhibitions, and events.'),
('Sports venue with regular events and games.'),
('Outdoor space with beautiful scenery and amenities.'),
('Popular destination for swimming, sunbathing, and other activities.');

WHILE @LocationID <= 2500
BEGIN
    -- Select a random location from the @Locations table
    SELECT TOP 1 @Name = Name
    FROM @Locations
    ORDER BY NEWID();

    -- Select a random location description from the @LocationDescriptions table
    SELECT TOP 1 @LocationDescription = Description
    FROM @LocationDescriptions
    ORDER BY NEWID();

    -- Select a random AdTypeID and AdDescription from the AdTypes table
    SELECT TOP 1 @AdTypeID = AdTypeID, @AdDescription = Description
    FROM AdTypes
    ORDER BY NEWID();

    -- Generate a random cost between 100 and 1000
    SET @Cost = RAND() * 900 + 100;

    -- Append a random number to the Name column
    SET @Name = @Name + ' ' + CAST(FLOOR(RAND() * 1000) AS NVARCHAR(10));

    -- Insert the random record into the Locations table
    INSERT INTO Locations (Name, LocationDescription, AdTypeID, AdDescription, Cost)
    VALUES (@Name, @LocationDescription, @AdTypeID, @AdDescription, @Cost);

    -- Increment the LocationID for the next record
    SET @LocationID = @LocationID + 1;
END
