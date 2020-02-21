with t1 as
(
select cust, prod, cast (avg(quant) as integer) as q1_avg
	from sales
	where month = 1 or month = 2 or month = 3
	group by cust, prod
),
t2 as
(
	select cust, prod, cast (avg(quant) as integer) as q2_avg
	from sales
	where month = 4 or month = 5 or month = 6
	group by cust, prod
),
t3 as
(
	select cust, prod, cast (avg(quant) as integer) as q3_avg
	from sales
	where month = 7 or month = 8 or month = 9
	group by cust, prod
),
t4 as
(
	select cust, prod, cast (avg(quant) as integer) as q4_avg
	from sales
	where month = 10 or month = 11 or month = 12
	group by cust, prod
),
t5 as
(
	select cust, prod, cast (avg(quant) as integer) as average, sum(quant), count(quant)
	from sales
	group by cust, prod 
)
select cust as customer, prod as product, t1.q1_avg, t2.q2_avg, t3.q3_avg, t4.q4_avg, t5.average, t5.sum as total, t5.count
from t5 full outer join t1 using(cust, prod)
        full outer join t2 using(cust, prod)
		full outer join t3 using(cust, prod)
		full outer join t4 using(cust, prod)
order by customer, product
		
		
		
		

