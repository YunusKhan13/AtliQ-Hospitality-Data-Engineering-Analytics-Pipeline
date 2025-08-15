{{ config(materialized='view') }}

-- Staging model for raw_zone.DIM_ROOMS

SELECT
  "room_id" AS room_id,
  "room_class" AS room_class
FROM {{ source('raw_zone', 'DIM_ROOMS') }}
