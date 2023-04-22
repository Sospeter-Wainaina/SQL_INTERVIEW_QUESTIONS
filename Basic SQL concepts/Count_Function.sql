--Difference between count(*), Count(1) count(-1),Count(0),Counr(col)


CREATE TABLE [dbo].[emp](
	[emp_id] [int] NULL,
	[emp_name] [varchar](50) NULL,
	[salary] [int] NULL,
	[manager_id] [int] NULL,
	[emp_age] [int] NULL,
	[dep_id] [int] NULL,
	[dep_name] [varchar](20) NULL,
	[gender] [varchar](10) NULL
) ON [PRIMARY]
GO



select 
--count(*)--Counts the total number of rows in the table 
Count(1),-- It counts a contsnt literal irregardles of what you insert as the parameter and will return count of rows
count(emp_name)--return number of rows in a particular column excluding nulls
from emp