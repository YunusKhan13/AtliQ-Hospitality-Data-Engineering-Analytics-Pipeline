{{ config(materialized='table') }}

SELECT 
    d.check_in_date,
    d.hotel_category,
    d.total_bookings,
    d.total_capacity,
    d.occupancy_rate,
    c.cancellations AS daily_cancellations
FROM {{ ref('int_daily_occupancy_by_category') }} d
LEFT JOIN (
    SELECT 
        check_in_date,
        hotel_category,
        SUM(cancellations) AS cancellations
    FROM {{ ref('int_cancellation_behavior') }}
    WHERE status = 'Cancelled'
    GROUP BY 1, 2
) c
    ON d.check_in_date = c.check_in_date
   AND d.hotel_category = c.hotel_category
ORDER BY d.check_in_date, d.hotel_category
