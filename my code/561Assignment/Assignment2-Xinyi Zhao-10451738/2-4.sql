with t as 
(
	select distinct cust, prod, month,
			 (select sum(quant)
			     from sales as s1
			     where s.cust = s1.cust and s.prod = s1.prod and s1.month <= s.month) as present_total, 	 
			 (select sum(quant) 
			     from sales as s1 
			     where s.cust = s1.cust and s.prod = s1.prod) as total
	from sales as s
	order by cust, prod, month
),
t1 as 
(
	select cust, prod, month 
    from t
    where present_total >= total * (2.0 / 3)
)
select cust as customer, prod as product, min(month) as "2/3 purchased by month"
from t1
group by cust, prod
