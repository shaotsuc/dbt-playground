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
    o.*,
    m.manager,
    COALESCE(is_returned, FALSE) as is_returned
FROM {{ ref('stg_orders') }} AS o
LEFT JOIN `manager` m ON o.region = m.region
LEFT JOIN `returns` r ON o.order_id = r.order_id