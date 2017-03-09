-- Move data from staging tables into new tables with proper data types and constraints

use Assignment
go

-- drop tables to run full script from scratch
/*
drop table LibraryMembers
drop table Fccparks
drop table FccPlayingpitches
drop table FccSchools
drop table FccLibraries
drop table LocalAuthority

drop procedure usp_inputFccLibraries
drop procedure usp_inputFccParks
drop procedure usp_inputFccPlayingpitches
drop procedure usp_inputFccSchools
drop procedure usp_inputLibraryMembers
drop procedure usp_inputLocalAuthority
*/
-- create the tables first:

create table LocalAuthority(
	LA_ID INT PRIMARY KEY,
	Name VARCHAR(55),
	DateCreated datetime NOT NULL DEFAULT GETDATE(),
	WhoCreated VARCHAR(55) DEFAULT CURRENT_USER,
	DateUpdated datetime NOT NULL DEFAULT GETDATE(),
	WhoUpdated VARCHAR(55) DEFAULT CURRENT_USER
);
go

create table FccSchools(
	School_Roll_No VARCHAR(10) PRIMARY KEY,
	Name VARCHAR(220) NOT NULL,
	Address1 VARCHAR(55) NOT NULL,
	Address2 VARCHAR(55),
	Address3 VARCHAR(55),
	Phone VARCHAR(55),
	School_Level VARCHAR(55) NOT NULL,
	Mixed_Status VARCHAR(55) NOT NULL,
	Fee_paying VARCHAR(55),
	LA_ID INT NOT NULL,
	DateCreated datetime NOT NULL DEFAULT GETDATE(),
	WhoCreated VARCHAR(55) DEFAULT CURRENT_USER,
	DateUpdated datetime NOT NULL DEFAULT GETDATE(),
	WhoUpdated VARCHAR(55) DEFAULT CURRENT_USER,
	FOREIGN KEY (LA_ID) REFERENCES LocalAuthority(LA_ID)
);
go

create table FccLibraries(
	Library_ID INT PRIMARY KEY,
	Name VARCHAR(55) NOT NULL,
	Address1 VARCHAR(55) NOT NULL,
	Address2 VARCHAR(55),
	Address3 VARCHAR(55),
	Phone VARCHAR(55),
	Email VARCHAR(55),
	Website VARCHAR(220),
	Internet VARCHAR(25),
	WiFi VARCHAR(25),
	SelfService VARCHAR(25),
	LA_ID INT NOT NULL,
	DateCreated datetime NOT NULL DEFAULT GETDATE(),
	WhoCreated VARCHAR(55) DEFAULT CURRENT_USER,
	DateUpdated datetime NOT NULL DEFAULT GETDATE(),
	WhoUpdated VARCHAR(55) DEFAULT CURRENT_USER,
	FOREIGN KEY (LA_ID) REFERENCES LocalAuthority(LA_ID)
);
go

create table FccPlayingpitches(
	Facility_ID INT PRIMARY KEY,
	Facility_Type VARCHAR(55),
	Facility_Name VARCHAR(55),
	Area VARCHAR(55),
	LA_ID INT NOT NULL,
	DateCreated datetime NOT NULL DEFAULT GETDATE(),
	WhoCreated VARCHAR(55) DEFAULT CURRENT_USER,
	DateUpdated datetime NOT NULL DEFAULT GETDATE(),
	WhoUpdated VARCHAR(55) DEFAULT CURRENT_USER,
	FOREIGN KEY (LA_ID) REFERENCES LocalAuthority(LA_ID)
);
go

create table Fccparks(
	Park_ID INT PRIMARY KEY,
	Name VARCHAR(55) NOT NULL,
	Address1 VARCHAR(55) NOT NULL,
	Address2 VARCHAR(55),
	Address3 VARCHAR(55),
	Phone VARCHAR(55),
	Email VARCHAR(55),
	Website VARCHAR(220),
	Type VARCHAR(55),
	Parking VARCHAR(55),
	Bicyle_Parking VARCHAR(55),
	Toilets VARCHAR(55),
	LA_ID INT NOT NULL,
	DateCreated datetime NOT NULL DEFAULT GETDATE(),
	WhoCreated VARCHAR(55) DEFAULT CURRENT_USER,
	DateUpdated datetime NOT NULL DEFAULT GETDATE(),
	WhoUpdated VARCHAR(55) DEFAULT CURRENT_USER,
	FOREIGN KEY (LA_ID) REFERENCES LocalAuthority(LA_ID)
);
go

