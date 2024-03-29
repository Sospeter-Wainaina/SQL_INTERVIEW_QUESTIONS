----script:
--Create table candidates(
--id int primary key,
--positions varchar(10) not null,
--salary int not null);

----test case 1:
--insert into candidates values(1,'junior',5000);
--insert into candidates values(2,'junior',7000);
--insert into candidates values(3,'junior',7000);
--insert into candidates values(4,'senior',10000);
--insert into candidates values(5,'senior',30000);
--insert into candidates values(6,'senior',20000);

with running_cte as (
select *,sum(salary) over (partition by positions order by salary rows between unbounded preceding and current row) as running_salary
from candidates
), seniors_cte as (
select count(*) as Seniors,isnull(sum(salary),0) as run_salary from running_cte where positions = 'senior'
and running_salary <= 50000),
juniors_cte as (
select count(*) as Juniors from running_cte where positions = 'junior'
and running_salary <= 50000- (select run_salary from seniors_cte))

select juniors,seniors from seniors_cte,juniors_cte

--Scenario 2

--delete from candidates

--insert into candidates values(20,'junior',10000);
--insert into candidates values(30,'senior',15000);
--insert into candidates values(40,'senior',30000);

--Scenario 3

--delete from candidates

--insert into candidates values(1,'junior',15000);
--insert into candidates values(2,'junior',15000);
--insert into candidates values(3,'junior',20000);
--insert into candidates values(4,'senior',60000);

----Scenario 4

--delete from candidates

--insert into candidates values(10,'junior',10000);
--insert into candidates values(40,'junior',10000);
--insert into candidates values(20,'senior',15000);
--insert into candidates values(30,'senior',30000);
--insert into candidates values(50,'senior',15000);