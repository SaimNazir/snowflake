{{ config(
    materialized='incremental',
    unique_key='game_id'
) }}

with base as (
    select * 
    from {{ ref('stg_games_data') }}
    {{ incremental_filter('loaded_at') }}
)

select
    game_id,
    {{ generate_surrogate_key('platform') }} as platform_id,
    {{ generate_surrogate_key('genre') }} as genre_id,

    na_sales,
    eu_sales,
    jp_sales,
    other_sales,
    global_sales,
    critic_score,
    user_score,
    review_count,
    loaded_at
from base
