WITH manager AS (
    SELECT
        Person AS manager,
        Region AS region
    FROM {{ source('super_shop', 'people_raw') }}
),

returns AS (
    SELECT
        `Order ID` as order_id,
        Returned AS is_returned,
    FROM {{ source('super_shop', 'returns_raw') }}
)

SELECT
    o.order_date,
    o.ship_date,
    o.order_id,
    o.customer_id,
    o.customer_name,
    o.buyer_segment,
    o.country,
    o.region,
    o.state,
    o.postal_code,
    o.city,
    o.product_category,
    o.product_sub_category,
    o.product_id,
    o.product_name,
    o.ship_mode,
    o.gross_sales,
    o.discount_percent,
    o.net_sales,
    o.quantity,
    o.net_sales - o.profit AS cost,
    o.profit,
    CASE 
        WHEN o.net_sales >= 2000 AND COALESCE(r.is_returned, FALSE) = FALSE 
        THEN TRUE 
        ELSE FALSE 
    END AS is_high_value_sales,
    m.manager,
    COALESCE(r.is_returned, FALSE) as is_returned
FROM {{ ref('stg_orders') }} AS o
LEFT JOIN `manager` m ON o.region = m.region
LEFT JOIN `returns` r ON o.order_id = r.order_id