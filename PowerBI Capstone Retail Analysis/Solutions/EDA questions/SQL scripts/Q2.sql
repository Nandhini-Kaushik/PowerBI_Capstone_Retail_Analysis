with purchase as
(
SELECT o.customerNumber,
	    o.orderNumber,
	    od.quantityOrdered,
        od.priceEach,
        round(od.quantityOrdered * od.priceEach,2) as Purchase_Amount
FROM orderdetails od
join orders o
on od.orderNumber = o.orderNumber
)
select c.country,
	   count(distinct p.customerNumber) as No_of_Customers,
	   count(distinct(p.orderNumber)) as No_of_orders,
       round(sum(p.Purchase_Amount)) as Total_Sales,
       round(sum(p.Purchase_Amount)/count(*)) as Average_Order_Value
from purchase p
join customers c
on c.customerNumber = p.customerNumber
group by 1
order by 4 desc;