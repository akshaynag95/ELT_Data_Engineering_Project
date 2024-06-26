{{ config(materialized='view', schema='video_analytics_prep') }}

with source as (
    select * 
    from {{ source('video_analytics','video_details')}}
),

renamed as (
    select
        concat(substring("id.kind",1,7), ' ', substring("id.kind", 9, 13)) as kind,
        "id.videoId" as video_id,
        cast(substring("snippet.publishedAt",1, 10) as date) as published_at,
        "snippet.channelId" as channel_id,
        "snippet.title" as title,
        "snippet.description" as description,
        "snippet.channelTitle" as channel_title
    from source
)

select *,
current_timestamp as data_as_of
from renamed