/* 
Advanced:
1. Calculate the percentage contribution of each pizza type to total revenue.
2. Analyze the cumulative revenue generated over time.
3. Determine the top 3 most ordered pizza types based on revenue for each pizza category.
*/

/* 1. Calculate the percentage contribution of each pizza category to total revenue. */ 

/* USE FORMULLA:  % contribution of each category = (each_category_revenue/ Total_revenue ) * 100  */ 

SELECT pizza_types.category , ( SUM(order_details.quantity * pizzas.price) /
												( SELECT SUM(order_details.quantity * pizzas.price) AS total_revenue 
												FROM order_details JOIN pizzas 
												ON pizzas.pizza_id = order_details.pizza_id ) 
    ) * 100  AS percentage_revenue                                                  
FROM pizza_types
JOIN pizzas
ON pizza_types.pizza_type_id = pizzas.pizza_type_id
JOIN order_details
ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category
ORDER BY percentage_revenue DESC;




/* 2. Analyze the cumulative revenue generated over time. ( i.e bases on date ) */
-- Commulative revenue means how day-by-day revenue generated increase overall revenue (e.g: If day1 revenue= 100, CR = 100, day2 rev= 300, then CR = 400 (100+300) ... CR = old + present ) 

SELECT date,
SUM(revenue) over(ORDER BY date) AS Commulative_Revenue    /* add/sum old revenue to current revenue to get comm. Rev based on date (over date- date in ASC order) */
FROM
(SELECT orders.date  , SUM(order_details.quantity * pizzas.price) AS revenue  /* this subquery provided simple revenue based on each date */
FROM orders
JOIN order_details
ON orders.order_id = order_details.order_id
JOIN pizzas
ON order_details.pizza_id = pizzas.pizza_id
GROUP BY orders.date) AS date_wise_revenue;




/* 3. Determine the top 3 most ordered pizza types based on revenue for each pizza category. */
SELECT name, category , revenue    /* STEP 3 : NEED ONLY top 3/topRanked pizzaz from below subQuery table2 */
FROM
(SELECT name, category , revenue,                      /* STEP 2:  from subquery below */
RANK() OVER(PARTITION BY category ORDER BY revenue DESC) AS ranking           /* ranking over categories (repeat ranking when new category comes) */
FROM
(SELECT pizza_types.name, pizza_types.category, SUM(order_details.quantity * pizzas.price) AS revenue         /* STEP 1: SUBQUERY: provedes name,category based revenue */
FROM pizza_types
JOIN pizzas
ON pizza_types.pizza_type_id = pizzas.pizza_type_id
JOIN order_details
ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.name, pizza_types.category) AS rev_table1)  AS rank_table2
WHERE ranking <=3 ;






