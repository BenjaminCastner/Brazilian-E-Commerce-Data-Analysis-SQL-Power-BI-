SALES ANALYSIS SQL

-- Sales over time
SELECT
    DATE_TRUNC('month', o.order_purchase_timestamp)::DATE AS order_month,
    ROUND(SUM(p.payment_value::NUMERIC), 2) AS revenue,
    COUNT(DISTINCT o.order_id) AS total_orders
FROM orders o
JOIN payments p
    ON o.order_id = p.order_id
GROUP BY order_month
ORDER BY order_month;

-- Revenue by state
SELECT
    c.customer_state,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(p.payment_value::NUMERIC), 2) AS revenue
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id
JOIN payments p
    ON o.order_id = p.order_id
GROUP BY c.customer_state
ORDER BY revenue DESC;

-- Product category performance
SELECT
    COALESCE(ct.product_category_name_english, p.product_category_name) AS category,
    COUNT(DISTINCT oi.order_id) AS total_orders,
    SUM(oi.order_item_id) AS total_items,
    ROUND(SUM(oi.price), 2) AS product_revenue
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
LEFT JOIN category_translation ct
    ON p.product_category_name = ct.product_category_name
GROUP BY category
ORDER BY product_revenue DESC;
