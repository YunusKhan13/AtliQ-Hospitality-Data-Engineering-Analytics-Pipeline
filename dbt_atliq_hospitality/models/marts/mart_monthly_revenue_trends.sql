{{ config(materialized='table') }}

WITH revenue AS (
    SELECT 
        DATE_TRUNC('month', check_in_date) AS month_start,
        platform,
        SUM(revenue_generated) AS total_revenue_generated,
        SUM(revenue_realized) AS total_revenue_realized,
        SUM(unrealized_loss) AS total_unrealized_loss
    FROM {{ ref('int_unrealized_revenue_by_platform') }}
    GROUP BY 1, 2
)

SELECT 
    month_start,
    platform,
    total_revenue_generated,
    total_revenue_realized,
    total_unrealized_loss,
    ROUND((total_revenue_realized / NULLIF(total_revenue_generated, 0)) * 100, 2) AS realization_rate_pct
FROM revenue
ORDER BY month_start, platform
