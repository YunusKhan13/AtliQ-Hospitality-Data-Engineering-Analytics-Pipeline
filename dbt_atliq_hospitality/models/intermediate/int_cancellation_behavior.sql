SELECT
  b.check_in_date,
  b.status,
  b.platform,
  h.category AS hotel_category,
  COUNT(DISTINCT b.booking_id) AS cancellations
FROM {{ ref('stg_bookings') }} b
JOIN {{ ref('stg_hotels') }} h
  ON b.hotel_id = h.hotel_id
WHERE b.status = 'Cancelled'
GROUP BY b.check_in_date, b.platform, h.category, b.status
ORDER BY b.check_in_date DESC
