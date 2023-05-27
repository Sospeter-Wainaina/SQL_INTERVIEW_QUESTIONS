--create table Ameriprise_LLC
--(
--teamID varchar(2),
--memberID varchar(10),
--Criteria1 varchar(1),
--Criteria2 varchar(1)
--);
--insert into Ameriprise_LLC values
--('T1','T1_mbr1','Y','Y'),
--('T1','T1_mbr2','Y','Y'),
--('T1','T1_mbr3','Y','Y'),
--('T1','T1_mbr4','Y','Y'),
--('T1','T1_mbr5','Y','N'),
--('T2','T2_mbr1','Y','Y'),
--('T2','T2_mbr2','Y','N'),
--('T2','T2_mbr3','N','Y'),
--('T2','T2_mbr4','N','N'),
--('T2','T2_mbr5','N','N'),
--('T3','T3_mbr1','Y','Y'),
--('T3','T3_mbr2','Y','Y'),
--('T3','T3_mbr3','N','Y'),
--('T3','T3_mbr4','N','Y'),
--('T3','T3_mbr5','Y','N');

--For a person to qualify there are 2 conditions:

--1- The person should have both the criteria as 'Y' .
--2- There should be at least 2 people in his team who qualify for the program.


--FIRST cONDITION
WITH CTE AS (
SELECT *
,SUM(CASE WHEN Criteria1='Y' and Criteria2='Y' THEN 1 ELSE 0 END) OVER(PArTITION BY teamID ) Team_Qualification,
SUM(CASE WHEN Criteria1='Y' and Criteria2='Y' THEN 1 ELSE 0 END) OVER(PArTITION BY memberID ) Indiv_Qualification
FROM Ameriprise_LLC
)

SELECT 
teamID,
memberID,
Criteria1,
Criteria2,
CASE WHEN Team_Qualification>=2 and Indiv_Qualification=1 THEN 'Y' ELSE 'N' END AS Qualifies_For_Program
FROM CTE 

--GROUP BY teamID HAVING Team_Qualification >= 2
