-- Check data type
SELECT
  column_name,
  data_type,
  is_nullable
FROM `namaste-mart-506509.namaste.INFORMATION_SCHEMA.COLUMNS`
WHERE table_name = 'master';

-- Check all data in table
SELECT * FROM `namaste-mart-506509.namaste.master`;

-- Check amount of data
SELECT
  COUNT(*)
FROM `namaste-mart-506509.namaste.master`;  # 4310 rows

-- Check duplicate data in order_id
SELECT
  order_id,
  COUNT(*) AS data_total
FROM `namaste-mart-506509.namaste.master`
GROUP BY 1
HAVING COUNT(*) > 1
ORDER BY data_total DESC;

-- Duplicate Values vs Not Duplicate Values
SELECT
  COUNTIF(data_total > 1) AS duplicate_values,
  COUNTIF(data_total = 1) AS not_duplicate_values
FROM
  (
    SELECT
      COUNT(*) AS data_total
    FROM `namaste-mart-506509.namaste.master`
    GROUP BY order_id
  );  # 81 duplicate values and 4120 not duplicate values

-- Validate duplicate order_id
SELECT *
FROM `namaste-mart-506509.namaste.master`
WHERE
  order_id IN (
    SELECT
      order_id
    FROM `namaste-mart-506509.namaste.master`
    GROUP BY 1
    HAVING COUNT(*) > 1
  )
ORDER BY order_id
LIMIT 20;

-- Check Missing Value
SELECT
  COUNTIF(order_id IS NULL) AS missing_order_id,  # 30 missing values
  COUNTIF(order_date IS NULL) AS missing_order_date,  # 30 missing values
  COUNTIF(customer_id IS NULL) AS missing_customer_id,  # 30 missing values
  COUNTIF(customer_name IS NULL) AS missing_customer_name,  # 30 missing values
  COUNTIF(age IS NULL) AS missing_age,  # 160 missing values
  COUNTIF(gender IS NULL) AS missing_gender,  # 30 missing values
  COUNTIF(region IS NULL) AS missing_region,  # 30 missing values
  COUNTIF(city IS NULL) AS missing_city,  # 30 missing values
  COUNTIF(product_category IS NULL) AS missing_category,  # 30 missing values
  COUNTIF(product_name IS NULL) AS missing_product_name,  # 30 missing values
  COUNTIF(quantity IS NULL) AS missing_quantity,  # 140 missing values
  COUNTIF(unit_price IS NULL) AS missing_price,  # 30 missing values
  COUNTIF(discount_pct IS NULL) AS missing_discount,  # 167 missing values
  COUNTIF(sales_amount IS NULL) AS missing_sales_amount,  # 30 missing values
  COUNTIF(profit IS NULL) AS missing_profit,  # 30 missing values
  COUNTIF(payment_method IS NULL)
    AS missing_payment_method,  # 30 missing values
  COUNTIF(customer_satisfaction IS NULL)
    AS missing_satisfaction  # 378 missing values
FROM `namaste-mart-506509.namaste.master`;

-- Missing Value Percentage
SELECT
  ROUND(COUNTIF(order_id IS NULL) / COUNT(*), 2) * 100
    AS missing_order_id_pct,  # 1% missing values
  ROUND(COUNTIF(order_date IS NULL) / COUNT(*), 2) * 100
    AS missing_order_date_pct,  # 1% missing values
  ROUND(COUNTIF(customer_id IS NULL) / COUNT(*), 2) * 100
    AS missing_customer_id_pct,  # 1% missing values
  ROUND(COUNTIF(customer_name IS NULL) / COUNT(*), 2) * 100
    AS missing_customer_name_pct,  # 1% missing values
  ROUND(COUNTIF(age IS NULL) / COUNT(*), 2) * 100
    AS missing_age_pct,  # 4% missing values
  ROUND(COUNTIF(gender IS NULL) / COUNT(*), 2) * 100
    AS missing_gender_pct,  # 1% missing values
  ROUND(COUNTIF(region IS NULL) / COUNT(*), 2) * 100
    AS missing_region_pct,  # 1% missing values
  ROUND(COUNTIF(city IS NULL) / COUNT(*), 2) * 100
    AS missing_city_pct,  # 1% missing values
  ROUND(COUNTIF(product_category IS NULL) / COUNT(*), 2) * 100
    AS missing_category_pct,  # 1% missing values
  ROUND(COUNTIF(product_name IS NULL) / COUNT(*), 2) * 100
    AS missing_product_name_pct,  # 1% missing values
  ROUND(COUNTIF(quantity IS NULL) / COUNT(*), 2) * 100
    AS missing_quantity_pct,  # 3% missing values
  ROUND(COUNTIF(unit_price IS NULL) / COUNT(*), 2) * 100
    AS missing_price_pct,  # 1% missing values
  ROUND(COUNTIF(discount_pct IS NULL) / COUNT(*), 2) * 100
    AS missing_discount_pct,  # 4% missing values
  ROUND(COUNTIF(sales_amount IS NULL) / COUNT(*), 2) * 100
    AS missing_sales_amount_pct,  # 1% missing values
  ROUND(COUNTIF(profit IS NULL) / COUNT(*), 2) * 100
    AS missing_profit_pct,  # 1% missing values
  ROUND(COUNTIF(payment_method IS NULL) / COUNT(*), 2) * 100
    AS missing_payment_method_pct,  # 1% missing values
  ROUND(COUNTIF(customer_satisfaction IS NULL) / COUNT(*), 2) * 100
    AS missing_satisfaction_pct  # 9% missing values
