select c.country 
	   ,count(distinct o.orderNumber) as No_of_orders
       ,sum(round(od.quantityOrdered * od.priceEach)) as Total_Sales
       ,round(sum(od.quantityOrdered * od.priceEach)/count(*)) as Average_order_value
from orderdetails od
join products p
on p.productCode = od.productCode
join orders o 
on o.orderNumber = od.orderNumber
join customers c
on c.customerNumber = o.customerNumber
group by 1
order by 2 desc;

select p.productName 
	   ,count(distinct o.orderNumber) as No_of_orders
       ,sum(round(od.quantityOrdered * od.priceEach)) as Total_Sales
       ,round(sum(od.quantityOrdered * od.priceEach)/count(*)) as Average_order_value
from orderdetails od
join products p
on p.productCode = od.productCode
join orders o 
on o.orderNumber = od.orderNumber
group by 1
order by 2 desc
limit 3;

