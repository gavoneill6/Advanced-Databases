-- create relational database and take data from the last stage

create database relational_amenities
go
use relational_amenities
go

-- drop tables to run full script from scratch
/*
drop table SchoolAddress
drop table LibraryMembers
drop table Fccparks
drop table FccPlayingpitches
drop table FccSchools
drop table ContactInfo
drop table LibraryMembers
drop table FccLibraries
drop table LocalAuthority

drop procedure usp_loadContactInfo
drop procedure usp_loadFccLibraries
drop procedure usp_loadFccParks
drop procedure usp_loadFccPlayingpitches
drop procedure usp_loadFccSchools
drop procedure usp_loadLibraryMembers
drop procedure usp_loadLocalAuthority
drop procedure usp_loadSchoolAddress
*/


-- create table and stored procedure 1
create table LocalAuthority(
	LA_ID INT PRIMARY KEY,
	Name VARCHAR(55),
	DateCreated datetime NOT NULL DEFAULT GETDATE(),
	WhoCreated VARCHAR(55) DEFAULT CURRENT_USER,
	DateUpdated datetime NOT NULL DEFAULT GETDATE(),
	WhoUpdated VARCHAR(55) DEFAULT CURRENT_USER
);
go

create procedure usp_loadLocalAuthority as
begin try
insert into LocalAuthority
	select LA_ID, Name, DateCreated, WhoCreated, DateUpdated, WhoUpdated
	from Assignment.dbo.LocalAuthority 
end try
  begin catch
    select
	   ERROR_NUMBER() as Error,
	   ERROR_SEVERITY() as ErrorState,
	   ERROR_PROCEDURE() as ErrorProcedure,
	   ERROR_LINE() as ErrorLine,
	   ERROR_MESSAGE() as ErrorMessage;
  end catch
GO

--Execute stored procedure
exec usp_loadLocalAuthority
go
--Make sure data has been loaded
select * from LocalAuthority
go

-- create table and stored procedure 2
create table FccSchools(
	School_Roll_No VARCHAR(10) PRIMARY KEY,
	Name VARCHAR(220) NOT NULL,
	Phone VARCHAR(55),
	School_Level VARCHAR(55) NOT NULL,
	Mixed_Status VARCHAR(55) NOT NULL,
	Fee_paying VARCHAR(55),
	LA_ID INT REFERENCES LocalAuthority NOT NULL,
	DateCreated datetime NOT NULL DEFAULT GETDATE(),
	WhoCreated VARCHAR(55) DEFAULT CURRENT_USER,
	DateUpdated datetime NOT NULL DEFAULT GETDATE(),
	WhoUpdated VARCHAR(55) DEFAULT CURRENT_USER,
);
go

create procedure usp_loadFccSchools as
begin try
insert into FccSchools(
		School_Roll_No, 
		Name, 
		Phone, 
		School_Level, 
		Mixed_Status, 
		Fee_paying,
		LA_ID,
		DateCreated, 
		WhoCreated, 
		DateUpdated, 
		WhoUpdated
		)
	select School_Roll_No, Name, Phone, School_Level, Mixed_Status, Fee_paying, LA_ID, DateCreated, WhoCreated, DateUpdated, WhoUpdated
	from Assignment.dbo.FccSchools
end try
  begin catch
    select
	   ERROR_NUMBER() as Error,
	   ERROR_SEVERITY() as ErrorState,
	   ERROR_PROCEDURE() as ErrorProcedure,
	   ERROR_LINE() as ErrorLine,
	   ERROR_MESSAGE() as ErrorMessage;
  end catch
GO

--Execute stored procedure
exec usp_loadFccSchools
go
--Make sure data has been loaded
select * from FccSchools
go

-- create table and store procedure 3
create table SchoolAddress(
	AddressID INT IDENTITY(1,1) PRIMARY KEY,
	Address1 VARCHAR(55) NOT NULL,
	Address2 VARCHAR(55),
	Address3 VARCHAR(55),
	School_Roll_No VARCHAR(10) REFERENCES FccSchools Not Null,
	LA_ID INT REFERENCES LocalAuthority NOT NULL,
	DateCreated datetime NOT NULL DEFAULT GETDATE(),
	WhoCreated VARCHAR(55) DEFAULT CURRENT_USER,
	DateUpdated datetime NOT NULL DEFAULT GETDATE(),
	WhoUpdated VARCHAR(55) DEFAULT CURRENT_USER,
);
go

