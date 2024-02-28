use retail_analysis;
select c.customerName, sum(round(od.quantityOrdered * od.priceEach)) AS Total_Sales
from customers c
join orders o
on c.customerNumber = o.customerNumber
join orderdetails od
on od.orderNumber = o.orderNumber
group by 1
order by 2 desc
limit 10;

