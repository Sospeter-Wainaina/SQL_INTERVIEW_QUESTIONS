
create table employee 
(
emp_name varchar(10),
dep_id int,
salary int
);
delete from employee;
insert into employee values 
('Siva',1,30000),('Ravi',2,40000),('Prasad',1,50000),('Sai',2,20000)

--Write a query to print the highest and lowest salary in each department
--SOL 1
with cte as (
select *,
row_number() over(partition by dep_id order by salary desc) as h_rank,
row_number() over(partition by dep_id order by salary) as l_rank
from employee)

select dep_id,
max(case when h_rank = 1 then emp_name else Null end) as emp_with_highest_sal, 
max(case when l_rank = 1 then emp_name else Null end) as emp_with_lowest_sal
from cte
group by dep_id

--SOL 2

--Write a query to print the highest and lowest salary in each department
with cte as (
select dep_id,
max(salary) as max_salary,
min(salary) as min_salary from employee
group by dep_id)
select e.dep_id,
max(case when max_salary = e.salary then e.emp_name else null end) as emp_max_salary,
max(case when min_salary = e.salary then e.emp_name else null end) as emp_min_salary

from employee e  inner join cte on cte.dep_id=e.dep_id
group by e.dep_id