# 📊 Sales Data Analysis (SQL Project)

## 📌 Objective
Analyze retail sales data to uncover key business insights such as revenue trends, top-performing products, and customer behavior — including a customer segmentation model (RFM) to flag high-value customers.

## 📂 Project Structure

```
Sales-SQL-Analysis/
├── README.md
├── datas/
│   └── superstore.csv              # Source dataset
├── queries/
│   ├── analysis.sql                # Revenue, category, trend, and ranking queries
│   └── customer_segmentation.sql   # RFM segmentation logic
└── Documents/
    ├── rfm-customer segmentation.pdf
    ├── customer recency.pdf
    ├── ranking.pdf
    └── placeholder.md
```

## 🗄️ Dataset (`datas/`)
**`superstore.csv`** — the Superstore dataset from Kaggle:
https://www.kaggle.com/datasets/vivek468/superstore-dataset-final

> ⚠️ Note: the copy currently committed in `datas/superstore.csv` is empty (placeholder only). Download the full CSV from the Kaggle link above and load it into your database as the `Superstore_Sales` / `sales` table before running the queries below.

## 🛠️ Tools Used
- PostgreSQL
- SQL (window functions, CTEs, aggregations)

## 📜 SQL Queries (`queries/`)

### `analysis.sql`
General sales analysis:
1. **Total revenue** — `SUM(sales)` across all orders
2. **Revenue by category** — total sales grouped by `category`
3. **Monthly sales trend** — revenue grouped by `DATE_TRUNC('month', order_date)`
4. **Top customers** — `RANK()` window function over total spend per customer
5. **Top 3 products per category** — `RANK() OVER (PARTITION BY category ORDER BY revenue DESC)`, filtered to rank ≤ 3

### `customer_segmentation.sql`
RFM (Recency, Frequency, Monetary) segmentation:
1. Finds the most recent order date in the dataset (used as the reference point for recency)
2. Builds an RFM base table per customer (last purchase date, order frequency, total spend)
3. Adds a calculated `recency` column (`DATEDIFF` from each customer's last order to the dataset's most recent order)
4. Buckets customers into segments (`Champions`, `Loyal Customers`, `New Customers`, `At Risk Customers`, `Lost Customers`, `Potential Customers`) via a `CASE` statement on recency/frequency/monetary thresholds
5. Rolls the segments up into summary queries: customer count per segment, and total revenue per segment

## 📄 Documents (`Documents/`)
Dashboard exports visualizing the output of the queries above:

| File | What it shows | Built from |
|---|---|---|
| `rfm-customer segmentation.pdf` | Scatter plot of **avg. frequency vs. monetary value**, colored by customer segment (High Value / Loyal Customers / Low Value) | `customer_segmentation.sql` |
| `customer recency.pdf` | Bar charts of **customer count per segment** and **avg. monetary value per segment** | `customer_segmentation.sql` |
| `ranking.pdf` | **Ranking by Category** — sales for the top 3 products (by rank) within each product category | `analysis.sql` |
| `placeholder.md` | Empty file reserved for future notes | — |

> Note: the simplified segment labels used in the dashboards (High Value / Loyal Customers / Low Value) are a presentation-layer grouping of the six finer-grained segments produced by the `CASE` logic in `customer_segmentation.sql`.

## 🔍 Key Analysis Performed
- Total revenue calculation
- Sales by category and region
- Monthly sales trends
- Top customers by revenue (window functions)
- Top 3 products per category (ranked)
- RFM-based customer segmentation

## 📈 Key Insights
- Certain categories consistently outperform others
- Revenue shows clear monthly patterns
- A small percentage of customers contribute to a large portion of sales
- High-value customers show meaningfully higher purchase frequency and monetary value than low-value/loyal segments

## 🧠 Skills Demonstrated
- SQL Joins
- Aggregations (`SUM`, `AVG`, `COUNT`)
- Window Functions (`RANK`, `ROW_NUMBER`)
- CTEs and `CASE`-based segmentation logic
- Data analysis and business interpretation
