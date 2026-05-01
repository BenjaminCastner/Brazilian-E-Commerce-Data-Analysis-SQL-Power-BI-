VIEWS SQL

-- Order revenue view
CREATE VIEW order_revenue AS
SELECT
    o.order_id,
    o.customer_id,
    o.order_purchase_timestamp,
    SUM(p.payment_value::NUMERIC) AS total_order_value
FROM orders o
JOIN payments p
    ON o.order_id = p.order_id
GROUP BY o.order_id, o.customer_id, o.order_purchase_timestamp;

SELECT *
FROM order_revenue
LIMIT 10;

-- Customer orders view
CREATE VIEW customer_orders AS
SELECT
    c.customer_unique_id,
    COUNT(DISTINCT o.order_id) AS total_orders
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_unique_id;

-- Delivery performance view
CREATE VIEW delivery_performance AS
SELECT
    order_id,
    order_purchase_timestamp,
    order_delivered_customer_date,
    order_delivered_delivery_date,
    DATE_PART(
        'day',
        order_delivered_customer_date - order_purchase_timestamp
    ) AS delivery_days,
    CASE
        WHEN order_delivered_customer_date <= order_delivered_delivery_date 
            THEN 'On Time / Early'
        ELSE 'Late'
    END AS delivery_status
FROM orders
WHERE order_delivered_customer_date IS NOT NULL;

SELECT
    DATE_TRUNC('month', order_purchase_timestamp)::DATE,
    SUM(total_order_value)
FROM order_revenue
GROUP BY 1
ORDER BY 1;

-- Master view
CREATE VIEW final_orders AS
SELECT
    o.order_id,
    o.order_purchase_timestamp,
    c.customer_state,
    r.total_order_value,
    d.delivery_days,
    d.delivery_status
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id
JOIN order_revenue r
    ON o.order_id = r.order_id
LEFT JOIN delivery_performance d
    ON o.order_id = d.order_id;