create procedure usp_loadSchoolAddress as
begin try
insert into SchoolAddress( 
		Address1, 
		Address2, 
		Address3, 
		School_Roll_No,
		LA_ID,
		DateCreated, 
		WhoCreated, 
		DateUpdated, 
		WhoUpdated
		)
	select  Address1, Address2, Address3, School_Roll_No, LA_ID, DateCreated, WhoCreated, DateUpdated, WhoUpdated
	from Assignment.dbo.FccSchools
end try
  begin catch
    select
	   ERROR_NUMBER() as Error,
	   ERROR_SEVERITY() as ErrorState,
	   ERROR_PROCEDURE() as ErrorProcedure,
	   ERROR_LINE() as ErrorLine,
	   ERROR_MESSAGE() as ErrorMessage;
  end catch
GO

--Execute stored procedure
exec usp_loadSchoolAddress
go
--Make sure data has been loaded
select * from SchoolAddress
go

-- create table and stored procedure 4
create table FccPlayingpitches(
	Facility_ID INT PRIMARY KEY,
	Facility_Type VARCHAR(55),
	Facility_Name VARCHAR(55),
	Area VARCHAR(55),
	LA_ID INT REFERENCES LocalAuthority NOT NULL,
	DateCreated datetime NOT NULL DEFAULT GETDATE(),
	WhoCreated VARCHAR(55) DEFAULT CURRENT_USER,
	DateUpdated datetime NOT NULL DEFAULT GETDATE(),
	WhoUpdated VARCHAR(55) DEFAULT CURRENT_USER
);
go

create procedure usp_loadFccPlayingpitches as
begin try
insert into FccPlayingpitches(
		Facility_ID,
		Facility_Type,
		Facility_Name,
		Area,
		LA_ID,
		DateCreated, 
		WhoCreated, 
		DateUpdated, 
		WhoUpdated
		)
	select Facility_ID, Facility_Type, Facility_Name, Area, LA_ID, DateCreated, WhoCreated, DateUpdated, WhoUpdated
	from Assignment.dbo.FccPlayingpitches
end try
  begin catch
    select
	   ERROR_NUMBER() as Error,
	   ERROR_SEVERITY() as ErrorState,
	   ERROR_PROCEDURE() as ErrorProcedure,
	   ERROR_LINE() as ErrorLine,
	   ERROR_MESSAGE() as ErrorMessage;
  end catch
GO

--Execute stored procedure
exec usp_loadFccPlayingpitches
go
--Make sure data has been loaded
select * from FccPlayingpitches
go

-- create table and stored procedure 5
create table FccParks(
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
	LA_ID INT REFERENCES LocalAuthority NOT NULL,
	DateCreated datetime NOT NULL DEFAULT GETDATE(),
	WhoCreated VARCHAR(55) DEFAULT CURRENT_USER,
	DateUpdated datetime NOT NULL DEFAULT GETDATE(),
	WhoUpdated VARCHAR(55) DEFAULT CURRENT_USER
);
go

create procedure usp_loadFccParks as
begin try
insert into FccParks(
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
		LA_ID,
		DateCreated, 
		WhoCreated, 
		DateUpdated, 
		WhoUpdated
		)
	select Park_ID, Name, Address1, Address2, Address3, Phone, Email, Website, Type, Parking, Bicyle_Parking, Toilets, LA_ID, DateCreated, WhoCreated, DateUpdated, WhoUpdated
	from Assignment.dbo.FccParks
end try
  begin catch
    select
	   ERROR_NUMBER() as Error,
	   ERROR_SEVERITY() as ErrorState,
	   ERROR_PROCEDURE() as ErrorProcedure,
	   ERROR_LINE() as ErrorLine,
	   ERROR_MESSAGE() as ErrorMessage;
  end catch
GO

--Execute stored procedure
exec usp_loadFccParks
go
--Make sure data has been loaded
select * from FccParks
go

-- create table and stored procedure 6
create table FccLibraries(
	Library_ID INT PRIMARY KEY,
	Name VARCHAR(55) NOT NULL,
	Address1 VARCHAR(55) NOT NULL,
	Address2 VARCHAR(55),
	Address3 VARCHAR(55),
	Website VARCHAR(220),
	Internet VARCHAR(25),
	WiFi VARCHAR(25),
	SelfService VARCHAR(25),
	LA_ID INT REFERENCES LocalAuthority NOT NULL,
	DateCreated datetime NOT NULL DEFAULT GETDATE(),
	WhoCreated VARCHAR(55) DEFAULT CURRENT_USER,
	DateUpdated datetime NOT NULL DEFAULT GETDATE(),
	WhoUpdated VARCHAR(55) DEFAULT CURRENT_USER
);
go

