use MyDatabase

select * from customers 
where country = 'germany';

SELECT 
	ID,
	COUNTRY,
	score 
from customers 
order by country ASC,
score DESC;

select country,sum(score) as "Total scores" from customers where score >500 group by country

select 
	COUNT(id)as "ID",
	country,
	SUM(score) as "Total score"
from customers 
group by country

select 
country,
avg(score)as "Average Score"
From customers
where score != 0
group by country
having avg(score)>430;

select distinct(country) from customers;

select country,count(*) as"count1" from customers group by country order by count1 desc

select top 3 country,score from customers order by score desc

select id, first_name ,'customers data' as 'customer info' from customers