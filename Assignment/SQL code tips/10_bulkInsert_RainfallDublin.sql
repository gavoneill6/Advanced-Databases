 /*
Revision History
--------------------------------------------------------------------------------------------
Script name: RAINFALL_000_DataTakeOn.10_bulkInsert_RainfallDublin
Purpose: 
Parameters: 
Reference : http://www.simple-talk.com/sql/learn-sql-server/bulk-inserts-via-tsql-in-sql-server/
--------------------------------------------------------------------------------------------
Version	Author				Date			Desc
1   	Conor O'Reilly		DD/MM/YYYY      first version

--------------------------------------------------------------------------------------------
*/


USE RAINFALL_000_DataTakeOn
GO

BEGIN TRY

DECLARE @sql nvarchar(4000)
DECLARE @tablename nvarchar(500)
DECLARE @csvFilename nvarchar(500)
DECLARE @errorFilename nvarchar(500)
DECLARE @linecount int

SET @tablename = 'RAINFALL_000_DataTakeOn.dbo.r_RainFallDublin'
SET @csvFilename = 'C:\_DATA\RAINFALL_v2\100_DATA_IN\RainFall_DublinAirport_1958-2012.csv'
SET @errorFilename = 'C:\_DATA\RAINFALL_v2\150_ERROR_LOG\RainFall_DublinAirport_1958-2012.log'


-- bulk insert into temp table
-- cannot use variable path with bulk insert
-- so we must run using dynamic sql


SET @sql = 'BULK INSERT ' + @tablename + '
FROM '''+ @csvFilename + '''
WITH
(
FIELDTERMINATOR = '',''
,ROWTERMINATOR = ''\n''
,FIRSTROW=2
,TABLOCK 
,MAXERRORS = 10
,ERRORFILE = ''' + @errorFilename + ''')'

-- run dynamic statement to populate temp table
EXEC(@sql)

-- ERROR HANDLING
END TRY

BEGIN CATCH

SELECT
ERROR_NUMBER() AS ErrorNumber
,ERROR_SEVERITY() AS ErrorSeverity
,ERROR_STATE() AS ErrorState
,ERROR_PROCEDURE() AS ErrorProcedure
,ERROR_LINE() AS ErrorLine
,ERROR_MESSAGE() AS ErrorMessage;

END CATCH
