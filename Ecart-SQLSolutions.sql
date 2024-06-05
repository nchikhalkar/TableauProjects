select * from dbo.Sales
select * from dbo.Customer
select * from dbo.Product

--New column called Delivery time taken was calculated using SQL datediff function as shown below :

SELECT *, ROUND((DATEDIFF(SECOND, order_date, ship_date) / 86400.0), 2) AS delivery_time
FROM dbo.Sales

--Average delivery time required by our company to deliver products in each state.

SELECT state, ROUND(AVG(delivery_time), 0) AS avg_delivery_time
FROM dbo.Customer
JOIN dbo.Sales ON dbo.Customer.customer_ID = dbo.Sales.customer_id
GROUP BY state;

--The most preferred ship mode and delivery time taken by them.

select ship_mode, ROUND(AVG(delivery_time), 0) AS avg_delivery_time
from dbo.Sales
group by ship_mode

-- Calulated revenue 
SELECT customer_id, SUM(CAST(sales AS decimal(18, 2)) * CAST(quantity AS int)) AS revenue
FROM dbo.Sales
GROUP BY customer_id;

ALTER TABLE dbo.Sales
ADD revenue int;

update  dbo.Sales
set revenue = CAST(sales AS decimal(18, 2)) * CAST(quantity AS int)

--Revenue generated from each state.
select sum(revenue) as "revenue by state", state
from dbo.Customer
join dbo.Sales on dbo.Customer.customer_id=dbo.Sales.customer_id
group by state

--Quantity bought and Revenue generated from each customer

SELECT sum(quantity) AS total_items_bought, sum(revenue) AS revenue_generated, customer
FROM dbo.Customer
JOIN dbo.Sales ON dbo.Customer.customer_id = dbo.Sales.customer_id
GROUP BY customer;


--Revenue for different quarters and years.

SELECT YEAR(order_date) AS [year], SUM(revenue) AS revenue_generated
FROM dbo.Sales
GROUP BY YEAR(order_date);

--Quantities sold and Revenue generated from different subcategories

select sub_category, sum(quantity) as Quantity_of_subcategory_products_sold, sum(revenue) as revenue_from_sub_categories
from dbo.Product
join dbo.Product on product.product_id=dbo.Sales.product_id
group by sub_category;

--Quantities sold and Revenue generated from different Categories
   
select category, sum(quantity) as Quantity_of_category_products_sold, sum(revenue) as revenue_from_categories
from dbo.Product
join dbo.Product on dbo.Product.product_id=dbo.Sales.product_id
group by category;