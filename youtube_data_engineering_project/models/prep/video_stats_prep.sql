{{ config(materialized='view', schema='video_analytics_prep') }}

with source as (
    select * 
    from {{ source('youtube_video_analytics_source','video_stats')}}
),

renamed as (
    select 
        id as id,
        cast("statistics.viewCount" as int) as view_count,
        cast("statistics.likeCount" as int) as like_count,
        cast("statistics.favoriteCount" as int) as favorite_count,
        cast("statistics.commentCount" as int) as comment_count
    from source
 )

 select *,
 current_timestamp as data_as_of
 from renamed