FROM `namaste-mart-506509.namaste.master`;

-- Check Outlier
SELECT
  MIN(age) AS min_age,
  MAX(age) AS max_age,
  AVG(age) AS avg_age,
  STDDEV(age) AS std_age,
  MIN(quantity) AS min_quantity,
  MAX(quantity) AS max_quantity,
  AVG(quantity) AS avg_quantity,
  STDDEV(quantity) AS std_quantity,
  MIN(unit_price) AS min_price,
  MAX(unit_price) AS max_price,
  AVG(unit_price) AS avg_price,
  STDDEV(unit_price) AS std_price,
  MIN(sales_amount) AS min_sales,
  MAX(sales_amount) AS max_sales,
  AVG(sales_amount) AS avg_sales,
  STDDEV(sales_amount) AS std_sales,
  MIN(profit) AS min_profit,
  MAX(profit) AS max_profit,
  AVG(profit) AS avg_profit,
  STDDEV(profit) AS std_profit,
  MIN(discount_pct) AS min_discount,
  MAX(discount_pct) AS max_discount,
  AVG(discount_pct) AS avg_discount,
  STDDEV(discount_pct) AS std_discount,
  MIN(order_date) AS min_date,
  MAX(order_date) AS max_date,
  MIN(shipping_cost) AS min_shipping_cost,
  MAX(shipping_cost) AS max_shipping_cost,
  AVG(shipping_cost) AS avg_shipping_cost,
  STDDEV(shipping_cost) AS std_shipping_cost,
  MIN(customer_satisfaction) AS min_satisfaction,
  MAX(customer_satisfaction) AS max_satisfaction,
  AVG(customer_satisfaction) AS avg_satisfaction,
  STDDEV(customer_satisfaction) AS std_satisfaction,
  MIN(days_to_ship) AS min_days,
  MAX(days_to_ship) AS max_days,
  AVG(days_to_ship) AS avg_days,
  STDDEV(days_to_ship) AS std_days
FROM `namaste-mart-506509.namaste.master`;

-- Inconsistent Text

SELECT
  order_date,
  COUNT(*) AS total_data
FROM `namaste-mart-506509.namaste.master`
GROUP BY 1
ORDER BY 1;

SELECT
  customer_id,
  COUNT(*) AS total_data
FROM `namaste-mart-506509.namaste.master`
GROUP BY 1
HAVING COUNT(*) > 1
ORDER BY 1;

SELECT
  customer_name,
  COUNT(*) AS total_data
FROM `namaste-mart-506509.namaste.master`
GROUP BY 1
HAVING COUNT(*) > 1
ORDER BY 1;

SELECT
  age,
  COUNT(*) AS total_data
FROM `namaste-mart-506509.namaste.master`
GROUP BY 1
ORDER BY 1;

SELECT
  gender,
  COUNT(*) AS total_data
FROM `namaste-mart-506509.namaste.master`
GROUP BY 1
ORDER BY 1;

SELECT
  region,
  COUNT(*) AS total_data
FROM `namaste-mart-506509.namaste.master`
GROUP BY 1
ORDER BY 1;

SELECT
  city,
  COUNT(*) AS total_data
FROM `namaste-mart-506509.namaste.master`
GROUP BY 1
ORDER BY 1;

SELECT
  product_category,
  COUNT(*) AS total_data
FROM `namaste-mart-506509.namaste.master`
GROUP BY 1
ORDER BY 1;

SELECT
  product_name,
  COUNT(*) AS total_data
FROM `namaste-mart-506509.namaste.master`
GROUP BY 1
ORDER BY 1;

SELECT
  quantity,
  unit_price,
  sales_amount,
  shipping_cost
FROM `namaste-mart-506509.namaste.master`
WHERE
  quantity < 0
  OR unit_price < 0
  OR sales_amount < 0
  OR shipping_cost < 0;

SELECT
  discount_pct,
  COUNT(*) AS total_data
FROM `namaste-mart-506509.namaste.master`
WHERE discount_pct < 0 OR discount_pct > 1
GROUP BY 1
ORDER BY 1 DESC;

SELECT COUNT(*) AS total_outlier
FROM `namaste-mart-506509.namaste.master`
WHERE SAFE_DIVIDE(profit, sales_amount) > 1;

SELECT
  payment_method,
  COUNT(*) AS total_data
FROM `namaste-mart-506509.namaste.master`
GROUP BY 1
ORDER BY 1;

SELECT
  customer_satisfaction,
  order_status,
  days_to_ship,
  COUNT(*) AS total_data
FROM `namaste-mart-506509.namaste.master`
WHERE customer_satisfaction IS NULL
GROUP BY 1, 2, 3
ORDER BY 4 DESC;
