with T as
(
	select cust, prod, month, sum(quant), count(*) 
	from sales
	group by cust, prod, month
),
S as
(
	select T.cust, T.prod, sum(T.sum) as total, sum(count) as count
	from T
	group by T.cust, T.prod 
),
T1 as
(
	select T.cust, T.prod, cast(sum(T.sum)/sum(T.count) as integer) as Q1
	from T
	where month between 1 and 3
	group by T.cust, T.prod
),
T2 as
(
	select T.cust, T.prod, cast(sum(T.sum)/sum(T.count) as integer) as Q2
	from T
	where month between 4 and 6
	group by T.cust, T.prod
),
T12 as
(
	select cust, prod, T1.Q1, T2.Q2
	from T1 full outer join T2 using(cust, prod)
),
T3 as
(
	select T.cust, T.prod, cast(sum(T.sum)/sum(T.count) as integer) as Q3
	from T
	where month between 7 and 9
	group by T.cust, T.prod
),
T4 as
(
	select T.cust, T.prod, cast(sum(T.sum)/sum(T.count) as integer) as Q4
	from T
	where month between 10 and 12
	group by T.cust, T.prod
),
T34 as
(
	select cust, prod, T3.Q3, T4.Q4
	from T3 full outer join T4 using(cust, prod)
),
T14 as
(
	select cust, prod, T12.Q1, T12.Q2, T34.Q3, T34.Q4
	from T12 full outer join T34 using(cust, prod)
)
	select S.cust as customer, 
           S.prod as product, 
		   T14.Q1 as Q1_avg, 
		   T14.Q2 as Q2_avg, 
		   T14.Q3 as Q1_avg, 
		   T14.Q4 as Q1_avg,
		   cast (S.total/S.count as integer) as average, 
		   S.total, 
		   S.count
	from S, T14
	where S.cust = T14.cust and S.prod = T14.prod


	
	