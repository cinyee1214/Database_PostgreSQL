select distinct cust as customer,
                prod as product,
				(select sum(quant) as q1_total
				 from sales s
				 where s.cust = s1.cust and s.prod = s1.prod and s.month between 1 and 3 
				),
				(select sum(quant) as q2_total
				 from sales s
				 where s.cust = s1.cust and s.prod = s1.prod and s.month between 4 and 6
				),
				(select sum(quant) as q3_total
				 from sales s
				 where s.cust = s1.cust and s.prod = s1.prod and s.month between 7 and 9 
				),
				(select sum(quant) as q4_total
				 from sales s
				 where s.cust = s1.cust and s.prod = s1.prod and s.month between 10 and 12 
				)
from sales as s1
order by cust, prod