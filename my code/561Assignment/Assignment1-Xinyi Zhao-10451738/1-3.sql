with T1 as
(
	select month, prod, sum(quant) as total
	from sales
	group by month, prod
),
T2 as
(
	select month, max(total), min(total)
	from T1
	group by month
),
T3 as
(
	select T2.month, T1.prod, T2.max, T2.min
	from T2, T1
	where T2.month = T1.month and T2.max = T1.total
)
select T3.month, T3.prod as most_pop_prod, T3.max as most_pop_total, T1.prod as least_pop_prod, T3.min as least_pop_total
from T3, T1
where T3.month = T1.month and T3.min = T1.total
order by month