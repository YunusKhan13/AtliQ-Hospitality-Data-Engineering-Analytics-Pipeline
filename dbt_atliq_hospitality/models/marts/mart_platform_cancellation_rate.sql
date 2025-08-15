{{ config(materialized='table') }}

WITH cancel_data AS (
    SELECT 
        check_in_date,
        platform,
        SUM(CASE WHEN status = 'Cancelled' THEN cancellations ELSE 0 END) AS cancelled_bookings,
        SUM(cancellations) AS total_bookings
    FROM {{ ref('int_cancellation_behavior') }}
    GROUP BY 1, 2
)

SELECT 
    check_in_date,
    platform,
    cancelled_bookings,
    total_bookings,
    ROUND((cancelled_bookings / NULLIF(total_bookings, 0)) * 100, 2) AS cancellation_rate_pct
FROM cancel_data
ORDER BY check_in_date, platform
