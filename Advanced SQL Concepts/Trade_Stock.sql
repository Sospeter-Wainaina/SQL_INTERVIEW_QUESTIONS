
--Create Table Trade_tbl(
--TRADE_ID varchar(20),
--Trade_Timestamp time,
--Trade_Stock varchar(20),
--Quantity int,
--Price Float
--)

--Insert into Trade_tbl Values('TRADE1','10:01:05','ITJunction4All',100,20)
--Insert into Trade_tbl Values('TRADE2','10:01:06','ITJunction4All',20,15)
--Insert into Trade_tbl Values('TRADE3','10:01:08','ITJunction4All',150,30)
--Insert into Trade_tbl Values('TRADE4','10:01:09','ITJunction4All',300,32)
--Insert into Trade_tbl Values('TRADE5','10:10:00','ITJunction4All',-100,19)
--Insert into Trade_tbl Values('TRADE6','10:10:01','ITJunction4All',-300,19)

/* Write SQL to find all couples of trade for the same stock that happened in a range of 10 seconds and having
a price difference by more than 10%. Output shpuld also list the percentage of the price between the two trade*/

SELECT T1.TRADE_ID,T2.TRADE_ID,
DATEDIFF(SECOND,T1.TRADE_TIMESTAMP,T2.TRADE_TIMESTAMP) AS RANGE,
ABS((T1.PRICE-T2.PRICE)/T1.PRICE *100) AS PERCENTAGEPRICE FROM TRADE_TBL T1 
INNER JOIN TRADE_TBL T2 ON 1=1
WHERE ABS((T1.PRICE-T2.PRICE)/T1.PRICE *100) > 10
AND DATEDIFF(SECOND,T1.TRADE_TIMESTAMP,T2.TRADE_TIMESTAMP) <=10
AND T1.TRADE_ID <> T2.TRADE_ID
AND T1.TRADE_TIMESTAMP<T2.TRADE_TIMESTAMP
ORDER BY T1.TRADE_ID
