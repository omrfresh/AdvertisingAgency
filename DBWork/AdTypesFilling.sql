DECLARE @AdTypeID INT = 1;
DECLARE @Name NVARCHAR(50);
DECLARE @Description NVARCHAR(200);

DECLARE @Names TABLE (Name NVARCHAR(50));
DECLARE @Descriptions TABLE (Description NVARCHAR(200));

-- Insert ad types into the @Names table
INSERT INTO @Names (Name)
VALUES
('Print Ad'),
('Online Ad'),
('TV Ad'),
('Radio Ad'),
('Outdoor Ad'),
('Billboards'),
('Transit Ad'),
('Mobile Ad'),
('Social Media Ad'),
('Email Marketing'),
('SEO'),
('PPC'),
('Content Marketing'),
('Influencer Marketing'),
('Event Marketing'),
('Affiliate Marketing'),
('Referral Marketing'),
('Loyalty Programs'),
('Coupon Marketing'),
('Direct Mail'),
('Telemarketing'),
('SMS Marketing'),
('Video Ad'),
('Native Ad'),
('Display Ad');

-- Insert descriptions into the @Descriptions table
INSERT INTO @Descriptions (Description)
VALUES
('Traditional print advertisements in magazines, newspapers, or brochures.'),
('Digital advertisements displayed on websites or social media platforms.'),
('Commercials aired on television during programs or breaks.'),
('Advertisements broadcast on the radio.'),
('Outdoor advertisements such as billboards, posters, or signs.'),
('Large advertisements displayed on the sides of buses, trains, or trams.'),
('Advertisements displayed on mobile devices such as smartphones or tablets.'),
('Advertisements that appear in email messages.'),
('The practice of optimizing a website to increase its visibility in search engine results.'),
('Pay-per-click advertising, where advertisers pay a fee each time their ad is clicked.'),
('Creating and distributing valuable, relevant, and consistent content to attract and engage a target audience.'),
('Partnering with influencers to promote products or services.'),
('Promoting events, conferences, or exhibitions to generate leads and increase brand awareness.'),
('A marketing strategy that involves earning commissions by promoting other peoples products.'),
('A marketing strategy that involves encouraging customers to refer new business to the company.'),
('Programs that reward customers for their loyalty and repeat business.'),
('Promoting discounts or special offers to customers through coupons or promotional codes.'),
('Sending physical mail to promote products or services.'),
('Making sales calls to potential customers over the phone.'),
('Sending text messages to promote products or services.'),
('Advertisements that use video to engage and inform the audience.'),
('Advertisements that blend seamlessly into the content of a website or app.'),
('Advertisements that are displayed on a webpage or app and can be customized to match the content and design of the site.'),
('Advertisements that appear in search engine results.');

WHILE @AdTypeID <= 250
BEGIN
    -- Select a random ad type from the @Names table
    SELECT TOP 1 @Name = Name
    FROM @Names
    ORDER BY NEWID();

    -- Select a random description from the @Descriptions table
    SELECT TOP 1 @Description = Description
    FROM @Descriptions
    ORDER BY NEWID();

    -- Append a random number to the Name column
    SET @Name = @Name + ' ' + CAST(FLOOR(RAND() * 1000) AS NVARCHAR(10));

    -- Insert the random record into the AdTypes table
    INSERT INTO AdTypes (Name, Description)
    VALUES (@Name, @Description);

    -- Increment the AdTypeID for the next record
    SET @AdTypeID = @AdTypeID + 1;
END
