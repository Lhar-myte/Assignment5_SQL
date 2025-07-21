SELECT *
FROM pizza_names;
SELECT *
FROM runner_orders;
SELECT *
FROM customer_orders;

/*
write a query to show how mmany pizzas was ordered.
write a query to show how many succesful orders were deliverred by each rrunner
write a query to show the number of each type of pizza that was delivered.
*/

SELECT
	pizza_id,
    COUNT(pizza_id) AS total_pizza_ordered
FROM customer_orders
INNER JOIN (runner_orders)
USING (order_id)
GROUP BY pizza_id
; 


SELECT 
    runner_id,
    COUNT( DATE_FORMAT(STR_TO_DATE(pickup_time, '%m/%d/%Y %H:%i'), '%Y-%m-%d')) AS successful_deliveries,
    DATE_FORMAT(STR_TO_DATE(pickup_time, '%m/%d/%Y %H:%i'), '%Y-%m-%d') AS delivery_date
FROM runner_orders
WHERE pickup_time IS NOT NULL AND (cancellation IS NULL OR cancellation = '')
GROUP BY runner_id, delivery_date;


SELECT 
    pizza_id,
    COUNT(pizza_id) AS delivered_count
FROM customer_orders o
JOIN runner_orders d ON o.order_id = d.order_id
WHERE d.pickup_time IS NOT NULL AND (d.cancellation IS NULL OR d.cancellation = '')
GROUP BY pizza_id;
