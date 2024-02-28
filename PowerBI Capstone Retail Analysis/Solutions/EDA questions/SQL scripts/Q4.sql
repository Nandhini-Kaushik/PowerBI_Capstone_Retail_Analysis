use retail_analysis;
select  p.productName
	   ,p.productVendor
	   ,sum(od.quantityOrdered) as Sales_Volume
from orderdetails od
join products p 
on od.productCode = p.productCode
group by 1,2
order by 3 desc;

with cte as (select  productName
	   ,productLine
       ,productVendor
       ,productCode
	   ,round(MSRP - buyPrice) as Difference 
from products
order by 4 desc),
cte1 as (select productCode,
		sum(quantityOrdered) as salesvolume
from orderdetails
group by 1)
select c1.productLine,
		c1.productName,
        c1.Difference,
        c1.productVendor,
        c2.salesvolume
from cte c1
join cte1 c2
on c1.productCode = c2.productCode
order by 5 desc
limit 10;