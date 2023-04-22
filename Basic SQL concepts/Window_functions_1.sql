
CREATE TABLE [dbo].[empl](
	[emp_id] [int] NULL,
	[emp_name] [varchar](20) NULL,
	[department_id] [int] NULL,
	[salary] [int] NULL
) ON [PRIMARY]
GO



select 
emp_id,
emp_name,
department_id,
salary,
RANK() OVER(PARTITION BY department_id ORDER BY salary DESC) as rank,
DENSE_RANK() OVER(PARTITION BY department_id ORDER BY salary DESC) as dense_rnk ,
ROW_NUMBER() OVER(PARTITION BY department_id ORDER BY salary DESC) as row_numb from empl

--RANK -> IF number ties, gives same number but counter doesnt stop 1,2,2,[4]
--DENSE_RANK -> IF number ties, gives same number but it will continue with the sequence like so -> 1,2,2,3,3,4,5 more of stacking
--ROW_NUMBER -> Irresprctive of ties it will give unique number

--HIGHEST SALARY PER DEPT
WITH CTE AS (
select 
emp_id,
emp_name,
department_id,
salary,
RANK() OVER(PARTITION BY department_id ORDER BY salary DESC) as rank,
DENSE_RANK() OVER(PARTITION BY department_id ORDER BY salary DESC) as dense_rnk ,
ROW_NUMBER() OVER(PARTITION BY department_id ORDER BY salary DESC) as row_numb from empl
)

SELECT 
emp_id,
emp_name,
department_id,
salary
FROM CTE
WHERE row_numb = 1