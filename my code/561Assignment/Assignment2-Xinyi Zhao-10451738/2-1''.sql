select  cust as customer, prod as product, state, round (avg(quant)) as cust_avg,
        (select round (avg(quant))
		 from sales s1 
		 where s1.cust = s.cust and s1.prod = s.prod and s1.state != s.state 
		) as other_state_avg, 
		(select round (avg(quant))
		 from sales s1 
		 where s1.cust = s.cust and s1.state = s.state and s1.prod != s.prod
		) as other_prod_avg
from sales s
group by cust, prod, state
order by customer, product, state