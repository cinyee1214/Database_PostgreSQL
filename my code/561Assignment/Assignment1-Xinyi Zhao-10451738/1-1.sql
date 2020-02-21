with temp1 as
(
select prod, max(quant), min(quant), avg(quant) 
	from sales
	group by prod
),
temp2 as
(
select T.prod, T.max, S.cust, S.day, S.month, S.year, S.state, T.min, T.avg
	from temp1 as T, sales as S
	where T.prod = S.prod and T.max = S.quant
)
select T2.prod as PRODUCT, 
       T2.max as MAX_Q, 
	   T2.cust as MAX_CUST, 
	   T2.day as MAX_day, 
	   T2.month as MAX_month, 
	   T2.year as MAX_year, 
	   T2.state as MAX_ST, 
	   T2.min as MIN_Q, 
	   S.cust as MIN_CUST,
	   S.day as MIN_day, 
	   S.month as MIN_month, 
	   S.year as MIN_year, 
	   S.state as MIN_ST, 
	   round (T2.avg) as AVG_Q      
from temp2 as T2, sales as S
where T2.prod = S.prod and T2.min = S.quant
    
	
	
	
	