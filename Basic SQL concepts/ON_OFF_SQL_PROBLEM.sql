use prac;
--create table event_status
--(
--event_time varchar(10),
--status varchar(10)
--);
--insert into event_status 
--values
--('10:01','on'),('10:02','on'),('10:03','on'),('10:04','off'),('10:07','on'),('10:08','on'),('10:09','off')
--,('10:11','on'),('10:12','off');

--On off Problem

WITH cte AS (
  SELECT *,
    SUM(CASE WHEN status = 'on' AND prev_status = 'off' THEN 1 ELSE 0 END) OVER (ORDER BY event_time) AS group_key
  FROM (
    SELECT *,
      LAG(status, 1, status) OVER (ORDER BY event_time) AS prev_status
    FROM event_status
  ) AS a
)
SELECT min(event_time) as log_in,max(event_time) as log_out, count(1)-1 as on_count
FROM cte
GROUP BY group_key ;
