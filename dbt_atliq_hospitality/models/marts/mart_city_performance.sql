{{ config(materialized='table') }}

WITH city_occ AS (
    SELECT 
        c.check_in_date,
        c.city,
        SUM(c.total_bookings) AS total_bookings,
        SUM(c.total_capacity) AS total_capacity,
        ROUND(AVG(c.occupancy_rate), 2) AS avg_occupancy_rate
    FROM {{ ref('int_city_level_demand') }} c
    GROUP BY 1, 2
),
city_rev AS (
    SELECT 
        h.city,
        b.check_in_date,
        SUM(b.revenue_generated) AS total_revenue_generated,
        SUM(b.revenue_realized) AS total_revenue_realized
    FROM {{ ref('stg_bookings') }} b
    JOIN {{ ref('stg_hotels') }} h
        ON b.hotel_id = h.hotel_id
    GROUP BY 1, 2
)

SELECT 
    occ.check_in_date,
    occ.city,
    occ.total_bookings,
    occ.total_capacity,
    occ.avg_occupancy_rate,
    rev.total_revenue_generated,
    rev.total_revenue_realized
FROM city_occ occ
LEFT JOIN city_rev rev
    ON occ.city = rev.city
   AND occ.check_in_date = rev.check_in_date
ORDER BY occ.check_in_date, occ.city
