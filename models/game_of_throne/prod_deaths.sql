{{
    config(
        materialized='table'
    )
}}

WITH seed_deaths AS (
    SELECT
    *
    FROM {{ source('game_of_throne', 'seed_deaths') }}
)

SELECT
    Allegiance as allegiance,
    `Death No` as death_number,
    Episode as episode,
    Killer as killer,
    `Killers House` as killer_house,
    Location as location,
    Method as killing_method,
    Name as killed_character,
    Season as season
FROM seed_deaths