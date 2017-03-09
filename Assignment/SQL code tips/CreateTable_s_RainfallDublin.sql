/*
Revision History
--------------------------------------------------------------------------------------------
Database name:	RAINFALL_000_DataTakeOn
Script name:	CreateTable_s_RainfallDublin.sql
Purpose: 
Parameters: 
--------------------------------------------------------------------------------------------
Version	Author				Date			Desc
1   	Conor O'Reilly		DD/MM/YYYY      first version

--------------------------------------------------------------------------------------------
*/

USE RAINFALL_000_DataTakeOn
GO

IF EXISTS (SELECT        name, type
           FROM          RAINFALL_000_DataTakeOn.sys.sysobjects
           WHERE        (type = 'U') AND (name = N's_RainFallDublin'))
	BEGIN
		-- shouldn't drop table as then the identifier get's reset
		DROP TABLE RAINFALL_000_DataTakeOn.dbo.s_RainFallDublin;
		-- so this script is a first time only scrips, alter should be used after this
	END
GO

-- s prefix indicates that this is a staging table
-- inputs to this table come from a script that takes the data from r_rainfallDublin
-- recordStatus, 1 = active, 0 = disabled, -1 = disabled and ok to delete

CREATE TABLE RAINFALL_000_DataTakeOn.dbo.s_RainFallDublin
(
	Reading_ID					INT				IDENTITY(1000,1)	
	,r_CSO_Location_Code 		VARCHAR(5)		NULL
	,r_CSO_Location_Desc		VARCHAR(20)		NULL
	,r_Year_Month				VARCHAR(20)		NULL
	,ReadingYear				INT				NULL
	,ReadingMonth				INT				NULL
	,Total_Rainfall_mm			DECIMAL(9,2)	NULL
	,Most_Rainfall_a_Day_mm		DECIMAL(9,2)	NULL
	,Number_of_Raindays			INT				NULL
	,DateCreated				datetime		NOT NULL	DEFAULT GETDATE()
	,WhoCreated					VARCHAR(20)		NULL		DEFAULT CURRENT_USER
	,DateUpdated				datetime		NOT NULL	DEFAULT GETDATE()	
	,WhoUpdated					VARCHAR(20)		NULL		DEFAULT CURRENT_USER
	,RecordStatus				INT				NOT NULL	DEFAULT 1 CHECK ( RecordStatus >= -1 AND RecordStatus <= 1 ) 
);

GO

/*
GRANT SELECT ON r_RainFallDublin TO PUBLIC

GO
*/

