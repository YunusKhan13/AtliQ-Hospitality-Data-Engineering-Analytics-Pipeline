SELECT
  DATE_TRUNC('month', b.booking_date) AS cancellation_month,
  b.status,
  b.platform,
  h.category AS hotel_category,
  COUNT(DISTINCT b.booking_id) AS cancellations
FROM {{ ref('stg_bookings') }} b
JOIN {{ ref('stg_hotels') }} h
  ON b.hotel_id = h.hotel_id
WHERE b.status = 'Cancelled'
GROUP BY cancellation_month, b.platform, h.category, b.status
ORDER BY cancellation_month DESC
