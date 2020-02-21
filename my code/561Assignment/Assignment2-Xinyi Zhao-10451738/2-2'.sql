with t as 
(
	(select cust, prod, 1 as Q
	 from sales
	 group by cust, prod)
	union
	(select cust, prod, 2 as Q
	 from sales
	 group by cust, prod)
	union
	(select cust, prod, 3 as Q
	 from sales
	 group by cust, prod)
	union
	(select cust, prod, 4 as Q
	 from sales
	 group by cust, prod)
	order by cust, prod, Q
)
select t.cust, t.prod, t.Q, 
       (select round (avg(quant))
	           from sales as s
		       where t.cust = s.cust and t.prod = s.prod and s.month between ((t.Q - 1) * 3 - 2) and (t.Q - 1) * 3
       ) as before_avg, 
	   (select round (avg(quant))
	           from sales as s
		       where t.cust = s.cust and t.prod = s.prod and s.month between ((t.Q + 1) * 3 - 2) and (t.Q + 1) * 3
	   ) as after_avg
from t

