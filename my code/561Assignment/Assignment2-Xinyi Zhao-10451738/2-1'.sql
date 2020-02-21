with t as
(
	select cust, prod, state, round (avg(quant)) as cust_avg
	from sales
	group by cust, prod, state
)
select  cust as customer, prod as product, state, cust_avg,
        (select round (avg(s.quant))
		 from sales s 
		 where t.cust = s.cust and t.prod = s.prod and t.state != s.state 
		) as other_state_avg, 
		(select round (avg(s.quant))
		 from sales s 
		 where t.cust = s.cust and t.state = s.state and t.prod != s.prod
		) as other_prod_avg
from t
order by customer, product, state