SELECT * from pizza_sales;
Use [Pizza DB];

-- 1) Find total revenue of pizza sales
SELECT SUM(total_price) AS Total_Revenue
FROM pizza_sales;

-- 2) Determine average amount spent per order 
SELECT (SUM(total_price) / COUNT(DISTINCT order_id)) AS Avg_order_Value 
FROM pizza_sales;

-- 3) Find total pizzas sold
SELECT SUM(quantity) as total_pizzas_sold
FROM pizza_sales;

--4) Find total orders
SELECT COUNT(DISTINCT order_id) as total_orders
FROM pizza_sales;

-- Find Average pizzas per order
SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) / 
CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS DECIMAL(10,2))
AS Avg_Pizzas_per_order
FROM pizza_sales;

--Daily trend 
SELECT DATENAME(DW, order_date) AS order_day, COUNT(DISTINCT order_id) AS total_orders 
FROM pizza_sales
GROUP BY DATENAME(DW, order_date)
ORDER BY
  CASE
    WHEN DATENAME(DW, order_date) = 'Sunday' THEN 1
    WHEN DATENAME(DW, order_date) = 'Monday' THEN 2
    WHEN DATENAME(DW, order_date) = 'Tuesday' THEN 3
    WHEN DATENAME(DW, order_date) = 'Wednesday' THEN 4
    WHEN DATENAME(DW, order_date) = 'Thursday' THEN 5
    WHEN DATENAME(DW, order_date) = 'Friday' THEN 6
    WHEN DATENAME(DW, order_date) = 'Saturday' THEN 7
  END;

-- Finding Hourly trend
SELECT DATEPART(HOUR, order_time) as order_hours, COUNT(DISTINCT order_id) as total_orders
from pizza_sales
group by DATEPART(HOUR, order_time)
order by DATEPART(HOUR, order_time);

--Find Sales % by pizza category
SELECT pizza_category, CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
GROUP BY pizza_category;

--Total pizza sold
SELECT pizza_category, SUM(quantity) as Total_Quantity_Sold
FROM pizza_sales
WHERE MONTH(order_date) = 2
GROUP BY pizza_category
ORDER BY Total_Quantity_Sold DESC;

--Top 5 best seller pizza
SELECT Top 5 pizza_name, SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold DESC;

-- Bottom 5 lowest selling pizza
SELECT TOP 5 pizza_name, SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold ASC;