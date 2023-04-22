--Difference between count(*), Count(1) count(-1),Count(0),Counr(col)

select 
--count(*)--Counts the total number of rows in the table 
Count(1),-- It counts a contsnt literal irregardles of what you insert as the parameter and will return count of rows
count(emp_name)--return number of rows in a particular column excluding nulls
from emp