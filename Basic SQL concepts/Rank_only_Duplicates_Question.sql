--create table list (id varchar(5));
--insert into list values ('a');
--insert into list values ('a');
--insert into list values ('b');
--insert into list values ('c');
--insert into list values ('c');
--insert into list values ('c');
--insert into list values ('d');
--insert into list values ('d');
--insert into list values ('e');

with dup as (
select id from list 
group by id
having count(1)>1
),
cte_rank as (select *,
rank() over(order by id) as rnk from dup
)

select l.*,'DUP'+cast(cr.rnk as varchar) as con from list l
left join cte_rank cr on cr.id =l.id