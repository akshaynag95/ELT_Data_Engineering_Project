{{ config(materialized='table', schema='dw_video_analytics') }}

select 
    vd.video_id as video_id,
    vd.published_at as published_at,
    vd.channel_id as channel_id,
    vd.title as title,
    vd.channel_title as channel_title,
    vs.view_count as view_count,
    vs.like_count as like_count,
    vs.favorite_count as favorite_count,
    vs.comment_count as comment_count,
    current_timestamp as data_as_of
from {{ ref('video_details_prep') }} as vd
left join {{ ref('video_stats_prep') }} as vs on vs.id = vd.video_id
