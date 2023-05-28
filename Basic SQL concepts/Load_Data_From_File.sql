-- Create a new table to hold the data

/****** Object:  Table [dbo].[university_professors]    Script Date: 5/28/2023 2:25:35 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[university_professors]') AND type in (N'U'))
DROP TABLE [dbo].[university_professors]
GO


CREATE TABLE university_professors (
    firstname VARCHAR(100),
    lastname VARCHAR(100),
    university VARCHAR(100),
    university_shortname VARCHAR(50),
    university_city VARCHAR(100),
    [function] VARCHAR(MAX),
    organization VARCHAR(MAX),
    organization_sector VARCHAR(100)
);

-- Use BULK INSERT to load data from the Excel file into the table
BULK INSERT university_professors
FROM 'C:\Path\To\Your\Excel\File.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK
);
