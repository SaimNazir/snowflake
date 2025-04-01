{{ config(
    materialized='incremental',
) }}

with base as (
    select * 
    from {{ ref('stg_games_data') }}
    {{ incremental_filter('loaded_at') }}
),

joined as (
    select
        b.game_id,
        dp.platform_id,
        dg.genre_id,
        b.global_sales,
        b.na_sales,
        b.eu_sales,
        b.jp_sales,
        b.other_sales,
        b.critic_score,
        b.user_score,
        b.review_count,
        b.loaded_at
    from base b
    left join {{ ref('dim_platform') }} dp on b.platform = dp.platform
    left join {{ ref('dim_genre') }} dg on b.genre = dg.genre
)

select * from joined
