-- =====================================
-- SALES DATA ANALYSIS PROJECT
-- =====================================

-- 1. Total Revenue
SELECT SUM(sales) AS total_revenue
FROM sales;

-- 2. Revenue by Category
SELECT category, SUM(sales) AS revenue
FROM sales
GROUP BY category
ORDER BY revenue DESC;

-- 3. Monthly Sales Trend
SELECT 
    DATE_TRUNC('month', order_date) AS month,
    SUM(sales) AS revenue
FROM sales
GROUP BY month
ORDER BY month;

-- 4. Top Customers (Window Function)
SELECT 
    customer_id,
    SUM(sales) AS total_spent,
    RANK() OVER (ORDER BY SUM(sales) DESC) AS rank
FROM sales
GROUP BY customer_id;

-- 5. Top 3 products per category
SELECT *
FROM (
    SELECT 
        category,
        product_name,
        SUM(sales) AS revenue,
        RANK() OVER (PARTITION BY category ORDER BY SUM(sales) DESC) AS rank
    FROM sales
    GROUP BY category, product_name
) ranked
WHERE rank <= 3;