create table LibraryMembers(
	LibraryMembers_ID INT IDENTITY(1,1) PRIMARY KEY,
	Library_ID INT NOT NULL,
	Year INT NOT NULL,
	Members INT NOT NULL,
	New INT NOT NULL,
	Lost INT NOT NULL,
	DateCreated datetime NOT NULL DEFAULT GETDATE(),
	WhoCreated VARCHAR(55) DEFAULT CURRENT_USER,
	DateUpdated datetime NOT NULL DEFAULT GETDATE(),
	WhoUpdated VARCHAR(55) DEFAULT CURRENT_USER,
	FOREIGN KEY (Library_ID) REFERENCES FccLibraries(Library_ID)
);
go

-- Stored procedure to input data into LocalAuthority table
create procedure usp_inputLocalAuthority
@InputTable varchar(40),
@OutputTable varchar(40)
as
declare @sql varchar(2000)
begin try
--Dynamic sql
set @sql = 'insert into ' + @OutputTable +
	'(
		LA_ID,
		Name
		)
		select LA_ID, Name
		from ' + @InputTable
		print @sql;
		EXEC(@sql)
END TRY
BEGIN CATCH
	SELECT
		ERROR_NUMBER() AS ErrorNumber,
		ERROR_SEVERITY() AS ErrorSeverity,
		ERROR_STATE() AS ErrorState,
		ERROR_PROCEDURE() AS ErrorProcedure,
		ERROR_LINE() AS ErrorLine,
		ERROR_MESSAGE() AS ErrorMessage;
END CATCH;
go

-- Put data into LocalAuthority using stored procedure
declare @InputTable varchar(40)= 'Staging_localauthorities';
declare @OutputTable varchar(40) = 'LocalAuthority';
exec usp_inputLocalAuthority @InputTable, @OutputTable;
go

select * from LocalAuthority;
go

-- Stored procedure to input data into FccSchools table
create procedure usp_inputFccSchools
@InputTable varchar(40),
@OutputTable varchar(40)
as
declare @sql varchar(2000)
begin try
--Dynamic sql
set @sql = 'insert into ' + @OutputTable +
	'(
		School_Roll_No,
		Name,
		Address1,
		Address2,
		Address3,
		Phone,
		School_Level,
		Mixed_Status,
		Fee_paying,
		LA_ID
		)
		select School_Roll_No, Name, Address1, Address2, Address3, Phone, School_Level, Mixed_Status, Fee_paying, LA_ID
		from ' + @InputTable
		print @sql;
		EXEC(@sql)
END TRY
BEGIN CATCH
	SELECT
		ERROR_NUMBER() AS ErrorNumber,
		ERROR_SEVERITY() AS ErrorSeverity,
		ERROR_STATE() AS ErrorState,
		ERROR_PROCEDURE() AS ErrorProcedure,
		ERROR_LINE() AS ErrorLine,
		ERROR_MESSAGE() AS ErrorMessage;
END CATCH;
go

-- Put data into FccSchools using stored procedure
declare @InputTable varchar(40)= 'Staging_fccschools';
declare @OutputTable varchar(40) = 'FccSchools';
exec usp_inputFccSchools @InputTable, @OutputTable;
go

select * from FccSchools;
go

-- Stored procedure to input data into FccLibraries table
create procedure usp_inputFccLibraries
@InputTable varchar(40),
@OutputTable varchar(40)
as
declare @sql varchar(2000)
begin try
--Dynamic sql
set @sql = 'insert into ' + @OutputTable +
	'(
		Library_ID,
		Name,
		Address1,
		Address2,
		Address3,
		Phone,
		Email,
		Website,
		Internet,
		Wifi,
		Selfservice,
		LA_ID
		)
		select Library_ID, Name, Address1, Address2, Address3, Phone, Email, Website, Internet, Wifi, Selfservice, LA_ID
		from ' + @InputTable
		print @sql;
		EXEC(@sql)
END TRY
BEGIN CATCH
	SELECT
		ERROR_NUMBER() AS ErrorNumber,
		ERROR_SEVERITY() AS ErrorSeverity,
		ERROR_STATE() AS ErrorState,
		ERROR_PROCEDURE() AS ErrorProcedure,
		ERROR_LINE() AS ErrorLine,
		ERROR_MESSAGE() AS ErrorMessage;
