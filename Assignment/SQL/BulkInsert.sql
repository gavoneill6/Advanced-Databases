-- Bulk insert from csv files to staging tables
create database Assignment;
go
use Assignment;
go

-- drop tables to run full script from scratch
/*
drop table Staging_fcclibraries
drop table Staging_fccparks
drop table Staging_fccplayingpitches
drop table Staging_fccschools
drop table Staging_librarymembers
drop table Staging_localauthorities
*/

-- create the raw staging tables

create table Staging_fccschools(
	School_Roll_No VARCHAR(55) NULL,
	Name VARCHAR(220) NULL,
	Address1 VARCHAR(55) NULL,
	Address2 VARCHAR(55) NULL,
	Address3 VARCHAR(55) NULL,
	Phone VARCHAR(55) NULL,
	School_Level VARCHAR(55) NULL,
	Mixed_Status VARCHAR(55) NULL,
	Fee_paying VARCHAR(55) NULL,
	LA_ID VARCHAR(55) NULL
);
go


create table Staging_fcclibraries(
	Library_ID VARCHAR(55) NULL,
	Name VARCHAR(55) NULL,
	Address1 VARCHAR(55) NULL,
	Address2 VARCHAR(55) NULL,
	Address3 VARCHAR(55) NULL,
	Phone VARCHAR(55) NULL,
	Email VARCHAR(55) NULL,
	Website VARCHAR(220) NULL,
	Internet VARCHAR(55) NULL,
	WiFi VARCHAR(55) NULL,
	SelfService VARCHAR(55) NULL,
	LA_ID VARCHAR(55) NULL
);
go

create table Staging_fccplayingpitches(
	Facility_ID VARCHAR(55) NULL,
	Facility_Type VARCHAR(55) NULL,
	Facility_Name VARCHAR(55) NULL,
	Area VARCHAR(55) NULL,
	LA_ID VARCHAR(55) NULL
);
go

create table Staging_fccparks(
	Park_ID VARCHAR(55) NULL,
	Name VARCHAR(55) NULL,
	Address1 VARCHAR(55) NULL,
	Address2 VARCHAR(55) NULL,
	Address3 VARCHAR(55) NULL,
	Phone VARCHAR(55) NULL,
	Email VARCHAR(55) NULL,
	Website VARCHAR(220) NULL,
	Type VARCHAR(55) NULL,
	Parking VARCHAR(55) NULL,
	Bicycle_Parking VARCHAR(55) NULL,
	Toilets VARCHAR(55) NULL,
	LA_ID VARCHAR(55) NULL
);
go

create table Staging_librarymembers(
	Library_ID VARCHAR(55) NULL,
	Year VARCHAR(55) NULL,
	Members VARCHAR(55) NULL,
	New VARCHAR(55) NULL,
	Lost VARCHAR(55) NULL,
);
go

create table Staging_localauthorities(
	LA_ID VARCHAR(10) NULL,
	Name VARCHAR(55) NULL
);
go

-- create stored procedure for uploading data from files

create procedure usp_LoadFile
@FileName VARCHAR(200), 
@TableName VARCHAR(50),
@ErrorFile VARCHAR(200)
as
BEGIN TRY
DECLARE @sql nvarchar(4000)

--bulk insert into the initial staging table
SET @sql = 'BULK INSERT ' + @TableName + '
FROM '''+ @FileName + '''
WITH
(
FIELDTERMINATOR = '','',
ROWTERMINATOR = ''\n'',
FIRSTROW=2,
TABLOCK ,
MAXERRORS = 10,
ERRORFILE = ''' + @ErrorFile + ''')'

--run dynamic sql statement to insert into staging table
EXEC(@sql)

--ERROR HANDLING
END TRY
BEGIN CATCH
SELECT
	ERROR_NUMBER() AS ErrorNumber,
	ERROR_SEVERITY() AS ErrorSeverity,
	ERROR_STATE() AS ErrorState,
	ERROR_PROCEDURE() AS ErrorProcedure,
	ERROR_LINE() AS ErrorLine,
	ERROR_MESSAGE() AS ErrorMessage;
END CATCH
go

-- try out stored procedure. Be aware of changing the file path if required
declare @TheTable varchar(50)= 'Staging_fccschools';
declare @TheFile varchar(100) = 'C:\Users\User\Documents\DT265\Advanced Databases\Assignment\fccschools.csv';
declare @AnyErrors varchar(100) = 'C:\Users\User\Errors_Assignment_fccschools.log';
exec usp_LoadInputFile @TheFile, @TheTable, @AnyErrors;
go

-- test it to make sure info is in
select * from Staging_fccschools;
go

--try out stored procedure.Be aware of changing the file path if required
declare @TheTable varchar(50)= 'Staging_fcclibraries';
declare @TheFile varchar(100) = 'C:\Users\User\Documents\DT265\Advanced Databases\Assignment\fcclibraries.csv';
declare @AnyErrors varchar(100) = 'C:\Users\User\Errors_Assignment_fcclibraries.log';
exec usp_LoadInputFile @TheFile, @TheTable, @AnyErrors;
go

-- test it to make sure info is in
select * from Staging_fcclibraries;
go

-- try out stored procedure. Be aware of changing the file path if required
declare @TheTable varchar(50)= 'Staging_fccplayingpitches';
declare @TheFile varchar(100) = 'C:\Users\User\Documents\DT265\Advanced Databases\Assignment\fccplayingpitches.csv';
declare @AnyErrors varchar(100) = 'C:\Users\User\Errors_Assignment_fccplayingpitches.log';
exec usp_LoadInputFile @TheFile, @TheTable, @AnyErrors;
go

-- test it to make sure info is in
select * from Staging_fccplayingpitches;
go

-- try out stored procedure. Be aware of changing the file path if required
declare @TheTable varchar(50)= 'Staging_fccparks';
declare @TheFile varchar(100) = 'C:\Users\User\Documents\DT265\Advanced Databases\Assignment\fccparks.csv';
declare @AnyErrors varchar(100) = 'C:\Users\User\Errors_Assignment_fccparks.log';
exec usp_LoadInputFile @TheFile, @TheTable, @AnyErrors;
go

-- test it to make sure info is in
select * from Staging_fccparks;
go

-- try stored procedure. Be aware of changing the file path if required
declare @TheTable varchar(50)= 'Staging_librarymembers';
declare @TheFile varchar(100) = 'C:\Users\User\Documents\DT265\Advanced Databases\Assignment\librarymembers.csv';
declare @AnyErrors varchar(100) = 'C:\Users\User\Errors_Assignment_librarymembers.log';
exec usp_LoadInputFile @TheFile, @TheTable, @AnyErrors;
go

-- test it to make sure info is in
select * from Staging_librarymembers;
go

-- try out stored procedure. Be aware of changing the file path if required
declare @TheTable varchar(50)= 'Staging_localauthorities';
declare @TheFile varchar(100) = 'C:\Users\User\Documents\DT265\Advanced Databases\Assignment\dublinlocalauthorities.csv';
declare @AnyErrors varchar(100) = 'C:\Users\User\Errors_Assignment_localauthorities.log';
exec usp_LoadInputFile @TheFile, @TheTable, @AnyErrors;
go

-- test it to make sure info is in
select * from Staging_localauthorities;
go