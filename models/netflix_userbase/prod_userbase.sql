{{
    config(
        materialized='table'
    )
}}


WITH userbase AS (
    SELECT
        *
    FROM {{ source('netflix_userbase', 'userbase') }}
)

SELECT
    `User ID` as user_id,
    `Subscription Type` as subscription_type,
    `Monthly Revenue` as monthly_revenue,
    `Join Date` as joined_date,
    `Last Payment Date` as last_payment_date,
    Country as user_country,
    Age as age,
    Gender as gender,
    Device as device,
    `Plan Duration` as plan_duration
FROM userbase