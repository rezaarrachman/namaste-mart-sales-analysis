CREATE OR REPLACE TABLE `namaste-mart-506509.namaste.master_clean_data`
AS
WITH
  clean_data AS (
    SELECT
      order_id,
      COALESCE(
        SAFE.PARSE_DATE('%Y-%m-%d', TRIM(order_date)),
        SAFE.PARSE_DATE('%d/%m/%Y', TRIM(order_date)),
        SAFE.PARSE_DATE('%B %d, %Y', TRIM(order_date))) AS order_date,
      customer_id,
      customer_name,
      CASE
        WHEN SAFE_CAST(age AS INT64) BETWEEN 0 AND 100
          THEN SAFE_CAST(age AS INT64)
        ELSE NULL
        END AS age,
      CASE
        WHEN UPPER(TRIM(gender)) IN ('MALE', 'M') THEN 'Male'
        WHEN UPPER(TRIM(gender)) IN ('FEMALE', 'F') THEN 'Female'
        WHEN UPPER(TRIM(gender)) = 'OTHER' THEN 'Other'
        ELSE NULL
        END AS gender,
      region,
      city,
      product_category,
      product_name,
      ABS(quantity) AS quantity,
      unit_price,
      COALESCE(discount_pct, 0) AS discount_pct,
      sales_amount,
      profit,
      ABS(shipping_cost) AS shipping_cost,
      payment_method,
      customer_satisfaction,
      SAFE_CAST(return_flag AS BOOL) AS return_flag,
      INITCAP(TRIM(order_status)) AS order_status,
      days_to_ship,
      ROW_NUMBER()
        OVER (
          PARTITION BY order_id
          ORDER BY order_id
        ) AS row_num
    FROM `namaste-mart-506509.namaste.master`
    WHERE
      order_id IS NOT NULL
      AND customer_id IS NOT NULL
      AND quantity != 999
  ),
  deduped AS (
    SELECT * EXCEPT (row_num)
    FROM clean_data
    WHERE row_num = 1
  ),
  median_age AS (
    SELECT
      APPROX_QUANTILES(age, 2)[OFFSET(1)] AS median_age
    FROM deduped
    WHERE age IS NOT NULL
  )
SELECT
  d.* EXCEPT (age),
  COALESCE(d.age, m.median_age) AS age
FROM deduped d
CROSS JOIN median_age m;
