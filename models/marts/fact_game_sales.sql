{{ config(
    materialized='incremental',
    unique_key=generate_surrogate_key('game_id || \'-\' || region_code')
) }}

with base as (
    select * 
    from {{ ref('stg_games_data') }}
    {{ incremental_filter('loaded_at') }}
),

unpivoted as (
    select game_id, platform, genre, 'NA' as region_code, na_sales as sales, 
           critic_score, user_score, review_count, loaded_at
    from base
    union all
    select game_id, platform, genre, 'EU', eu_sales, 
           critic_score, user_score, review_count, loaded_at
    from base
    union all
    select game_id, platform, genre, 'JP', jp_sales, 
           critic_score, user_score, review_count, loaded_at
    from base
    union all
    select game_id, platform, genre, 'Other', other_sales, 
           critic_score, user_score, review_count, loaded_at
    from base
),

joined as (
    select
        u.game_id,
        dp.platform_id,
        dg.genre_id,
        dr.region_id,
        u.sales,
        u.critic_score,
        u.user_score,
        u.review_count,
        u.loaded_at
    from unpivoted u
    left join {{ ref('dim_platform') }} dp on u.platform = dp.platform
    left join {{ ref('dim_genre') }} dg on u.genre = dg.genre
    left join {{ ref('dim_region') }} dr on u.region_code = dr.region_code
)

select * from joined
