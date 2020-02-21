with t1 as(
select cust, prod, max(quant), cast(avg(quant) as integer) 
	from sales
	where year = 2001 or year = 2002 or year = 2003
	group by cust, prod
)
select t1.cust, t1.prod, t1.max as max_q, s.state, t1.avg as avg_q
from sales as s, t1
where t1.cust = s.cust and t1.prod = s.prod and t1.max = s.quant