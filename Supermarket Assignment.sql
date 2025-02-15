SELECT * 
FROM project.`product id`;

SELECT * 
FROM orderid;

SELECT * 
FROM project.`customer id`;

SELECT * 
FROM project.`order book assignment`;

-- Total revenue generated by XYZ-----------

-- step1: Joining Order book table with product ID------------

select sum(ob.quantity * ob.unit_price) as Total_revenue
from orderbook as ob
join productid as pro on ob.product_id = pro.product_id
join orderid as ord on ob.order_id = ord.order_id;

-- step2: Which product category has generated the most revenue-----------
select pro.category, sum(ob.quantity * ob.unit_price) as Total_revenue
from orderbook as ob
join productid as pro on ob.product_id = pro.product_id
join orderid as ord on ob.order_id = ord.order_id
group by pro.category
order by Total_revenue desc
limit 1;


 -- What are the top 5 best-selling products based on quantity sold?----------
 select pro.product_name, sum(ob.quantity * ob.unit_price) as Total_quantity_sold
from orderbook as ob
join productid as pro on ob.product_id = pro.product_id
join orderid as ord on ob.order_id = ord.order_id
group by pro.product_id, pro.product_name
order by Total_quantity_sold desc
limit 5;

-- Customer Insights-------------------
-- 1. How many unique customers have made purchases---------------
select count(distinct customer_id) as unique_customers
from orderid;

-- 2. Which city has the highest number of customers?----------
select city, count(customer_id) as customer_count 
from customer_id
group by city 
order by customer_count desc
limit 1;

-- 3.  What is the average age of customers?----------
select avg(age) as average_age
from customer_id;

-- Order Analysis----------------
-- 1.  How many orders have been placed in the last year?------
select count(order_id) as total_orders
from orderid;

-- 2.   What is the average order value (total_amount)?------
select avg(total_amount) as average_order_value
from orderid;

-- 3. Which month has the highest total sales--------------------
select month(order_date) as month,
sum(total_amount) as Total_sales
from orderid
group by month (order_date)
order by Total_sales desc
limit 1;

-- Product Performance ---------------
-- 1. List all products that have never been sold.-------------
select  pro.product_id, pro.product_name, pro.category, pro.price
from productid as pro 
left join orderbook as ord on pro.product_id = ord.product_id
where ord.product_id is null;

-- 2. . Identify the top 3 customers who have spent the most.------------
select cus.customer_id, cus.customer_name,
sum(ord.total_amount) as Total_spent
from orderid as ord
join customer_id as cus on cus.customer_id = cus.customer_id
group by cus.customer_id, cus.customer_name
order by Total_spent desc
limit 3;

-- 3. Which product has the highest unit price?---------------------
select product_id, product_name, category, price
from productid
order by price desc
limit 1;

-- Customer Segmentation------------

-- 1. Group customers by age range (e.g., 18-25, 26-35, etc.) and find the total revenue generated by each age group.---------------------
select case
when cus.age between 18 and 25 then '18-25'
when cus.age between 26 and 35 then '26-35'
when cus.age between 35 and 50 then '35-50'
when cus.age between 50 and 65 then '50-65'
else '67+'
end as age_range, sum(ord.total_amount) as total_revenue
from customer_id as cus
join orderid as ord on cus.customer_id
group by age_range
order by age_range;

-- 2.Find the percentage of male and female customers.--------
select gender,
COUNT(*) * 100.0 / (select count(*) from customer_id) as percentage
from customer_id
group by gender;


-- summary of Project-------------

1. Total Revenue Generated ------------  '248226.77000000002'

2. Product Category with the highest Revenue 'Electronics', '108814.43999999997'

3. Top 5 best_selling Products by Quantity sold Product_19	13500.25
Product_35	11434.55
Product_47	10491.399999999998
Product_28	9085.880000000001
Product_9	8364.33

4. unique customers who made purchases '62'

5. City with the highest number of customers

6. Average Age of customers 'Chicago', '26'

7. Number of orders placed in the last year '100'

8. Average order Value (Total amount) '1043.3809'

9. Month with the Highest Total sales '2', '31969.37'

10. Products that have never been sold 4	Product_4	Home Appliances	747.96
5	Product_5	Home Appliances	352.89
13	Product_13	Home Appliances	390.02
15	Product_15	Home Appliances	118.89
16	Product_16	Electronics	890.75
32	Product_32	Home Appliances	331.57
36	Product_36	Home Appliances	22.27
37	Product_37	Home Appliances	752.55
43	Product_43	Home Appliances	401.06
46	Product_46	Accessories	60.11
49	Product_49	Electronics	230.34
50	Product_50	Home Appliances	462.39
51	Product_51	Electronics	286.2
52	Product_52	Home Appliances	301.95
54	Product_54	Electronics	128.28
56	Product_56	Home Appliances	793.83
58	Product_58	Accessories	330.13
59	Product_59	Home Appliances	102.92
61	Product_61	Electronics	379.09
63	Product_63	Electronics	362.22
68	Product_68	Home Appliances	647.59
72	Product_72	Accessories	855.1
75	Product_75	Accessories	735.01
77	Product_77	Home Appliances	200.61
78	Product_78	Home Appliances	515.71
82	Product_82	Electronics	11.55
83	Product_83	Home Appliances	782.88
84	Product_84	Home Appliances	239.24
88	Product_88	Home Appliances	90.61
91	Product_91	Accessories	614.57
92	Product_92	Electronics	816.44
94	Product_94	Home Appliances	708.17
97	Product_97	Accessories	135.98

11. Identify the top 3 customers who have spent the most 100	Customer_100	104338.09000000001
99	Customer_99	104338.09000000001
98	Customer_98	104338.09000000001

12. Which product has the highest unit price? '21', 'Product_21', 'Accessories', '972.57'

13. Group customers by age range (e.g., 18-25, 26-35, etc.) and find the total revenue generated by each age group. 18-25	1460733.2599999986
26-35	2504114.1599999727
35-50	3651833.149999994
50-65	2817128.429999966

14. Find the percentage of male and female customers. Male	52.00000
Female	48.00000. 