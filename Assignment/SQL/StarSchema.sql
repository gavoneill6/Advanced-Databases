-- create a star scheme using data from the relational database

create database StarSchema_Membership
go
use StarSchema_Membership
go

-- Use drop functions to clear everything before first time running
/*
drop table MembershipFacts
drop table dimContactInfo
drop table dimDate
drop table dimLibrary
drop table dimLibraryMembers
drop table dimLocalAuthority

drop procedure usp_loaddimContactInfo
drop procedure usp_loaddimDate
drop procedure usp_loaddimLibrary
drop procedure usp_loaddimLibraryMembers
drop procedure usp_loaddimLocalAuthority
drop procedure usp_loadMembershipFacts
*/

-- Dimension tables

create table dimLocalAuthority(
	LocalAuthority_key integer identity(1,1) primary key,
	LA_ID INT,
	Name VARCHAR(55),
	DateCreated datetime NOT NULL DEFAULT GETDATE(),
	WhoCreated VARCHAR(55) DEFAULT CURRENT_USER,
	DateUpdated datetime NOT NULL DEFAULT GETDATE(),
	WhoUpdated VARCHAR(55) DEFAULT CURRENT_USER
);
go

create procedure usp_loaddimLocalAuthority as
begin try
insert into dimLocalAuthority
	select LA_ID, Name, DateCreated, WhoCreated, DateUpdated, WhoUpdated
	from relational_amenities.dbo.LocalAuthority 
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
exec usp_loaddimLocalAuthority
go
--Make sure data has been loaded
select * from dimLocalAuthority
go

create table dimDate(
	Date_key integer identity(1,1) primary key,
	Membership_Year INT,
	DateCreated datetime NOT NULL DEFAULT GETDATE(),
	WhoCreated VARCHAR(55) DEFAULT CURRENT_USER,
	DateUpdated datetime NOT NULL DEFAULT GETDATE(),
	WhoUpdated VARCHAR(55) DEFAULT CURRENT_USER
);
go

create procedure usp_loaddimDate as
begin try
insert into dimDate(
		Membership_Year,
		DateCreated,
		WhoCreated,
		DateUpdated,
		WhoUpdated
		)
	select Year, DateCreated, WhoCreated, DateUpdated, WhoUpdated
	from relational_amenities.dbo.LibraryMembers
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
exec usp_loaddimDate
go
--Make sure data has been loaded
select * from dimDate
go

create table dimLibrary(
	Library_key integer identity(1,1) primary key,
	Library_ID INT,
	Name VARCHAR(55),
	Address1 VARCHAR(55) NOT NULL,
	Address2 VARCHAR(55),
	Address3 VARCHAR(55),
	Website VARCHAR(220),
	Internet VARCHAR(25),
	WiFi VARCHAR(25),
	SelfService VARCHAR(25),
	DateCreated datetime NOT NULL DEFAULT GETDATE(),
	WhoCreated VARCHAR(55) DEFAULT CURRENT_USER,
	DateUpdated datetime NOT NULL DEFAULT GETDATE(),
	WhoUpdated VARCHAR(55) DEFAULT CURRENT_USER
);
go

create procedure usp_loaddimLibrary as
begin try
insert into dimLibrary(
		Library_ID,
		Name,
		Address1,
		Address2,
		Address3,
		Website,
		Internet,
		WiFi,
		SelfService,
		DateCreated, 
		WhoCreated, 
		DateUpdated, 
		WhoUpdated
		)
	select Library_ID, Name, Address1, Address2, Address3, Website, Internet, Wifi, Selfservice, DateCreated, WhoCreated, DateUpdated, WhoUpdated
	from relational_amenities.dbo.FccLibraries 
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
exec usp_loaddimLibrary
go
--Make sure data has been loaded
select * from dimLibrary
go

create table dimContactInfo(
	ContactInfo_key integer identity(1,1) primary key,
	ContactInfo_ID INT,
	Phone VARCHAR(55),
	Email VARCHAR(55),
	Library_ID INT,
	DateCreated datetime NOT NULL DEFAULT GETDATE(),
	WhoCreated VARCHAR(55) DEFAULT CURRENT_USER,
	DateUpdated datetime NOT NULL DEFAULT GETDATE(),
	WhoUpdated VARCHAR(55) DEFAULT CURRENT_USER
);
go

create procedure usp_loaddimContactInfo as
begin try
insert into dimContactInfo(
		ContactInfo_ID,
		Phone,
		Email,
		Library_ID,
		DateCreated, 
		WhoCreated, 
		DateUpdated, 
		WhoUpdated
		)
	select ContactInfo_ID, Phone, Email, Library_ID, DateCreated, WhoCreated, DateUpdated, WhoUpdated
	from relational_amenities.dbo.ContactInfo
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
exec usp_loaddimContactInfo
go
--Make sure data has been loaded
select * from dimContactInfo
go

create table dimLibraryMembers(
	LibraryMembers_key integer identity(1,1) primary key,
	LibraryMembers_ID INT,
	Members INT NOT NULL,
	Library_ID INT,
	DateCreated datetime NOT NULL DEFAULT GETDATE(),
	WhoCreated VARCHAR(55) DEFAULT CURRENT_USER,
	DateUpdated datetime NOT NULL DEFAULT GETDATE(),
	WhoUpdated VARCHAR(55) DEFAULT CURRENT_USER
);
go

create procedure usp_loaddimLibraryMembers as
begin try
insert into dimLibraryMembers(
		LibraryMembers_ID,
		Members,
		Library_ID,
		DateCreated, 
		WhoCreated, 
		DateUpdated, 
		WhoUpdated
		)
	select LibraryMembers_ID, Members, Library_ID, DateCreated, WhoCreated, DateUpdated, WhoUpdated
	from relational_amenities.dbo.LibraryMembers
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
exec usp_loaddimLibraryMembers
go
--Make sure data has been loaded
select * from dimLibraryMembers
go

create table MembershipFacts(
	MembershipFacts_key integer identity(1,1) primary key,
	LocalAuthority_key integer references dimLocalAuthority,
	Date_key integer references dimDate,
	Library_key integer references dimLibrary,
	NewMembers INT,
	LostMembers INT,
	DateCreated datetime NOT NULL DEFAULT GETDATE(),
	WhoCreated VARCHAR(55) DEFAULT CURRENT_USER,
	DateUpdated datetime NOT NULL DEFAULT GETDATE(),
	WhoUpdated VARCHAR(55) DEFAULT CURRENT_USER,
);
go

-- Add relation between fact table foreign keys to Primary keys of Dimensions
AlTER TABLE MembershipFacts ADD CONSTRAINT _FK_LocalAuthority_key FOREIGN KEY (LocalAuthority_key) REFERENCES dimLocalAuthority(LocalAuthority_key);
AlTER TABLE MembershipFacts ADD CONSTRAINT _FK_Date_key FOREIGN KEY (Date_key) REFERENCES dimDate(Date_key);
AlTER TABLE MembershipFacts ADD CONSTRAINT _FK_Library_key FOREIGN KEY (Library_key) REFERENCES dimLibrary(Library_key);
Go

create procedure usp_loadMembershipFacts as
begin try
insert into MembershipFacts(
		NewMembers,
		LostMembers,
		DateCreated, 
		WhoCreated, 
		DateUpdated, 
		WhoUpdated
		)
	select New, Lost, DateCreated, WhoCreated, DateUpdated, WhoUpdated
	from relational_amenities.dbo.LibraryMembers
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
exec usp_loadMembershipFacts
go
--Make sure data has been loaded
select * from MembershipFacts
go


