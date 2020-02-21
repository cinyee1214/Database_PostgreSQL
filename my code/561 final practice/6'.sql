with t as
(select distinct prod, month, 
        (select round(avg(s.quant))
		 from sales as s
		 where s.prod != sales.prod and s.month = sales.month
		) as avg_q
 from sales
 where year = 2005
),
t1 as
(select prod as product, month,
        (select count(*) 
		 from sales as s
		 where s.year = 2005 and s.prod = t.prod and s.month = t.month - 1 and s.quant > t.avg_q
		) as before_tot,
		(select count(*) 
		 from sales as s
		 where s.year = 2005 and s.prod = t.prod and s.month = t.month + 1 and s.quant > t.avg_q
		) as after_tot
from t
order by product, month
)
select *
from t1
where before_tot != 0 or after_tot != 0