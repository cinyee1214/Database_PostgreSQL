with t1 as
(
select cust, prod, max(quant)
	from sales
	where state = 'NY'
	group by cust, prod
),
t2 as
(
select t1.cust, t1.prod, t1.max, s.day, s.month, s.year
	from sales as s, t1
	where t1.cust = s.cust and t1.prod = s.prod and t1.max = s.quant and s.state = 'NY'
),
t3 as 
(
select cust, prod, min(quant)
	from sales
	where state = 'NJ' and year > 2000
	group by cust, prod
),
t4 as
(
select t3.cust, t3.prod, t3.min, s.day, s.month, s.year
	from sales as s, t3
	where t3.cust = s.cust and t3.prod = s.prod and t3.min = s.quant and s.state = 'NJ'
),
t5 as
(
select cust, prod, min(quant)
	from sales
	where state = 'CT' and year > 2000
	group by cust, prod
),
t6 as
(
select t5.cust, t5.prod, t5.min, s.day, s.month, s.year
	from sales as s, t5
	where t5.cust = s.cust and t5.prod = s.prod and t5.min = s.quant and s.state = 'CT'
)
select cust as customer, 
        prod as product, 
 	   T2.max as ny_max, 
 	   T2.day as ny_day, 
 	   T2.month as ny_month, 
	   T2.year as ny_year, 
 	   T4.min as nj_min, 
 	   T4.day as nj_day, 
 	   T4.month as nj_month, 
 	   T4.year as nj_year, 
 	   T6.min as ct_min, 
	   T6.day as ct_day, 
 	   T6.month as ct_month, 
 	   T6.year as ct_year
 	from t2 full outer join t4 using (cust, prod)
	        full outer join t6 using (cust, prod)
	order by customer
	
	

