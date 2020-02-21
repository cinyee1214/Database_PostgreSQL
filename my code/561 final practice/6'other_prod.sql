with t as
(
	(select distinct prod, 1 as month
	 from sales
	 where year = 2005) 
	union
	(select distinct prod, 2 as month
	 from sales
	 where year = 2005)
	union
	(select distinct prod, 3 as month
	 from sales
	 where year = 2005) 
	union
	(select distinct prod, 4 as month
	 from sales
	 where year = 2005)
	union
	(select distinct prod, 5 as month
	 from sales
	 where year = 2005) 
	union
	(select distinct prod, 6 as month
	 from sales
	 where year = 2005)
	union
	(select distinct prod, 7 as month
	 from sales
	 where year = 2005) 
	union
	(select distinct prod, 8 as month
	 from sales
	 where year = 2005)
	union
	(select distinct prod, 9 as month
	 from sales
	 where year = 2005) 
	union
	(select distinct prod, 10 as month
	 from sales
	 where year = 2005)
	union
	(select distinct prod, 11 as month
	 from sales
	 where year = 2005) 
	union
	(select distinct prod, 12 as month
	 from sales
	 where year = 2005)
),
t1 as
(
	select prod, month, 
	       (select avg(quant)
		    from sales s
			where s.prod != t.prod and s.month = t.month
		   ) as avg_q
	from t
),
t2 as
(
select prod as product, month,
        (select count(*) 
		 from sales as s
		 where s.year = 2005 and s.prod = t1.prod and s.month = t1.month - 1 and s.quant > t1.avg_q
		) as before_tot,
		(select count(*) 
		 from sales as s
		 where s.year = 2005 and s.prod = t1.prod and s.month = t1.month + 1 and s.quant > t1.avg_q
		) as after_tot
from t1
order by product, month
)
select *
from t2
where before_tot != 0 or after_tot != 0












