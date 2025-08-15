SELECT
  b.check_in_date,
  b.platform,
  SUM(b.revenue_generated) AS revenue_generated,
  SUM(b.revenue_realized) AS revenue_realized,
  SUM(b.revenue_generated - b.revenue_realized) AS unrealized_loss
FROM {{ ref('stg_bookings') }} b
GROUP BY b.check_in_date, b.platform
ORDER BY b.check_in_date
