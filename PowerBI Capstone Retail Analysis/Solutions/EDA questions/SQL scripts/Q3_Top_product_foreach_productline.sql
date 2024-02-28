with cte as
		(select  p.productLine,productName,
				 sum(round(od.quantityOrdered * od.priceEach)) as Total_sales,
                 rank() over (	partition by productLine 
								order by sum(round(od.quantityOrdered * od.priceEach)) desc) as Rnk
		from orderdetails od
		join products p 
		on p.productCode = od.productCode
		group by 1,2)
select productline,productName,Total_sales from cte
where Rnk = 1;