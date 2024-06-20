/*
Basic:
1.Retrieve the total number of orders placed.
2.Calculate the total revenue generated from pizza sales.
3.Identify the highest-priced pizza.
4.Identify the most common pizza size ordered.
5.List the top 5 most ordered pizza types along with their quantities.
*/


USE pizza_outlet;

/* 1.Retrieve the total number of orders placed. */
SELECT count(order_id) AS total_orders FROM orders;     
                
     
/* 2.Calculate the total revenue generated from pizza sales. */

SELECT ROUND( SUM(order_details.quantity * pizzas.price), 2)  AS total_revenue       /* round (n , i) : round decimal no. n to i decimal places */
FROM order_details 
JOIN pizzas                                           
ON pizzas.pizza_id = order_details.pizza_id ;                   /* We need common only (So use Join */



-- 3.Identify the highest-priced pizza.

SELECT pizza_types.name , pizzas.price
FROM pizza_types
JOIN pizzas
ON pizzas.pizza_type_id = pizza_types.pizza_type_id 
ORDER BY pizzas.price DESC LIMIT 1;
 


/* 4. Identify the most common pizza size ordered. */
 SELECT pizzas.size, count(order_details.quantity) AS order_count
FROM pizzas 
JOIN order_details
ON  pizzas.pizza_id = order_details.pizza_id 
GROUP BY pizzas.size
ORDER BY order_count DESC Limit 1;


-- 5.  List the top 5 most ordered pizza types along with their quantities.
SELECT pizza_types.name , sum(order_details.quantity) AS order_quantity
FROM pizza_types 
JOIN pizzas
ON pizza_types.pizza_type_id = pizzas.pizza_type_id
JOIN order_details
ON order_details.pizza_id = pizzas.pizza_id    /* 2nd join condition bcz nothing is direct common between pizza_types and order_details */

GROUP BY pizza_types.name 
ORDER BY order_quantity DESC LIMIT 5;                 









 





              
              
              
              
              
              
                
                
                
                
                
                
                
                