# Descriptive analysis on E-cart company data
**Business Task**

Our e-cart business head wants our data analytics team to perform descriptive analysis to find out how the business has been running. As a final deliverable, we are expected to provide insights in the form of an interactive and dynamic dashboard displaying the below information and KPIs.

The interactive & dynamic dashboard should include :

· Average delivery time required by our company to deliver products in each state.

· The most preferred ship mode and delivery time taken by them.

.  Revenue generated from each state. 

· Revenue for different quarters and years.

· Quantity bought and Revenue generated from each customer

· Quantities sold and Revenue generated from different subcategories and categories separately.

**DATA COLLECTION**

Data has been collected from a Udemy course which is made available provided by Start-Tech Academy.

There are 3 files namely : SALES, CUSTOMERS AND PRODUCTS.

**DATA WRANGLING**

Data was cleaned using SQL and Excel. I cleaned data for further analysis in the following ways :

Functions like =month(date) and =year(date) were used to extract month and year respectively in new columns.

New column called Delivery time taken was calculated using SQL epoch function as shown below :

     SELECT *, ROUND((DATEDIFF(SECOND, order_date, ship_date) / 86400.0), 2) AS delivery_time
     FROM dbo.Sales

Values from some columns were formatted to numeric format using Excel menu options.

Data Validation Checks performed using excel menu:

· Checked for any null values.
· Checked for any duplicates.
. checked for spelling errors.
DATA ANALYSIS

Descriptive analysis was done using MS SQL to fetch insights from data and answer the business requirements.

**Creating Tables**
Creating All (Sales, Customer, Product) Table and importing corresponding data files

**Descriptive analysis**

Average delivery time required by our company to deliver products in each state.

    SELECT state, ROUND(AVG(delivery_time), 0) AS avg_delivery_time
    FROM dbo.Customer
    JOIN dbo.Sales ON dbo.Customer.customer_ID = dbo.Sales.customer_id
    GROUP BY state;
    
The most preferred ship mode and delivery time taken by them.

     select ship_mode, ROUND(AVG(delivery_time), 0) AS avg_delivery_time
     from dbo.Sales
     group by ship_mode
Calulated revenue 

     SELECT customer_id, SUM(CAST(sales AS decimal(18, 2)) * CAST(quantity AS int)) AS revenue
     FROM dbo.Sales
     GROUP BY customer_id;          
     
     ALTER TABLE dbo.Sales
     ADD revenue int;
     
     update  dbo.Sales
     set revenue = CAST(sales AS decimal(18, 2)) * CAST(quantity AS int)

Revenue generated from each state.

     select sum(revenue) as "revenue by state", state
     from dbo.Customer
     join dbo.Sales on dbo.Customer.customer_id=dbo.Sales.customer_id
     group by state

Quantity bought and Revenue generated from each customer

     SELECT SUM(quantity) AS [total items bought], SUM(revenue) AS revenue_generated, customer
     FROM dbo.Customer
     JOIN dbo.Sales ON dbo.Customer.customer_id = dbo.Sales.customer_id
     GROUP BY customer;

Revenue for different quarters and years.

     SELECT YEAR(order_date) AS [year], SUM(revenue) AS revenue_generated
     FROM dbo.Sales
     GROUP BY YEAR(order_date);
     
Quantities sold and Revenue generated from different subcategories

     select sub_category, sum(quantity) as Quantity_of_subcategory_products_sold, sum(revenue) as revenue_from_sub_categories
     from dbo.Product
     join dbo.Product on product.product_id=dbo.Sales.product_id
     group by sub_category

Quantities sold and Revenue generated from different Categories
   
     select category, sum(quantity) as Quantity_of_category_products_sold, sum(revenue) as revenue_from_categories
     from dbo.Product
     join dbo.Product on dbo.Product.product_id=dbo.Sales.product_id
     group by category


