{{ config(
    materialized='incremental',
    unique_key="concat(game_id, '-', region_id)"
    ) }}

with base as (
    select * 
    from {{ ref('stg_games_data') }}
    {{ incremental_filter('loaded_at') }}
),

unpivoted as (
    select game_id, 'NA' as region_code, na_sales as sales, loaded_at from base
    union all
    select game_id, 'EU', eu_sales, loaded_at from base
    union all
    select game_id, 'JP', jp_sales, loaded_at from base
    union all
    select game_id, 'Other', other_sales, loaded_at from base
),

with_ids as (
    select
        u.game_id,
        r.region_id,
        u.sales,
        u.loaded_at
    from unpivoted u
    left join {{ ref('dim_region') }} r
        on u.region_code = r.region_code
)

select * from with_ids
