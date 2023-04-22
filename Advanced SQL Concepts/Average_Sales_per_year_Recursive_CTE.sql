
create table sales (
product_id int,
period_start date,
period_end date,
average_daily_sales int
);

insert into sales values(1,'2019-01-25','2019-02-28',100),(2,'2018-12-01','2020-01-01',10),(3,'2019-12-01','2020-01-31',1);

--=================================================================================

--Base short tutorial on how it works
with e_cte as (
select 1 as num --Anchor Query -> Runs only once
union all
select num+1 from e_cte
where num<6 --The break point
)

select * from e_cte

--anchor query num = 1
--1 + 1 num=2
--2 + 1 num=3...

--==================================================================================
--Total sales by year
with r_cte as (
select min(period_start) as start_date, max(period_end) as max_date from sales
union all
select dateadd(day,1,start_date) as start_date,max_date from r_cte
where start_date < max_date
)

select product_id,year(start_date) as year,sum(average_daily_sales) from r_cte
inner join sales on start_date between period_start and period_end
group by product_id,year(start_date)
order by product_id,year(start_date)
option(maxrecursion 1000)