SELECT
  ab.check_in_date,
  h.category AS hotel_category,
  SUM(ab.successful_bookings) AS total_bookings,
  SUM(ab.capacity) AS total_capacity,
  ROUND(SUM(ab.successful_bookings)::FLOAT / NULLIF(SUM(ab.capacity), 0), 2) AS occupancy_rate
FROM {{ ref('stg_aggregated_bookings') }} ab
JOIN {{ ref('stg_hotels') }} h
  ON ab.hotel_id = h.hotel_id
GROUP BY ab.check_in_date, h.category
ORDER BY ab.check_in_date, h.category
