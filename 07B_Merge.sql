/*	SETUP
		DELETE FROM Customers WHERE CustomerKey > 11001
		UPDATE Customers SET EmailAddress = NULL

		SELECT * FROM Customers
		SELECT * FROM Customers_Stage
*/
USE [Presentations]

	MERGE Customers CST
	USING Customers_Stage CSS
	ON CST.CustomerKey = CSS.CustomerKey

WHEN MATCHED -- AND <column> = <expression>
THEN
	UPDATE SET EmailAddress = css.EmailAddress
WHEN NOT MATCHED 
THEN
	INSERT (FirstName, LastName, Gender, EmailAddress, AddressLine1, AddressLine2, Phone)
	VALUES (CSS.FirstName, CSS.LastName, CSS.Gender, CSS.EmailAddress, CSS.AddressLine1, CSS.AddressLine2, CSS.Phone);	

GO

