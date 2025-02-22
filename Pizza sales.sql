#PIZZA SALES 

-- 1. Average Number of Pizzas Ordered Per Day
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

-- 2. Category-Wise Distribution of Pizzas
SELECT category, COUNT(*)
FROM pizza_types
GROUP BY category;

-- 3. Distribution of Orders by Hour
SELECT
    HOUR(orders.order_time) AS hours,
    COUNT(orders.order_id) AS order_count
FROM orders
GROUP BY hours;

-- 4. Total Quantity of Each Pizza Category Ordered
SELECT
    SUM(od.quantity) AS total_quantity, pt.category
FROM pizza_types pt
JOIN pizzas p ON pt.pizza_type_id = p.pizza_type_id
JOIN order_details od ON p.pizza_id = od.pizza_id
GROUP BY pt.category;

-- 5. Top 5 Most Ordered Pizza Types
SELECT pt.name, SUM(od.quantity) AS most_sold
FROM pizza_types pt
JOIN pizzas p ON pt.pizza_type_id = p.pizza_type_id
JOIN order_details od ON p.pizza_id = od.pizza_id  
GROUP BY pt.name
ORDER BY most_sold DESC
LIMIT 5;

-- 6. Most Common Pizza Size Ordered
SELECT
    pizzas.size, COUNT(order_details.order_details_id) AS counted
FROM pizzas
JOIN order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizzas.size
ORDER BY COUNT(order_details.order_details_id) DESC;

-- 7. Highest-Priced Pizza
SELECT
    pt.name, p.price
FROM pizzas p
JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
ORDER BY p.price DESC
LIMIT 1;

-- 8. Total Revenue Generated from Pizza Sales
SELECT
    ROUND(SUM(order_details.quantity * pizzas.price), 2) AS revenue
FROM order_details
JOIN pizzas ON order_details.pizza_id = pizzas.pizza_id;

-- 9. Total Number of Orders Placed
SELECT COUNT(*) AS orders FROM orders;
