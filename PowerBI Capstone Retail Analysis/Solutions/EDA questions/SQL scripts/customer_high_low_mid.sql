-- Determine value categories based on total spend percentiles

with cte as (
        SELECT
            o.customerNumber,
            round(SUM(quantityOrdered * priceEach)) AS totalSpend
        FROM
            orderDetails od
		join orders o
        on o.orderNumber = od.orderNumber
        GROUP BY
            customerNumber
    ) ,
    cus_category as
    (
    SELECT
	customerNumber,
    totalSpend,
    CASE
        WHEN percent_rank() OVER (ORDER BY totalSpend) <= 0.2 THEN 'Low-Value'
        WHEN percent_rank() OVER (ORDER BY totalSpend) <= 0.8 THEN 'Medium-Value'
        ELSE 'High-Value'
    END AS valueCategory
    from cte
    order by 2 desc)
    select cc.* 
		   ,c.creditLimit
           ,c.country
    from cus_category cc
    join customers c
    on c.customerNumber = cc.customerNumber
    where valueCategory = "High-Value"
    order by 2 desc;
    
