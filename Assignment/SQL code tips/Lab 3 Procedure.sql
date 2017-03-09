use northwind;
drop procedure usp_MadeOrders;
GO
CREATE PROCEDURE usp_MadeOrders @returnrows int

-- select top 10 EmployeeID, FirstName, LastName, OrderID, OrderDate
-- from Employees join Orders using (EmployeeID);


AS
DECLARE @SQLQuery VARCHAR(250);
BEGIN TRY
    SET @SQLQuery = 'SELECT TOP ' +CAST(@returnrows AS VARCHAR(5))
		+' e.EmployeeID, e.FirstName, e.LastName,
					o.OrderID, o.OrderDate
	from Employees e Join Orders o ON
	(e.EmployeeID = o.EmployeeID);'
	EXECUTE(@SQLQuery);
END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber
     ,ERROR_SEVERITY() AS ErrorSeverity
     ,ERROR_STATE() AS ErrorState
     ,ERROR_PROCEDURE() AS ErrorProcedure
     ,ERROR_LINE() AS ErrorLine
     ,ERROR_MESSAGE() AS ErrorMessage;
END CATCH
GO

execute usp_MadeOrders 5;