

with base as (
    select * 
    from MY_PROJECT_DB.MY_SCHEMA.stg_games_data
    
    
        where loaded_at > (select max(loaded_at) from MY_PROJECT_DB.MY_SCHEMA.mart_region_sales)
    

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
    left join MY_PROJECT_DB.MY_SCHEMA.dim_region r
        on u.region_code = r.region_code
)

select
    game_id,
    region_id,
    sales,
    loaded_at
from with_ids