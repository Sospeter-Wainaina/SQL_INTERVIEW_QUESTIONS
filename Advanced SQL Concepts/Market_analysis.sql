--drop table users;
--create table users (
--user_id         int     ,
-- join_date       date    ,
-- favorite_brand  varchar(50));

-- create table orders (
-- order_id       int     ,
-- order_date     date    ,
-- item_id        int     ,
-- buyer_id       int     ,
-- seller_id      int 
-- );

-- create table items
-- (
-- item_id        int     ,
-- item_brand     varchar(50)
-- );


-- insert into users values (1,'2019-01-01','Lenovo'),(2,'2019-02-09','Samsung'),(3,'2019-01-19','LG'),(4,'2019-05-21','HP');

-- insert into items values (1,'Samsung'),(2,'Lenovo'),(3,'LG'),(4,'HP');

-- insert into orders values (1,'2019-08-01',4,1,2),(2,'2019-08-02',2,1,3),(3,'2019-08-03',3,2,3),(4,'2019-08-04',1,4,2)
-- ,(5,'2019-08-04',1,3,4),(6,'2019-08-05',2,2,4);

/* Write an sql query to find out for each seller whether the second brand they  sold by date is their favorite brand*/

--select * from users;
--select * from orders;
--select * from items;
with cte as
 (select *,
 row_number() over (partition by seller_id order by order_date) as rn
 from orders)
 select user_id as seller_id,
 case when u.favorite_brand = i.item_brand then 'Yes' else 'No' end as item_fav_brand
 from users u left join cte c on c.seller_id = u.user_id
 left join items i on c.item_id = i.item_id
 where rn = 2 or rn is null
 order by seller_id;
--where num = 2 