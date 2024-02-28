use retail_analysis;
with cte as
	(select c.country
	   ,c.city
       ,od.productCode
       ,sum(round(od.quantityOrdered * od.priceEach)) as Total_Sales
       ,count(od.productCode)
from customers c
join orders o
on c.customerNumber = o.customerNumber
join orderdetails od 
on o.orderNumber = od.orderNumber
group by 1,2,3
order by 5),
Under_performing as (
select *
		, case
				when Total_Sales < 600 then "Yes"
                else "No" 
                end as Under_Performing_products
from cte)
select * from Under_performing where Under_Performing_products = "Yes";