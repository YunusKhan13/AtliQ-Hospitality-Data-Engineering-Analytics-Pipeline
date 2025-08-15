{{ config(materialized='view') }}

SELECT
  "property_id"   AS hotel_id,
  "property_name" AS hotel_name,
  "category" AS category,
  "city" AS city
FROM {{ source('raw_zone', 'DIM_HOTELS') }}
