with cte as
		(select  p.productLine,productName,
				 sum(round(od.quantityOrdered * od.priceEach)) as Total_sales,
                 rank() over (partition by productLine order by sum(round(od.quantityOrdered * od.priceEach)) desc) as Rank_by_Sales
		from orderdetails od
		join products p 
		on p.productCode = od.productCode
		group by 1,2)
select * from cte
where Rank_by_Sales = 1;