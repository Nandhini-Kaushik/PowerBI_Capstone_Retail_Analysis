-- Analyze purchasing patterns based on location
SELECT
    c.city,
    c.country,
    COUNT(DISTINCT o.customerNumber) AS unique_customers,
    COUNT(o.orderNumber) AS total_orders,
    SUM(od.quantityOrdered) AS total_items_ordered,
    round(SUM(od.priceEach * od.quantityOrdered)) AS total_spent
FROM
    customers c
JOIN
    orders o ON c.customerNumber = o.customerNumber
JOIN
    orderdetails od ON o.orderNumber = od.orderNumber
GROUP BY
    1,2
ORDER BY
    total_spent DESC;


-- Analyze purchasing patterns based on credit limit
SELECT
    c.creditLimit,
    COUNT(DISTINCT o.customerNumber) AS unique_customers,
    COUNT(o.orderNumber) AS total_orders,
    SUM(od.quantityOrdered) AS total_items_ordered,
    round(SUM(od.priceEach * od.quantityOrdered)) AS total_spent
FROM
    customers c
JOIN
    orders o ON c.customerNumber = o.customerNumber
JOIN
    orderdetails od ON o.orderNumber = od.orderNumber
GROUP BY
    1
ORDER BY
    total_spent DESC;
