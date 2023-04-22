create table list (id varchar(5));
insert into list values ('a');
insert into list values ('a');
insert into list values ('b');
insert into list values ('c');
insert into list values ('c');
insert into list values ('c');
insert into list values ('d');
insert into list values ('d');
insert into list values ('e');

with dup as (
select *,
row_number() over (partition by id order by id) as rnk
from list)
select 
*,
case when count(1) over (partition by id) > 1 then 'DUP' + cast(rnk as varchar)
else NULL
end as dupp
from dup