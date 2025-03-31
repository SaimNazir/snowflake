

with regions as (
    select 'NA' as region_code, 'North America' as region_name
    union all
    select 'EU', 'Europe'
    union all
    select 'JP', 'Japan'
    union all
    select 'Other', 'Other Regions'
),

with_ids as (
    select
        
    md5(lower(trim(region_code)))
 as region_id,
        region_code,
        region_name
    from regions
)

select
    region_id,
    region_code,
    region_name
from with_ids