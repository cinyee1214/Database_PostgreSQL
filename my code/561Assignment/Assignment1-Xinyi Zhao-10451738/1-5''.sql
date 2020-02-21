select cust as customer, prod as product, 
	    (select round (avg(quant))
		 from sales s1
		 where s.cust = s1.cust and s.prod = s1.prod and month between 1 and 3
		) as q1_avg,
	    (select round (avg(quant))
		 from sales s1
		 where s.cust = s1.cust and s.prod = s1.prod and month between 4 and 6
		) as q2_avg,
	    (select round (avg(quant))
		 from sales s1
		 where s.cust = s1.cust and s.prod = s1.prod and month between 7 and 9
		) as q3_avg,
	    (select round (avg(quant))
		 from sales s1
		 where s.cust = s1.cust and s.prod = s1.prod and month between 10 and 12
		) as q4_avg,
	    round (avg(quant)) as average, 
	    sum(quant) as total,
	    count(quant)
from sales s
group by cust, prod
order by cust, prod


