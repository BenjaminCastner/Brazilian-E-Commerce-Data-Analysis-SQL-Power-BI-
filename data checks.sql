DATA CHECKS SQL

-- Date range
SELECT
    MIN(order_purchase_timestamp) AS first_order,
    MAX(order_purchase_timestamp) AS last_order
FROM orders;

-- Order statuses
SELECT
    order_status,
    COUNT(*) AS total_orders
FROM orders
GROUP BY order_status
ORDER BY total_orders DESC;

-- Duplicate orders
SELECT
    order_id,
    COUNT(*) AS count
FROM orders
GROUP BY order_id
HAVING COUNT(*) > 1;

-- Duplicate customers
SELECT
    customer_id,
    COUNT(*) AS count
FROM customers
GROUP BY customer_id
HAVING COUNT(*) > 1;

SELECT
    order_id,
    order_item_id,
    COUNT(*) AS count
FROM order_items
GROUP BY order_id, order_item_id
HAVING COUNT(*) > 1;
