with t1 as(
select cust, prod, sum(quant) as q1_total
	from sales
	where year = 2009 and month between 1 and 3
	group by cust, prod
),
t2 as(
select cust, prod, sum(quant) as q2_total
	from sales
	where year = 2009 and month between 4 and 6
	group by cust, prod
),
t3 as(
select cust, prod, sum(quant) as q3_total
	from sales
	where year = 2009 and month between 7 and 9
	group by cust, prod
),
t4 as(
select cust, prod, sum(quant) as q4_total
	from sales
	where year = 2009 and month between 10 and 12
	group by cust, prod
)
select cust as customer,
       prod as product,
	   t1.q1_total,
	   t2.q2_total,
	   t3.q3_total,
	   t4.q4_total
	 from t1 full outer join t2 using (cust, prod)
	         full outer join t3 using (cust, prod)
			 full outer join t4 using (cust, prod)
			 
