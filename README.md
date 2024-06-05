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
    

