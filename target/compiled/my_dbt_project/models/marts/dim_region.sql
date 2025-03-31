

with base as (
    select distinct
        region_with_highest_sales as region_id,
        region_with_highest_sales as region_name,
        loaded_at
    from MY_PROJECT_DB.MY_SCHEMA.stg_games_data
    
    
        where loaded_at > (select max(loaded_at) from MY_PROJECT_DB.MY_SCHEMA.dim_region)
    

)

select
    region_id,
    region_name,
    loaded_at
from base