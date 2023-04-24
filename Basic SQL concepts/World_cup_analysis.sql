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

SELECT 
team_name,count(1) as matches_played,sum(win_flag) as matches_won,count(1)-sum(win_flag) as matches_not_won
FROM
(
select team_1 AS team_name, case when team_1 = Winner then 1 else 0 end as win_flag from icc_world_cup
UNION ALL --NB Remember Union all returns all values including duplicates while union returns distinct values and then sorts, also Union all is faster
SELECT team_2 AS team_name, CASE WHEN team_2=winner THEN 1 ELSE 0 END AS win_flag FROM icc_world_cup
) A 
group by team_name