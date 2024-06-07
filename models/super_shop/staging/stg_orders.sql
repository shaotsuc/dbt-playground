SELECT
  PARSE_DATE('%d.%m.%Y', `Order Date`) AS order_date,
  PARSE_DATE('%d.%m.%Y', `Ship Date`) AS ship_date,
  `Order ID` AS order_id,
  `Customer ID` AS customer_id,
  `Customer Name` AS customer_name,
  Discount AS discount,
  Country AS country,
  Region AS region,
  State AS state,
  CAST(`Postal Code` AS STRING) AS postal_code,
  City AS city,
  Category AS product_category,
  `Sub-Category` AS product_sub_category,
  `Product ID` AS product_id,
  `Product Name` AS product_name,
  Sales AS sales,
  Quantity AS quantity,
  /* 
  Ideally, the straightforward business rule for the cost. 
  However, it's always good to double-confirm with the stakeholders how they want it to be calculated.
   */
  Sales - Profit AS cost,
  Profit AS profit,
  SAFE_DIVIDE(Profit,Sales) AS margin,
  Segment AS buyer_segment,
  `Ship Mode` AS ship_mode,
FROM {{ source('super_shop', 'orders_raw') }}