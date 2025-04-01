{{ config(
    materialized='table'
) }}

with fact as (
    select *
    from {{ ref('fact_game_sales') }}
    where region_id = (select region_id from {{ ref('dim_region') }} where region_code = 'NA')
      and sales > 5
),

dim_game as (
    select *
    from {{ ref('dim_game') }}
    where remastered_version = true
),

dim_platform as (
    select * from {{ ref('dim_platform') }}
),

dim_genre as (
    select * from {{ ref('dim_genre') }}
)

select
    f.game_id,
    g.name as game_name,
    g.developer,
    g.publisher,

    pl.platform,
    ge.genre,

    g.year,
    g.release_season,
    g.age_rating,
    g.multiplayer_support,
    g.dlc_available,
    g.remastered_version,

    f.sales as na_sales,

    f.critic_score,
    f.user_score,
    f.review_count,

    f.loaded_at

from fact f
inner join dim_game g on f.game_id = g.game_id
left join dim_platform pl on f.platform_id = pl.platform_id
left join dim_genre ge on f.genre_id = ge.genre_id
