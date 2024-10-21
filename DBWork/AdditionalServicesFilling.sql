DECLARE @ServiceID INT = 1;
DECLARE @Name NVARCHAR(50);
DECLARE @Description NVARCHAR(200);
DECLARE @Cost DECIMAL(10, 2);

DECLARE @Names TABLE (Name NVARCHAR(50));
DECLARE @Descriptions TABLE (Description NVARCHAR(200));

-- Insert service names into the @Names table
INSERT INTO @Names (Name)
VALUES
('Web Design'),
('Graphic Design'),
('Copywriting'),
('Social Media Management'),
('SEO Optimization'),
('PPC Management'),
('Email Marketing'),
('Content Creation'),
('Video Production'),
('Photography'),
('Branding'),
('Event Planning'),
('Public Relations'),
('Market Research'),
('Data Analysis'),
('Analytics'),
('CRM Implementation'),
('Customer Support'),
('Training and Development'),
('Consulting'),
('Legal Services'),
('Accounting Services'),
('Financial Planning'),
('Investment Services'),
('Insurance Services');

-- Insert descriptions into the @Descriptions table
INSERT INTO @Descriptions (Description)
VALUES
('Creating visually appealing and user-friendly websites.'),
('Designing graphics for print and digital media.'),
('Writing compelling and persuasive copy for marketing materials.'),
('Managing social media accounts and creating engaging content.'),
('Optimizing websites to improve search engine rankings.'),
('Managing pay-per-click campaigns to drive traffic to websites.'),
('Creating and sending targeted email campaigns to promote products or services.'),
('Creating valuable and relevant content to attract and engage a target audience.'),
('Producing high-quality videos for marketing and promotional purposes.'),
('Taking professional photographs for marketing materials and websites.'),
('Developing a unique brand identity and messaging.'),
('Planning and executing events to promote products or services.'),
('Managing relationships with the media and creating press releases.'),
('Researching market trends and consumer behavior.'),
('Analyzing data to identify patterns and insights.'),
('Tracking and analyzing website traffic and user behavior.'),
('Implementing a customer relationship management system to improve customer service.'),
('Providing customer support through various channels, such as email, phone, or chat.'),
('Developing and delivering training programs to improve employee skills and knowledge.'),
('Providing expert advice and guidance on a range of business topics.'),
('Providing legal services to protect the interests of the business.'),
('Managing financial records and preparing financial reports.'),
('Providing financial planning and investment advice to help clients achieve their financial goals.'),
('Providing insurance coverage to protect against risks and liabilities.'),
('Providing accounting services to manage financial transactions and ensure compliance with regulations.');

WHILE @ServiceID <= 250
BEGIN
    -- Select a random service name from the @Names table
    SELECT TOP 1 @Name = Name
    FROM @Names
    ORDER BY NEWID();

    -- Select a random description from the @Descriptions table
    SELECT TOP 1 @Description = Description
    FROM @Descriptions
    ORDER BY NEWID();

    -- Generate a random cost between 100 and 1000
    SET @Cost = RAND() * 900 + 100;

    -- Insert the random record into the AdditionalServices table
    INSERT INTO AdditionalServices (Name, Description, Cost)
    VALUES (@Name, @Description, @Cost);

    -- Increment the ServiceID for the next record
    SET @ServiceID = @ServiceID + 1;
END
