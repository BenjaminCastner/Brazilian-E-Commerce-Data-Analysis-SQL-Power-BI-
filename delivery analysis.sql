DELIVERY ANALYSIS SQL

-- Delivery performance
SELECT
    ROUND(AVG(
        DATE_PART('day', order_delivered_customer_date - order_purchase_timestamp)
    )::NUMERIC, 2) AS avg_delivery_days
FROM orders
WHERE order_delivered_customer_date IS NOT NULL;

SELECT
    CASE
        WHEN order_delivered_customer_date <= order_delivered_delivery_date 
            THEN 'On Time / Early'
        ELSE 'Late'
    END AS delivery_status,
    COUNT(*) AS total_orders
FROM orders
WHERE order_delivered_customer_date IS NOT NULL
  AND order_delivered_delivery_date IS NOT NULL
GROUP BY delivery_status;

-- Percentage delivery status
SELECT
    CASE
        WHEN order_delivered_customer_date <= order_delivered_delivery_date 
            THEN 'On Time / Early'
        ELSE 'Late'
    END AS delivery_status,
    COUNT(*) AS total_orders,
    ROUND(
        COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (),
        2
    ) AS percentage
FROM orders
WHERE order_delivered_customer_date IS NOT NULL
  AND order_delivered_delivery_date IS NOT NULL
GROUP BY delivery_status;

