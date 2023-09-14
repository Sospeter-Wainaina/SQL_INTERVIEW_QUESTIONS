--create table company_revenue 
--(
--company varchar(100),
--year int,
--revenue int
--)

--insert into company_revenue values 
--('ABC1',2000,100),('ABC1',2001,110),('ABC1',2002,120),('ABC2',2000,100),('ABC2',2001,90),('ABC2',2002,120)
--,('ABC3',2000,500),('ABC3',2001,400),('ABC3',2002,600),('ABC3',2003,800);

----Q1 Only output companies which have continously gained revenue else it should not output

with CTE as (
select *,
isnull(lag(revenue) over(partition by company order by year ),0) as previous_revenue,
CASE WHEN revenue>isnull(lag(revenue) over(partition by company order by year ),0) THEN 0 ELSE 1 END as diff

from company_revenue)
select COMPANY,COUNT(DIFF) AS PROFIT_YEARS
from cte 
GROUP BY COMPANY
HAVING SUM(DIFF)=0