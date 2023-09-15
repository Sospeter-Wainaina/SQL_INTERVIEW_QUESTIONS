--Write a query to provide the date for the nth occurrence of Sunday in the future from the Given Date

DECLARE @todays_date date,@n int;
set @todays_date='2022-01-02' -- Saturday
set @n =3 

select DATEADD(WEEK,@n-1,DATEADD(day,8-  datepart(weekday,@todays_date),@todays_date))