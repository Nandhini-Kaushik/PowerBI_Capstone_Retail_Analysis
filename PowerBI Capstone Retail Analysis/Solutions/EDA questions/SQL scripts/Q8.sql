with cte as 
		(select o.orderNumber
			    ,c.country
				,c.city
			from customers c
            join orders o
            on o.customerNumber = c.customerNumber),
orders as  
		(select od.orderNumber,
        	   count(od.productCode) as No_of_products
from orderdetails od
join products p
on od.productCode = p.productCode
group by 1
order by 2 desc),
productline as 
			( select od.orderNumber,p.productLine 
              from products p 
              join orderdetails od
              on od.productCode = p.productCode)
select p.productLine
	   ,c.country 
       ,c.city
       ,o.No_of_products
from cte c
join orders o 
on o.orderNumber = c.orderNumber
join productline p
on p.orderNumber = o.orderNumber
order by 4 desc;

