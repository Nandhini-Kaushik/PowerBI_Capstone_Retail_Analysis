select e.employeeNumber,
	   sum(round(od.quantityOrdered * od.priceEach)) as Total_sales
from employees e 
join customers c
on c.salesRepEmployeeNumber = e.employeeNumber
join orders o 
on o.customerNumber = c.customerNumber
join orderdetails od
on od.orderNumber = o.orderNumber
group by 1
order by 2 desc;