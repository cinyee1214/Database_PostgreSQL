with t1 as
(
	select cust, prod, state, cast (avg(quant) as integer) as cust_avg
	from sales
	group by cust, prod, state
),
t2 as
(
	select t1.cust, t1.prod, t1.state, cust_avg, cast (avg(s.quant) as integer) as other_state_avg
	from t1, sales as s
	where t1.cust = s.cust and t1.prod = s.prod and t1.state != s.state 
	group by t1.cust, t1.prod, t1.state, cust_avg
),
t3 as
(
	select t1.cust, t1.prod, t1.state, cust_avg, cast (avg(s.quant) as integer) as other_prod_avg
	from t1, sales as s
	where t1.cust = s.cust and t1.state = s.state and t1.prod != s.prod
	group by t1.cust, t1.prod, t1.state, cust_avg
)
select  t2.cust as customer, t2.prod as product, t2.state, t2.cust_avg, other_state_avg, other_prod_avg
from t2, t3
where t2.cust = t3.cust and t2.cust_avg = t3.cust_avg
order by customer, product, state
