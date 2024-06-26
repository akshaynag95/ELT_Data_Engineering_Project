{{ config(materialized='view', schema='mart_video_analytics') }}

select *
from {{ ref('video_analytics') }}