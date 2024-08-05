{{ config(
    materialized='table'
) }}


SELECT
    *
FROM {{ source('city_weather', 'seed_city_weather') }}
WHERE location_name != '1006'
