--The goal of this project is to segment customers based on purchasing behavior using SQL, in order to identify high-value customers and support targeted business strategies.

--1. Finding the maximum order to when it was purchased.
SELECT MAX(order_date) AS max_date
FROM Superstore_Sales;


--2. RFM base table
SELECT 
    customer_id,
    MAX(order_date) AS last_purchase_date,
    COUNT(order_id) AS frequency,
    SUM(sales) AS monetary
FROM Superstore_Sales
GROUP BY customer_id;

--3. RFM base table with recency calculated
SELECT 
    customer_id,
    DATEDIFF(day, MAX(order_date), (SELECT MAX(order_date) FROM Superstore_Sales)) AS recency,
    COUNT(order_id) AS frequency,
    SUM(sales) AS monetary
FROM Superstore_Sales
GROUP BY customer_id;

--. Segmentation based on R
WITH rfm AS (
    SELECT 
        customer_id,
        DATEDIFF(day, MAX(order_date), (SELECT MAX(order_date) FROM Superstore_Sales)) AS recency,
        COUNT(order_id) AS frequency,
        SUM(sales) AS monetary
    FROM Superstore_Sales
    GROUP BY customer_id
),

segmented AS (
    SELECT *,
           
            CASE
        WHEN recency = 5 AND frequency >= 4 AND monetary >= 4
            THEN 'Champions'

        WHEN frequency >= 4 AND monetary >= 4
            THEN 'Loyal Customers'

        WHEN recency >= 4 AND frequency <= 2
            THEN 'New Customers'

        WHEN recency <= 2 AND frequency >= 3
            THEN 'At Risk Customers'

        WHEN recency = 1 AND frequency = 1
            THEN 'Lost Customers'

        ELSE 'Potential Customers'

        END AS customer_segment
    FROM rfm
)

SELECT * FROM segmented;



WITH rfm AS (
    SELECT 
        customer_id,
        DATEDIFF(day, MAX(order_date), (SELECT MAX(order_date) FROM Superstore_Sales)) AS recency,
        COUNT(order_id) AS frequency,
        SUM(sales) AS monetary
    FROM Superstore_Sales
    GROUP BY customer_id
),

segmented AS (
    SELECT *,
         CASE
        WHEN recency = 5 AND frequency >= 4 AND monetary >= 4
            THEN 'Champions'
        WHEN frequency >= 4 AND monetary >= 4
            THEN 'Loyal Customers'
        WHEN recency >= 4 AND frequency <= 2
            THEN 'New Customers'
        WHEN recency <= 2 AND frequency >= 3
            THEN 'At Risk Customers'
        WHEN recency = 1 AND frequency = 1
            THEN 'Lost Customers'
        ELSE 'Potential Customers'

        END AS customer_segment
    FROM rfm
)

SELECT 
    customer_segment,
    COUNT(*) AS total_customers
FROM segmented
GROUP BY customer_segment;


WITH rfm AS (
    SELECT 
        customer_id,
        DATEDIFF(day, MAX(order_date), (SELECT MAX(order_date) FROM Superstore_Sales)) AS recency,
        COUNT(order_id) AS frequency,
        SUM(sales) AS monetary
    FROM Superstore_Sales
    GROUP BY customer_id
),

segmented AS (
    SELECT *,
        CASE 
            WHEN recency = 5 AND frequency >= 4 AND monetary >= 4
            THEN 'Champions'
        WHEN frequency >= 4 AND monetary >= 4
            THEN 'Loyal Customers'
        WHEN recency >= 4 AND frequency <= 2
            THEN 'New Customers'
        WHEN recency <= 2 AND frequency >= 3
            THEN 'At Risk Customers'
        WHEN recency = 1 AND frequency = 1
            THEN 'Lost Customers'
        ELSE 'Potential Customers'
        END AS customer_segment
    FROM rfm
)

SELECT 
    customer_segment,
    SUM(monetary) AS total_revenue
FROM segmented
GROUP BY customer_segment;
   

