--create table icc_world_cup
--(
--Team_1 Varchar(20),
--Team_2 Varchar(20),
--Winner Varchar(20)
--);
--INSERT INTO icc_world_cup values('India','SL','India');
--INSERT INTO icc_world_cup values('SL','Aus','Aus');
--INSERT INTO icc_world_cup values('SA','Eng','Eng');
--INSERT INTO icc_world_cup values('Eng','NZ','NZ');
--INSERT INTO icc_world_cup values('Aus','India','India');

--Expected Output includes -> Team_name ,Matches_played,no_of_wins,No_of_losses
 
select Team_name, count(1) as Matches_played,
sum(case when win_flag = 1 then 1 else 0 end) as no_of_wins,
(count(1)-sum(case when win_flag = 1 then 1 else 0 end)) as No_of_losses
from (
select Team_1 as Team_name,(case when team_1=winner then 1 else 0 end) as win_flag from icc_world_cup
union all
select team_2 as Team_name,(case when team_2=winner then 1 else 0 end) as win_flag from icc_world_cup) x
group by Team_name
order by no_of_wins desc