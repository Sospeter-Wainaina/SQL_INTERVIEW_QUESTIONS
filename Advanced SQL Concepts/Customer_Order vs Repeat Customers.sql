--create table customer_orders (
--order_id integer,
--customer_id integer,
--order_date date,
--order_amount integer
--);

--insert into customer_orders values(1,100,cast('2022-01-01' as date),2000),(2,200,cast('2022-01-01' as date),2500),(3,300,cast('2022-01-01' as date),2100)
--,(4,100,cast('2022-01-02' as date),2000),(5,400,cast('2022-01-02' as date),2200),(6,500,cast('2022-01-02' as date),2700)
--,(7,100,cast('2022-01-03' as date),3000),(8,400,cast('2022-01-03' as date),1000),(9,600,cast('2022-01-03' as date),3000);

-- Expected Output is -> Order_date,New_customer_count,Repeat_customer_Count

with cte as (
select 
customer_id,
min(order_date) as first_order_dt
from customer_orders
group by customer_id)
select c.order_date,
sum(case when first_order_dt = c.order_date then 1 else 0 end) as New_customer_count,
sum(case when first_order_dt <> c.order_date then 1 else 0 end) as Repeat_customer_Count,
sum(case when  first_order_dt = c.order_date then c.order_amount else 0 end) as New_Customer_Order_Amn,
sum(case when  first_order_dt <> c.order_date then c.order_amount else 0 end) as Repeat_Customer_Order_Amn
 from cte t 
inner join customer_orders c on t.customer_id = c.customer_id
group by c.order_date
order by c.order_date
