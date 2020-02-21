with temp1 as
(
select cust, prod, max(quant) as ny_max
	from sales
	where state = 'NY'
	group by cust, prod
),
temp2 as
(
select T1.cust, T1.prod, T1.ny_max, S.day, S.month, S.year
	from temp1 as T1, sales as S
	where T1.cust = S.cust and T1.prod = S.prod and T1.ny_max = S.quant and S.state = 'NY'
),
temp3 as
(
select cust, prod, min(quant) as nj_min
	from sales
	where state = 'NJ' and year > 2000
	group by cust, prod
),
temp4 as
(
select T3.cust, T3.prod, T3.nj_min, S.day, S.month, S.year
	from temp3 as T3, sales as S
	where T3.cust = S.cust and T3.prod = S.prod and T3.nj_min = S.quant and and S.state = 'NJ'
),
temp5 as
(
select cust, prod, min(quant) as ct_min
	from sales
	where state = 'CT' and year > 2000
	group by cust, prod
),
temp6 as
(
select T5.cust, T5.prod, T5.ct_min, S.day, S.month, S.year
	from temp5 as T5, sales as S
	where T5.cust = S.cust and T5.prod = S.prod and T5.ct_min = S.quant and and S.state = 'CT'
),
T24 as
(
select cust, prod, T2.ny_max, T2.day as ny_day, T2.month as ny_month, T2.year as ny_year, T4.nj_min, T4.day, T4.month, T4.year
	from temp2 as T2 full outer join temp4 as T4 using(cust, prod)
)
select cust as customer, 
       prod as product, 
	   T24.ny_max, 
	   T24.ny_day, 
	   T24.ny_month, 
	   T24.ny_year, 
	   T24.nj_min, 
	   T24.day as nj_day, 
	   T24.month as nj_month, 
	   T24.year as nj_year, 
	   T6.ct_min, 
	   T6.day as ct_day, 
	   T6.month as ct_month, 
	   T6.year as ct_year
	from T24 full outer join temp6 as T6 using(cust, prod)
	order by customer






