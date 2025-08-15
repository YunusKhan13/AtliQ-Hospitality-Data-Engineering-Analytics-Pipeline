{{ config(materialized='view') }}

-- Staging model for raw_zone.FACT_AGGREGATED_BOOKINGS

SELECT
  "property_id" AS hotel_id,
  "check_in_date" AS check_in_date,
  "room_category" AS room_class,
  "successful_bookings" AS successful_bookings,
  "capacity" AS capacity
FROM {{ source('raw_zone', 'FACT_AGGREGATED_BOOKINGS') }}
