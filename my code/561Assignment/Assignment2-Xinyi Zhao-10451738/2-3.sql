with t as
(
	select prod, quant, 
	       (select count(*) 
			  from sales as s1 
			  where s.prod = s1.prod and s1.quant <= s.quant) as order_num,
	       (select count(*) 
			  from sales as s1 
			  where s1.prod = s.prod) as total_count
    from sales as s
    order by prod, quant
)
select prod as product, quant as median_quant
from t
where order_num = total_count / 2 + 1




