{{ config(materialized='view') }}

-- Staging model for raw_zone.FACT_BOOKINGS

SELECT
  "booking_id" AS booking_id,
  "property_id" AS hotel_id,
  "booking_date" AS booking_date,
  "check_in_date" AS check_in_date,
  "check_out_date" AS check_out_date,
  "no_guests" AS guests_count,
  "room_category" AS room_class,
  "booking_platform" AS platform,
  "ratings_given" AS rating,
  "booking_status" AS status,
  "revenue_generated" AS revenue_generated,
  "revenue_realized" AS revenue_realized
FROM {{ source('raw_zone', 'FACT_BOOKINGS') }}
