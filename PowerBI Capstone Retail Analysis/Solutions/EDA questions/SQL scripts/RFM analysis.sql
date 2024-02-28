-- RECENCY

SELECT
    customerNumber,
    MAX(orderDate) AS recency
FROM
    orders
GROUP BY
    customerNumber
order by
	1;


-- FREQUENCY

SELECT
    c.customerNumber,
    c.customerName,
    COUNT(DISTINCT o.orderNumber) AS frequency
FROM
    orders o
	JOIN
    customers c
    ON c.customerNumber = o.customerNumber
GROUP BY
    customerNumber,2
ORDER BY 
	3 desc;
    
    -- MONETARY
    
SELECT
    c.customerNumber,
    c.customerName,
    ROUND(SUM(od.quantityOrdered * od.priceEach)) AS monetary
FROM
    orderdetails od
JOIN 
	orders o
ON o.orderNumber = od.orderNumber
JOIN
    customers c
    ON c.customerNumber = o.customerNumber
GROUP BY
    customerNumber,2
ORDER BY 
	3 DESC;

