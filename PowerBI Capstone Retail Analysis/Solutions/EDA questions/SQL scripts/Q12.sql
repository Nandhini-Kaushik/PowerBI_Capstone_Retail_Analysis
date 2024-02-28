-- Customer preferences
SELECT 
    monthname(o.orderDate) AS Order_Month,
    c.customerNumber,
    c.country,
    p.productLine,
    p.productName,
    COUNT(od.productCode) AS Purchase_count,
    ROUND(SUM(od.quantityOrdered * od.priceEach)) AS Total_Spent
FROM
    customers c
        JOIN
    orders o ON c.customerNumber = o.customerNumber
        JOIN
    orderdetails od ON o.orderNumber = od.orderNumber
        JOIN
    products p ON od.productCode = p.productCode
    group by 1,2,3,4,5
    order by 7 desc;
    
-- Customer behaviour    
    
SELECT
    c.customerNumber,
    c.customerName,
    COUNT(o.orderNumber) AS total_orders,
    SUM(od.quantityOrdered) AS total_items_purchased,
    round(SUM(od.priceEach * od.quantityOrdered)) AS total_spent
FROM
    customers c
LEFT JOIN
    orders o ON c.customerNumber = o.customerNumber
LEFT JOIN
    orderdetails od ON o.orderNumber = od.orderNumber
GROUP BY
    1,2
ORDER BY
    3 DESC;
    
SELECT
    YEAR(o.orderDate) AS order_year,
    COUNT(DISTINCT c.customerNumber) AS unique_customers,
    COUNT(o.orderNumber) AS total_orders
FROM
    orders o
JOIN
    customers c ON o.customerNumber = c.customerNumber
GROUP BY
    order_year
ORDER BY
    order_year;

SELECT
    YEAR(orderDate) AS order_year,
    round(AVG(od.priceEach * od.quantityOrdered)) AS average_order_value
FROM
    orders o
JOIN
    orderdetails od ON o.orderNumber = od.orderNumber
GROUP BY
    order_year
ORDER BY
    order_year;

SELECT
    od1.productCode AS product_1,
    od2.productCode AS product_2,
    COUNT(*) AS purchase_count
FROM
    orderdetails od1
JOIN
    orderdetails od2 ON od1.orderNumber = od2.orderNumber
    AND od1.productCode < od2.productCode
GROUP BY
    product_1, product_2
ORDER BY
    purchase_count DESC;
    
    SELECT
    c.customerNumber,
    COUNT(DISTINCT o.orderNumber) AS order_frequency
FROM
    customers c
LEFT JOIN
    orders o ON c.customerNumber = o.customerNumber
GROUP BY
    c.customerNumber
ORDER BY
    order_frequency DESC;
    
SELECT
    c.customerNumber,
    ROUND(SUM(od.quantityOrdered * od.priceEach))  AS total_spent,
    COUNT(DISTINCT o.ordernumber) AS total_orders,
    round(AVG(od.priceEach * od.quantityOrdered)) AS average_order_value,
    DATEDIFF(MAX(o.orderDate), MIN(o.orderDate)) AS days_active,
    (ROUND(SUM(od.quantityOrdered * od.priceEach)) / COUNT(DISTINCT o.orderNumber)) * ((DATEDIFF(MAX(o.orderDate), MIN(o.orderDate))/365)) AS clv
FROM
    customers c
LEFT JOIN
    orders o ON c.customerNumber = o.customerNumber
LEFT JOIN
    orderdetails od ON o.orderNumber = od.orderNumber
GROUP BY
    c.customerNumber
ORDER BY
    clv DESC;


