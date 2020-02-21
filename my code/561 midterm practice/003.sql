with t1 as (
select cust, cast(avg(quant) as integer) as ny_avg
	from sales
	where state = 'NY'
	group by cust
),
t2 as (
select cust, cast(avg(quant) as integer) as nj_avg
	from sales
	where state = 'NJ'
	group by cust
),
t3 as (
select cust, cast(avg(quant) as integer) as ct_avg
	from sales
	where state = 'CT'
	group by cust
)
select t1.cust as customer, t1.ny_avg, t2.nj_avg, t3.ct_avg
from t1, t2, t3
where t1.cust= t2.cust and t1.cust = t3.cust and t1.ny_avg > (t2.nj_avg + t3.ct_avg)