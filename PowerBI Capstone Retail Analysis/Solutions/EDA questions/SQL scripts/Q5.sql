-- Analysing seasonal trends


 with month_name as 
		(select 
				 orderNumber,
                 monthname(orderDate) as month from orders),
	 total_order as
		( select orderNumber
                ,count(productCode) as product_count from orderdetails
		group by 1)
 select m.month,sum(t.product_count) as Products_Ordered
 from month_name m
 join total_order t
 on m.orderNumber = t.orderNumber
 group by 1;
 
 select orderNumber,count(*) from orderdetails
 group by 1;

-- Identifying best selling products

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


-- Calculate profitability for each product
with cte as 
(SELECT
    p.productName,
    SUM(od.quantityOrdered) AS TotalQuantitySold,
     round(SUM(od.quantityOrdered * od.priceEach)) as Revenue,
    round(SUM(od.quantityOrdered * (od.priceEach - p.buyPrice))) AS Profit
FROM
    Products p
JOIN
    OrderDetails od ON p.productCode = od.productCode
GROUP BY 1)
select productName,TotalQuantitySold,Revenue,Profit,
		round((Profit/Revenue) * 100) as Profit_Percentage
from cte
group by 1
order by 5 desc
limit 10;