WITH manager AS (
    SELECT
        Person AS manager,
        Region AS region
    FROM {{ source('super_shop', 'people_raw') }}
)

SELECT
    o.*,
    m.manager,
FROM {{ ref('stg_orders') }} AS o
LEFT JOIN `manager` m ON o.region = m.region