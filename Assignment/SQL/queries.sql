-- query the dimensional database

use StarSchema_Membership
go

-- Libraries with more than 2000 members
select Name 
from dimLibrary join dimLibraryMembers on dimLibrary.Library_ID = dimLibraryMembers.Library_ID
where Members > 2000;

-- Libraries with less than 2000 members
select Name 
from dimLibrary join dimLibraryMembers on dimLibrary.Library_ID = dimLibraryMembers.Library_ID
where Members < 2000;

-- Contact info for libraries with Swords in the address
select Phone, Email
from dimContactInfo join dimLibrary on dimContactInfo.Library_ID = dimLibrary.Library_ID
where Address1 like '%swords%' or Address2 like '%swords%' or Address3 like '%swords%';

