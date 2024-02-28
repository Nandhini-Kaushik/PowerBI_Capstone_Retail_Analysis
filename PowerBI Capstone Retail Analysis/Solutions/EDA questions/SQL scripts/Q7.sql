use retail_analysis;
with cte as
		(select o.customerNumber
				,productCode
                ,count(productCode)
		from orders o
		join orderdetails od
		on o.orderNumber = od.orderNumber
		group by 1,2
		having count(productCode) > 1
		order by 3 desc),
	diff as 
		(select productCode,
				round(sum(MSRP- buyPrice)) as difference
		from products
        group by 1)
select ct.*
	   ,p.productVendor
       ,d.difference
       ,c.country
       ,c.creditLimit
       ,c.city
from products p
join cte ct
on ct.productCode = p.productCode
join diff d
on d.productCode = ct.productCode
join customers c
on c.customerNumber = ct.customerNumber
order by 3 desc;
 
 -- Calculate Repeat Purchase Rate for Each Product
SELECT
    p.productCode,
    COUNT(DISTINCT od.orderNumber) AS total_orders,
    COUNT(DISTINCT o.customerNumber) AS total_customers,
    COUNT(DISTINCT od.orderNumber) / COUNT(DISTINCT o.customerNumber) AS repeat_purchase_rate
FROM
    products p
JOIN
    orderdetails od ON p.productCode = od.productCode
join 
	orders o on o.orderNumber = od.orderNumber
GROUP BY
    p.productCode
ORDER BY
    repeat_purchase_rate DESC;
