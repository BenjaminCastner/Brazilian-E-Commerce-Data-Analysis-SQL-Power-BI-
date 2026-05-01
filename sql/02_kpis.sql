KPI's SQL

-- Total orders
SELECT COUNT(DISTINCT order_id) AS total_orders
FROM orders;

-- Total customers
SELECT COUNT(DISTINCT customer_unique_id) AS total_customers
FROM customers;

-- Total revenue
SELECT
    ROUND(SUM(payment_value::NUMERIC), 2) AS total_revenue
FROM payments;

-- Average order value
SELECT ROUND(SUM(payment_value::NUMERIC)/ COUNT(DISTINCT order_id),2) AS avg_order_value
FROM payments;

-- Average review score
SELECT ROUND(AVG(review_score),2) AS avg_review_score
FROM reviews;
