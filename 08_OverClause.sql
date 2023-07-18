/*
	The Over Clause defines the window of rows over which the aggregate or ranking function is calculated.
	The Partition By clause is optional. When omitted the "Window" is the full virtual table exposed to the over clause.
		The virtual table is result after the FROM, where clause, group by, having clause have been evaluated. 
		(Logical query procesisng order applies and the Over Clause can only be used in step 5 & 6 (SELECT AND ORDER BY)
	The Partition by clause defines the window for the calculation.
*/

-- PERCENT OF PARENT
SELECT
	SalesOrderID,
	SalesOrderDetailID,
	LineTotal,
	SUM(LineTotal) OVER() AS WithoutPartitionBy,
	SUM(LineTotal) OVER(Partition By SalesOrderID) AS TransactionTotal,
	LineTotal /	SUM(LineTotal) OVER(Partition By SalesOrderID) * 100 PctOftotal
FROM	
	AdventureWorks2012.Sales.SalesOrderDetail


-- RUNNING TOTAL

	SET STATISTICS IO ON

	SELECT CustomerId, SalesOrderID, OrderDate, TotalDue,

		SUM(TotalDue) 
		OVER(PARTITION BY CustomerID ORDER By SalesOrderID ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS RunningTotal	--  ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW

	FROM	
		AdventureWorks2012.Sales.SalesOrderHeader;