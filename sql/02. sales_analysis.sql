-- 01. Total Revenue
SELECT
  SUM(sales_amount) AS total_revenue
FROM `namaste-mart-506509.namaste.master_clean_data`
WHERE order_status NOT IN ('Cancelled', 'Returned');

-- 02. Total Orders
SELECT
  COUNT(DISTINCT order_id) AS total_orders
FROM `namaste-mart-506509.namaste.master_clean_data`
WHERE order_status NOT IN ('Cancelled', 'Returned');

-- 03. Average Orders Value
SELECT
  SUM(sales_amount) / COUNT(DISTINCT order_id) AS average_orders_value
FROM `namaste-mart-506509.namaste.master_clean_data`
WHERE order_status NOT IN ('Cancelled', 'Returned');

-- 04. Profit Percentage
SELECT
  ROUND(SUM(profit) / NULLIF(SUM(sales_amount), 0) * 100, 1) AS profit_pct
FROM `namaste-mart-506509.namaste.master_clean_data`
WHERE order_status NOT IN ('Cancelled', 'Returned');

-- 05. Revenue Lost
SELECT
  SUM(
    CASE
      WHEN
        order_status = "Returned"
        OR order_status = "Cancelled"
        THEN sales_amount
      ELSE 0
      END) AS revenue_lost
FROM `namaste-mart-506509.namaste.master_clean_data`;

-- 06. Monthly Revenue & Profit Trend
SELECT
  FORMAT_DATE('%Y-%m', order_date) AS bulan,
  SUM(sales_amount) AS total_revenue,
  SUM(profit) AS total_profit
FROM `namaste-mart-506509.namaste.master_clean_data`
WHERE order_status NOT IN ('Cancelled', 'Returned')
GROUP BY 1
ORDER BY 1;

-- 07.Top Product by Revenue
SELECT
  product_category,
  SUM(sales_amount) AS revenue
FROM `namaste-mart-506509.namaste.master_clean_data`
WHERE order_status NOT IN ('Cancelled', 'Returned')
GROUP BY 1
ORDER BY 2 DESC;

-- 08. Profit Margin by Category
SELECT
  product_category,
  SUM(sales_amount) AS total_revenue,
  ROUND(SUM(profit) / NULLIF(SUM(sales_amount), 0) * 100, 1)
    AS profit_margin_pct
FROM `namaste-mart-506509.namaste.master_clean_data`
WHERE order_status NOT IN ('Cancelled', 'Returned')
GROUP BY product_category
ORDER BY profit_margin_pct DESC;

-- 09. Return Rate by Category
SELECT
  product_category,
  SUM(sales_amount) AS revenue,
  COUNTIF(order_status IN ('Returned', 'Cancelled'))
    / COUNT(DISTINCT order_id)
    * 100 AS return_rate_pct
FROM `namaste-mart-506509.namaste.master_clean_data`
GROUP BY 1
ORDER BY 3 DESC;

-- 10. Payment Method vs Return Rate
SELECT
  payment_method,
  SUM(sales_amount) AS revenue,
  COUNTIF(order_status IN ('Returned', 'Cancelled'))
    / COUNT(DISTINCT order_id)
    * 100 AS return_rate_pct
FROM `namaste-mart-506509.namaste.master_clean_data`
GROUP BY 1
ORDER BY 3 DESC;

-- 11. Discount Effectiveness
SELECT
  CASE
    WHEN discount_pct = 0 THEN 'No Discount'
    WHEN discount_pct > 0 AND discount_pct <= 0.15
      THEN 'Low Discount (1-15%)'
    WHEN discount_pct > 0.15 AND discount_pct <= 0.30
      THEN 'Medium Discount (16-30%)'
    WHEN discount_pct > 0.30
      THEN 'High Discount (>30%)'
    ELSE 'Unknown'
    END AS discount_range,
  COUNT(*) AS total_orders,
  SUM(sales_amount) / COUNT(DISTINCT order_id) AS average_transaction_value
FROM `namaste-mart-506509.namaste.master_clean_data`
WHERE order_status NOT IN ('Cancelled', 'Returned')
GROUP BY 1
ORDER BY 3 DESC;