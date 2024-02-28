use retail_analysis;
SELECT 
    c.country
    , c.city
    , p.productLine
    , COUNT(*) AS No_of_products
    , round(sum(quantityOrdered * priceEach)) as Total_Spent
FROM
    customers c
        JOIN
    orders o ON c.customerNumber = o.customerNumber
        JOIN
    orderdetails od ON od.orderNumber = o.orderNumber
        JOIN
    products p ON p.productCode = od.productCode
GROUP BY 1 , 2 , 3
ORDER BY 4 DESC;