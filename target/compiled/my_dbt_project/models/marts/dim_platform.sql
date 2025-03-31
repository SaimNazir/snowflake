


with base as (
    select distinct
        
    md5(lower(trim(platform)))
 as platform_id,
        platform,
        loaded_at
    from MY_PROJECT_DB.MY_SCHEMA.stg_games_data
    
    
        where loaded_at > (select max(loaded_at) from MY_PROJECT_DB.MY_SCHEMA.dim_platform)
    

    )

select
    platform_id,
    platform,
    loaded_at
from base