END CATCH;
go

-- Put data into FccLibraries using stored procedure
declare @InputTable varchar(40)= 'Staging_fcclibraries';
declare @OutputTable varchar(40) = 'FccLibraries';
exec usp_inputFccLibraries @InputTable, @OutputTable;
go

select * from FccLibraries;
go

-- Stored procedure to input data into FccPlayingpitches table
create procedure usp_inputFccPlayingpitches
@InputTable varchar(40),
@OutputTable varchar(40)
as
declare @sql varchar(2000)
begin try
--Dynamic sql
set @sql = 'insert into ' + @OutputTable +
	'(
		Facility_ID,
		Facility_Type,
		Facility_Name,
		Area,
		LA_ID
		)
		select Facility_ID, Facility_Type, Facility_Name, Area, LA_ID
		from ' + @InputTable
		print @sql;
		EXEC(@sql)
END TRY
BEGIN CATCH
	SELECT
		ERROR_NUMBER() AS ErrorNumber,
		ERROR_SEVERITY() AS ErrorSeverity,
		ERROR_STATE() AS ErrorState,
		ERROR_PROCEDURE() AS ErrorProcedure,
		ERROR_LINE() AS ErrorLine,
		ERROR_MESSAGE() AS ErrorMessage;
END CATCH;
go

-- Put data into FccPlayingpitches using stored procedure
declare @InputTable varchar(40)= 'Staging_fccplayingpitches';
declare @OutputTable varchar(40) = 'FccPlayingpitches';
exec usp_inputFccPlayingpitches @InputTable, @OutputTable;
go

select * from FccPlayingpitches;
go

-- Stored procedure to input data into FccParks table
create procedure usp_inputFccParks
@InputTable varchar(40),
@OutputTable varchar(40)
as
declare @sql varchar(2000)
begin try
--Dynamic sql
set @sql = 'insert into ' + @OutputTable +
	'(
		Park_ID,
		Name,
		Address1,
		Address2,
		Address3,
		Phone,
		Email,
		Website,
		Type,
		Parking,
		Bicyle_Parking,
		Toilets,
		LA_ID
		)
		select Park_ID, Name, Address1, Address2, Address3, Phone, Email, Website, Type, Parking, Bicycle_Parking, Toilets, LA_ID
		from ' + @InputTable
		print @sql;
		EXEC(@sql)
END TRY
BEGIN CATCH
	SELECT
		ERROR_NUMBER() AS ErrorNumber,
		ERROR_SEVERITY() AS ErrorSeverity,
		ERROR_STATE() AS ErrorState,
		ERROR_PROCEDURE() AS ErrorProcedure,
		ERROR_LINE() AS ErrorLine,
		ERROR_MESSAGE() AS ErrorMessage;
END CATCH;
go

-- Put data into FccParks using stored procedure
declare @InputTable varchar(40)= 'Staging_fccparks';
declare @OutputTable varchar(40) = 'FccParks';
exec usp_inputFccParks @InputTable, @OutputTable;
go

select * from Fccparks;
go

-- Stored procedure to input data into FccStudentenrollment table
create procedure usp_inputLibraryMembers
@InputTable varchar(40),
@OutputTable varchar(40)
as
declare @sql varchar(2000)
begin try
--Dynamic sql
set @sql = 'insert into ' + @OutputTable +
	'(
		Library_ID,
		Year,
		Members,
		New,
		Lost
		)
		select Library_ID, Year, Members, New, Lost
		from ' + @InputTable
		print @sql;
		EXEC(@sql)
END TRY
BEGIN CATCH
	SELECT
		ERROR_NUMBER() AS ErrorNumber,
		ERROR_SEVERITY() AS ErrorSeverity,
		ERROR_STATE() AS ErrorState,
		ERROR_PROCEDURE() AS ErrorProcedure,
		ERROR_LINE() AS ErrorLine,
		ERROR_MESSAGE() AS ErrorMessage;
END CATCH;
go

-- Put data into LibraryMembers using stored procedure
declare @InputTable varchar(40)= 'Staging_librarymembers';
declare @OutputTable varchar(40) = 'LibraryMembers';
exec usp_inputLibraryMembers @InputTable, @OutputTable;
go

select * from LibraryMembers
go
