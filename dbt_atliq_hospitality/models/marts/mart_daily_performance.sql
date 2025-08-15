{{ config(materialized='table') }}

WITH daily_occupancy AS (
  SELECT
    check_in_date,
    hotel_category,
    occupancy_rate
  FROM {{ ref('int_daily_occupancy_by_category') }}
),

daily_cancellations AS (
  SELECT
    check_in_date,
    hotel_category,
    SUM(cancellations) AS total_cancellations
  FROM {{ ref('int_cancellation_behavior') }}
  GROUP BY check_in_date, hotel_category
)

SELECT
  do.check_in_date,
  do.hotel_category,
  do.occupancy_rate,
  COALESCE(dc.total_cancellations, 0) AS daily_cancellations
FROM daily_occupancy do
LEFT JOIN daily_cancellations dc
  ON do.check_in_date = dc.check_in_date AND do.hotel_category = dc.hotel_category
ORDER BY do.check_in_date, do.hotel_category