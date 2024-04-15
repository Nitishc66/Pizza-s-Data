------------------------------------------------------------------------
                       #### TOTAL ORDERS ####
------------------------------------------------------------------------
SELECT 
    *
FROM
    pizzahut.orders;
SELECT 
    COUNT(order_id) AS total_order
FROM
    order_details;
    
--------------------------------------------------------------------------
                          #### TOTAL SALES ####
--------------------------------------------------------------------------
    SELECT 
    ROUND(SUM(order_details.quantity * pizzas.price),
            2) AS total_sales
FROM
    order_details
        JOIN
    pizzas ON pizzas.pizza_id = order_details.pizza_id;
    
---------------------------------------------------------------------------
				      #### HIGHEST - PRICED PIZZA ####
---------------------------------------------------------------------------
SELECT 
    *
FROM
    pizzahut.pizzas
ORDER BY price DESC
LIMIT 0,1;

----------------------------------------------------------------------------
                 #### MOST COMMON SIZE PIZZA ORDERED ####
----------------------------------------------------------------------------
SELECT 
    pizzas.size, COUNT(order_details.order_details_id)
FROM
    pizzas
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id 
GROUP BY pizzas.size asc;

------------------------------------------------------------------------------
                     #### MOST ORDERED PIZZAS ####
------------------------------------------------------------------------------
SELECT 
    pizza_types.name, SUM(order_details.quantity) AS quantity
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.name
order by quantity desc LIMIT 5;

---------------------------------------------------------------------------------
	   #### DISTRIBUTION OF QUANTITY OF PIZZA ORDERED BASED ON HOUR ####
---------------------------------------------------------------------------------
select hour(order_time) from orders;
SELECT 
    HOUR(orders.order_time),
    COUNT(orders.order_id) AS no_of_order_placed
FROM
    orders
        JOIN
    order_details ON orders.order_id = order_details.order_id
GROUP BY HOUR(orders.order_time);

----------------------------------------------------------------------------------
               #### THE CATEGORY-WISE DISTRIBUTION OF PIZZAS ####
----------------------------------------------------------------------------------
SELECT 
    pizza_types.category, COUNT(pizza_types.name) AS count
FROM
    pizza_types
GROUP BY pizza_types.category;

----------------------------------------------------------------------------------
				#### TOP 3 MOST ORDERED PIZZA BASED ON REVENUE ####
----------------------------------------------------------------------------------
SELECT 
    pizza_types.name,
    SUM(pizzas.price * order_details.quantity) AS count_
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizza_types.name
ORDER BY count_ DESC
LIMIT 3;

-------------------------------------------------------------------------------------
#### CONTRIBUTION IN PERCENTAGE TO TOTAL REVENUE BY EACH PIZZA CATEGORY ####
-------------------------------------------------------------------------------------
SELECT 
    pizza_types.category,
    sum(order_details.quantity * pizzas.price)*100/(SELECT 
    ROUND(SUM(order_details.quantity * pizzas.price),
            2) AS total_sales
FROM
    order_details
        JOIN
    pizzas ON pizzas.pizza_id = order_details.pizza_id) AS percentage
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizza_types.category;

------------------------------------------------------------------------------------
                                   #x-x-x#
------------------------------------------------------------------------------------