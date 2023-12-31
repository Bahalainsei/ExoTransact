USE BLOGS
IF OBJECT_ID('TempDB.dbo.#Duplicates') IS NOT NULL
DROP TABLE #Duplicates

CREATE TABLE #Duplicates(
	[Fact_Date] [date] NULL,
	[FirstName] [varchar](30) NULL,
	[LastName] [varchar](50) NULL,
	[AddressLine1] [varchar](50) NULL,
	[City] [varchar](20) NULL,
	[State] [varchar](50) NULL)

INSERT INTO #Duplicates (Fact_Date, FirstName, LastName, AddressLine1, City, State)
	VALUES	('2015-04-15',	'Mitchell', 'Pearson', '400 College Drive', 'Middleburg', 'Florida'),
			('2015-04-15',	'Mitchell', 'Pearson', '400 College Drive', 'Middleburg', 'Florida'),
			('2015-04-15',	'Mitchell', 'Pearson', '400 College Drive', 'Middleburg', 'Florida'),
			('2015-04-15',	'Devin', 'Knight', '1 Smelly Lane', 'Orange Park', 'Florida'),
			('2015-04-15',	'Devin', 'Knight', '1 Smelly Lane', 'Orange Park', 'Florida')

 SELECT * FROM #Duplicates;


WITH RemoveDuplicates
AS 
(
	SELECT 
		Fact_Date, FirstName, LastName, AddressLine1, City, State,
		ROW_NUMBER() OVER (PARTITION BY Fact_Date, FirstName, LastName, AddressLine1, City, State ORDER BY Fact_Date) RN
	FROM #Duplicates
)
--SELECT * FROM RemoveDuplicates

-- SELECT * FROM #Duplicates

DELETE FROM RemoveDuplicates WHERE RN <> 1