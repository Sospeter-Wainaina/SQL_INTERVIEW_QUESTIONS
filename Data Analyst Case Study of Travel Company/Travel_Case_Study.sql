--CREATE TABLE booking_table(
--   Booking_id       VARCHAR(3) NOT NULL 
--  ,Booking_date     date NOT NULL
--  ,User_id          VARCHAR(2) NOT NULL
--  ,Line_of_business VARCHAR(6) NOT NULL
--);
--INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b1','2022-03-23','u1','Flight');
--INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b2','2022-03-27','u2','Flight');
--INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b3','2022-03-28','u1','Hotel');
--INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b4','2022-03-31','u4','Flight');
--INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b5','2022-04-02','u1','Hotel');
--INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b6','2022-04-02','u2','Flight');
--INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b7','2022-04-06','u5','Flight');
--INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b8','2022-04-06','u6','Hotel');
--INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b9','2022-04-06','u2','Flight');
--INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b10','2022-04-10','u1','Flight');
--INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b11','2022-04-12','u4','Flight');
--INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b12','2022-04-16','u1','Flight');
--INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b13','2022-04-19','u2','Flight');
--INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b14','2022-04-20','u5','Hotel');
--INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b15','2022-04-22','u6','Flight');
--INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b16','2022-04-26','u4','Hotel');
--INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b17','2022-04-28','u2','Hotel');
--INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b18','2022-04-30','u1','Hotel');
--INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b19','2022-05-04','u4','Hotel');
--INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b20','2022-05-06','u1','Flight');
--;
--CREATE TABLE user_table(
--   User_id VARCHAR(3) NOT NULL
--  ,Segment VARCHAR(2) NOT NULL
--);
--INSERT INTO user_table(User_id,Segment) VALUES ('u1','s1');
--INSERT INTO user_table(User_id,Segment) VALUES ('u2','s1');
--INSERT INTO user_table(User_id,Segment) VALUES ('u3','s1');
--INSERT INTO user_table(User_id,Segment) VALUES ('u4','s2');
--INSERT INTO user_table(User_id,Segment) VALUES ('u5','s2');
--INSERT INTO user_table(User_id,Segment) VALUES ('u6','s3');
--INSERT INTO user_table(User_id,Segment) VALUES ('u7','s3');
--INSERT INTO user_table(User_id,Segment) VALUES ('u8','s3');
--INSERT INTO user_table(User_id,Segment) VALUES ('u9','s3');
--INSERT INTO user_table(User_id,Segment) VALUES ('u10','s3');

--Booking _table (Booking_date,User_id,Line_of_busines[flight,hotel]) and User_table (User_id and segment)
--Q1 Give a report containing Segment,Total_user_count,Users_who_booked_apr2022

SELECT 
U.SEGMENT,COUNT(DISTINCT U.USER_ID),
COUNT(DISTINCT CASE WHEN B.LINE_OF_BUSINESS = 'Flight' AND MONTH(B.BOOKING_DATE)=4 THEN B.USER_ID ELSE NULL END) AS USER_WHO_BOOKED_FLIGHT_IN_APRIL2022
FROM BOOKING_TABLE B 
RIGHT JOIN USER_TABLE U ON B.USER_ID = U.USER_ID
GROUP BY U.SEGMENT

--Q2 Write a query to identify users whose first booking was a hotel booking

SELECT USER_ID FROM (
SELECT NUM=ROW_NUMBER() OVER(PARTITION BY B.USER_ID ORDER BY B.BOOKING_DATE asc),* FROM BOOKING_TABLE B

) A
 WHERE A.NUM=1
 AND A.LINE_OF_BUSINESS = 'Hotel'

 --OR

 SELECT USER_ID FROM (
SELECT BOOKING=FIRST_VALUE(LINE_OF_BUSINESS) OVER(PARTITION BY B.USER_ID ORDER BY B.BOOKING_DATE asc),* FROM BOOKING_TABLE B
) A
WHERE BOOKING='Hotel'
AND A.LINE_OF_BUSINESS = 'Hotel'

--Q3 WRITE QUERY TO CALCULATE THE DAYS BETWEEN FIRST AND LAST BOOKING OF EACH USER

SELECT 
USER_ID,
MIN(BOOKING_DATE) AS FIRST_BOOKING_DATE,
MAX(BOOKING_DATE) AS LAST_BOOKING_DATE,
DATEDIFF(DAY,MIN(BOOKING_DATE),MAX(BOOKING_DATE))
FROM BOOKING_TABLE
GROUP BY USER_ID