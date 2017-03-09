/*
Revision History
--------------------------------------------------------------------------------------------
Database name:	RAINFALL_000_DataTakeOn.
Script name:	CreateTable_r_RainfallDublin.sql
Purpose: 
Parameters: 
--------------------------------------------------------------------------------------------
Version	Author				Date			Desc
1   	Conor O'Reilly		DD/MM/YYYY      first version

--------------------------------------------------------------------------------------------
*/

USE RAINFALL_000_DataTakeOn
GO

-- creating a new table as this in an import of just this data,
-- any previous table should be removed.
-- note the explicit use of the database name . schema . table : 
-- RAINFALL_000_DataTakeOn.sys.sysobjects and RAINFALL_000_DataTakeOn.dbo.r_RainFallDublin

IF EXISTS (SELECT        name, type
           FROM          RAINFALL_000_DataTakeOn.sys.sysobjects
           WHERE        (type = 'U') AND (name = N'r_RainFallDublin'))
	BEGIN
		DROP TABLE RAINFALL_000_DataTakeOn.dbo.r_RainFallDublin;
	END
GO

-- r prefix indicates that this is a raw table
-- inputs are taken as text so we can get as many as possible into the database
-- bulk insert takes the columns in the CSV file and copies into the defined columns here
-- if you try and add extra columns then

CREATE TABLE RAINFALL_000_DataTakeOn.dbo.r_RainFallDublin
(
	Location_Code 								VARCHAR(5)			NULL
	,Location									VARCHAR(20)			NULL
	,Year_Month									VARCHAR(20)			NULL
	,Total_Rainfall_Millimetres					VARCHAR(10)			NULL
	,Most_Rainfall_in_a_Day_Millimetres			VARCHAR(10)			NULL
	,Number_of_Raindays							VARCHAR(10)			NULL
);

GO

/*
GRANT SELECT ON r_RainFallDublin TO PUBLIC

GO
*/

