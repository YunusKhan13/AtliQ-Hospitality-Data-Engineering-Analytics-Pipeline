{{ config(materialized='view') }}

-- Staging model for raw_zone.DIM_DATE

SELECT
  "date" AS full_date,
  "month_year" AS month_year,
  "week_no" AS week_number,
  "day_type" AS day_type
FROM {{ source('raw_zone', 'DIM_DATE') }}
