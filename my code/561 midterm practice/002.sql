with t1 as(
select cust, prod, sum(quant) as jan_total
	from sales
	where month = 1
	group by cust, prod
),
t2 as(
select cust, prod, max(quant) as feb_max
	from sales
	where month = 2
	group by cust, prod
),
t3 as(
select t2.cust, t2.prod, t2.feb_max, s.year, s.day
	from sales as s, t2
	where t2.cust = s.cust and t2.prod = s.prod and s.month = 2 and t2.feb_max = s.quant
),
t4 as(
select cust, prod, min(quant) as mar_min
	from sales
	where month = 3
	group by cust, prod
),
t5 as(
select t4.cust, t4.prod, t4.mar_min, s.year, s.day
	from sales as s, t4
	where t4.cust = s.cust and t4.prod = s.prod and s.month = 3 and t4.mar_min = s.quant
)
select cust as customer,
       prod as product,
	   t1.jan_total,
	   t3.feb_max,
	   t3.year as feb_max_year,
	   t3.day as feb_max_day,
	   t5.mar_min,
	   t5.year as mar_min_year,
	   t5.day as mar_min_day
	from t1 full outer join t3 using (cust, prod)
	        full outer join t5 using (cust, prod)
