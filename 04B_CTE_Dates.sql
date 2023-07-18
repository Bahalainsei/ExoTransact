
/*
	DATEFROMPARTS (YEAR, MONTH, DAY)
	EOMONTH
	Recursive CTE
*/

;with dates ([Date]) as (
    Select DATEFROMPARTS(YEAR(GETDATE()), MONTH(GETDATE()), 1) as [Date] -- Put the start date here (Anchor)

    union all															-- Split Anchor and Recursive Members

    Select dateadd(day, 1, [Date])
    from dates
    where [Date] < EOMONTH(GETDATE())									-- Put the end date here (Recursive Members)
)

SELECT [Date], 0
FROM dates
option (maxrecursion 32767) 
