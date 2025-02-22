# Pizza Sales Analysis

## Overview
This repository contains SQL queries for analyzing pizza sales data. The queries help extract key business insights, including order trends, category distributions, revenue generation, and customer preferences.

## Business Overview
This project analyzes pizza sales data to extract key insights that can help improve business performance. By evaluating sales trends, customer preferences, and revenue generation, businesses can make data-driven decisions to optimize their offerings and increase profitability.

## Key Business Insights

### 1. Sales Trends
- Identifies the **average number of pizzas ordered per day**, helping in demand forecasting.  
- Analyzes **order distribution by hour** to determine peak business hours.  

### 2. Customer Preferences
- Determines the **most popular pizza categories and sizes**, providing insights into customer tastes.  
- Highlights the **top-selling pizza types**, which can be used to refine marketing and promotions.  

### 3. Revenue & Profitability
- Calculates **total revenue generated from pizza sales**, offering financial performance insights.  
- Identifies the **highest-priced pizza**, which may indicate premium product demand.  

### 4. Operational Optimization
- Examines **category-wise distribution of pizzas**, helping in inventory management.  
- Helps streamline **stock and ingredient purchasing** based on sales volume.  

## Business Applications
- **Marketing Strategy**: Target promotions for top-selling pizzas and peak order times.  
- **Inventory Management**: Stock ingredients based on demand for different pizza types and sizes.  
- **Pricing Strategy**: Evaluate the performance of premium-priced pizzas for potential price adjustments.  
- **Customer Experience**: Optimize delivery and staffing based on peak order hours.  

## Conclusion
By leveraging SQL-based data analysis, businesses can make informed decisions to enhance sales, optimize inventory, and improve customer satisfaction. This data-driven approach can lead to **higher efficiency, better customer retention, and increased revenue** in the competitive food industry.

## SQL Queries

### 1. Average Number of Pizzas Ordered Per Day
Calculates the daily average number of pizzas ordered.
```sql
WITH DailyOrderTotals AS (
    SELECT
        orders.order_date,
        SUM(order_details.quantity) AS total_pizzas
    FROM orders
    JOIN order_details ON orders.order_id = order_details.order_id
    GROUP BY orders.order_date
)
SELECT
    ROUND(AVG(total_pizzas), 0) AS avg_pizzas_per_day
FROM DailyOrderTotals;
```

### 2. Category-Wise Distribution of Pizzas
Finds the count of pizzas in each category.
```sql
SELECT category, COUNT(*)
FROM pizza_types
GROUP BY category;
```

### 3. Distribution of Orders by Hour
Analyzes when orders are placed.
```sql
SELECT
    HOUR(orders.order_time) AS hours,
    COUNT(orders.order_id) AS order_count
FROM orders
GROUP BY hours;
```

### 4. Total Quantity of Each Pizza Category Ordered
Finds the total quantity of pizzas ordered per category.
```sql
SELECT
    SUM(od.quantity) AS total_quantity, pt.category
FROM pizza_types pt
JOIN pizzas p ON pt.pizza_type_id = p.pizza_type_id
JOIN order_details od ON p.pizza_id = od.pizza_id
GROUP BY pt.category;
```

### 5. Top 5 Most Ordered Pizza Types
Identifies the most popular pizza types.
```sql
SELECT pt.name, SUM(od.quantity) AS most_sold
FROM pizza_types pt
JOIN pizzas p ON pt.pizza_type_id = p.pizza_type_id
JOIN order_details od ON p.pizza_id = od.pizza_id  
GROUP BY pt.name
ORDER BY most_sold DESC
LIMIT 5;
```

### 6. Most Common Pizza Size Ordered
Determines which pizza size is ordered the most.
```sql
SELECT
    pizzas.size, COUNT(order_details.order_details_id) AS counted
FROM pizzas
JOIN order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizzas.size
ORDER BY COUNT(order_details.order_details_id) DESC;
```

### 7. Highest-Priced Pizza
Finds the most expensive pizza.
```sql
SELECT
    pt.name, p.price
FROM pizzas p
JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
ORDER BY p.price DESC
LIMIT 1;
```

### 8. Total Revenue Generated from Pizza Sales
Calculates total revenue from pizza sales.
```sql
SELECT
    ROUND(SUM(order_details.quantity * pizzas.price), 2) AS revenue
FROM order_details
JOIN pizzas ON order_details.pizza_id = pizzas.pizza_id;
```

### 9. Total Number of Orders Placed
Finds the total number of orders.
```sql
SELECT COUNT(*) AS orders FROM orders;
```



