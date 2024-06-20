/* Intermediate:
1. Join the necessary tables to find the total quantity of each pizza category ordered.
2. Determine the distribution of orders by hour of the day.
3. Join relevant tables to find the category-wise orders of pizzas.
4. Join relevant tables to find the category-wise distribution of pizzas.
5. Group the orders by date and calculate the average number of pizzas ordered per day.
6. Determine REVENUE generated per order of pizzas.
7. Determine the top 3 most ordered pizza types based on revenue.
*/

/* 1. Join the necessary tables to find the total quantity of each pizza category ordered. */
SELECT pizza_types.category, SUM(order_details.quantity)
FROM pizza_types
JOIN pizzas
ON pizza_types.pizza_type_id = pizzas.pizza_type_id
JOIN order_details
ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizza_types.category;


/* 2. Determine the distribution of orders by hour of the day. (i.e., no. of orders placed on hour basis of day) */
SELECT HOUR(orders.time) AS hour, COUNT(orders.order_id) AS order_placed
FROM orders
GROUP BY hour
ORDER BY hour ASC;





/* 3. Join relevant tables to find the category-wise orders of pizzas. (how many orders placed category wise)*/

/* Let's do based on common fields to reach order placed per category */
SELECT pizza_types.category, COUNT(orders.order_id)
FROM pizza_types
JOIN pizzas
ON pizza_types.pizza_type_id = pizzas.pizza_type_id
JOIN order_details
ON pizzas.pizza_id = order_details.pizza_id
JOIN orders
ON order_details.order_id = orders.order_id
GROUP BY pizza_types.category;


-- 4. Join relevant tables to find the category-wise distribution of pizzas. (No. of pizzas in each category avail )
SELECT category, COUNT(name) 
FROM pizza_types
GROUP BY category;




/* 5. Group the orders by date and calculate the average 'number of pizzas ordered per day' (No of pizzas, Not no of orders which may containg multiple pizzas ordered in  single order) */

SELECT ROUND(AVG(quantity_ordered), 0) AS avg_orders_per_day FROM
(SELECT date, sum(order_details.quantity) AS quantity_ordered
FROM orders
JOIN order_details
ON orders.order_id = order_details.order_id
GROUP BY date) AS per_date_quantity_ordered;




/* 6. Determine REVENUE generated per order of pizzas. */

SELECT pizza_types.name AS pizza_name , (order_details.quantity * pizzas.price ) AS revenue_per_order
FROM pizza_types
JOIN pizzas
ON pizza_types.pizza_type_id = pizzas.pizza_type_id
JOIN order_details
ON pizzas.pizza_id = order_details.pizza_id; 



/* 7. Determine the top 3 most ordered 'pizza types' based on revenue. (Not revenue per order but revenue based on TYPE OF PIZZA)  */

SELECT pizza_types.name AS pizza_name , SUM(order_details.quantity * pizzas.price ) AS REVENUE
FROM pizza_types
JOIN pizzas
ON pizza_types.pizza_type_id = pizzas.pizza_type_id
JOIN order_details
ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizza_types.name            /* get revenue based on type of pizza */
ORDER BY REVENUE DESC
LIMIT 3; 