create procedure usp_loadFccLibraries as
begin try
insert into FccLibraries(
		Library_ID,
		Name,
		Address1,
		Address2,
		Address3,
		Website,
		Internet,
		WiFi,
		SelfService,
		LA_ID,
		DateCreated, 
		WhoCreated, 
		DateUpdated, 
		WhoUpdated
		)
	select Library_ID, Name, Address1, Address2, Address3, Website, Internet, Wifi, Selfservice, LA_ID, DateCreated, WhoCreated, DateUpdated, WhoUpdated
	from Assignment.dbo.FccLibraries
end try
  begin catch
    select
	   ERROR_NUMBER() as Error,
	   ERROR_SEVERITY() as ErrorState,
	   ERROR_PROCEDURE() as ErrorProcedure,
	   ERROR_LINE() as ErrorLine,
	   ERROR_MESSAGE() as ErrorMessage;
  end catch
GO

--Execute stored procedure
exec usp_loadFccLibraries
go
--Make sure data has been loaded
select * from FccLibraries
go

-- create table and stored procedure 7
create table ContactInfo(
	ContactInfo_ID INT IDENTITY(1,1) PRIMARY KEY,
	Phone VARCHAR(55),
	Email VARCHAR(55),
	Library_ID INT REFERENCES FccLibraries NOT NULL,
	DateCreated datetime NOT NULL DEFAULT GETDATE(),
	WhoCreated VARCHAR(55) DEFAULT CURRENT_USER,
	DateUpdated datetime NOT NULL DEFAULT GETDATE(),
	WhoUpdated VARCHAR(55) DEFAULT CURRENT_USER
);
go

create procedure usp_loadContactInfo as
begin try
insert into ContactInfo(
		Phone,
		Email,
		Library_ID,
		DateCreated, 
		WhoCreated, 
		DateUpdated, 
		WhoUpdated
		)
	select Phone, Email, Library_ID, DateCreated, WhoCreated, DateUpdated, WhoUpdated
	from Assignment.dbo.FccLibraries
end try
  begin catch
    select
	   ERROR_NUMBER() as Error,
	   ERROR_SEVERITY() as ErrorState,
	   ERROR_PROCEDURE() as ErrorProcedure,
	   ERROR_LINE() as ErrorLine,
	   ERROR_MESSAGE() as ErrorMessage;
  end catch
GO

--Execute stored procedure
exec usp_loadContactInfo
go
--Make sure data has been loaded
select * from ContactInfo
go

-- create table and stored procedure 8
create table LibraryMembers(
	LibraryMembers_ID INT IDENTITY(1,1) PRIMARY KEY,
	Year INT NOT NULL,
	Members INT NOT NULL,
	New INT,
	Lost INT,
	Library_ID INT REFERENCES FccLibraries NOT NULL,
	DateCreated datetime NOT NULL DEFAULT GETDATE(),
	WhoCreated VARCHAR(55) DEFAULT CURRENT_USER,
	DateUpdated datetime NOT NULL DEFAULT GETDATE(),
	WhoUpdated VARCHAR(55) DEFAULT CURRENT_USER
);
go

create procedure usp_loadLibraryMembers as
begin try
insert into LibraryMembers(
		Year,
		Members,
		New,
		Lost,
		Library_ID,
		DateCreated, 
		WhoCreated, 
		DateUpdated, 
		WhoUpdated
		)
	select Year, Members, New, Lost, Library_ID, DateCreated, WhoCreated, DateUpdated, WhoUpdated
	from Assignment.dbo.LibraryMembers
end try
  begin catch
    select
	   ERROR_NUMBER() as Error,
	   ERROR_SEVERITY() as ErrorState,
	   ERROR_PROCEDURE() as ErrorProcedure,
	   ERROR_LINE() as ErrorLine,
	   ERROR_MESSAGE() as ErrorMessage;
  end catch
GO

--Execute stored procedure
exec usp_loadLibraryMembers
go
--Make sure data has been loaded
select * from LibraryMembers
go