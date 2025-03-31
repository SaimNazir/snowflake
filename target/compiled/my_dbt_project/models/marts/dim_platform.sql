

with base as (
    select
        
    md5(lower(trim(platform)))
 as platform_id,

        platform
    from MY_PROJECT_DB.MY_SCHEMA.stg_games_data
    group by platform
)

select
    platform_id,
    platform
from base