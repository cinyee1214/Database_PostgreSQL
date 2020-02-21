with T1 as
(
	select prod, month, sum(quant) as total
	from sales
	group by prod, month
),
T2 as
(
	select prod, max(total), min(total)
	from T1
	group by prod
),
T3 as
(
	select T2.prod, T1.month, T2.min
	from T2, T1
	where T2.prod = T1.prod and T2.max = T1.total 
)
select T3.prod, T3.month as most_fav_mo, T1.month as least_fav_mo
from T3, T1
where T3.prod = T1.prod and T3.min = T1.total 
order by T3.prod
