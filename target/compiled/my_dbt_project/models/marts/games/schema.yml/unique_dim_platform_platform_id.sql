
    
    

select
    platform_id as unique_field,
    count(*) as n_records

from MY_PROJECT_DB.MY_SCHEMA.dim_platform
where platform_id is not null
group by platform_id
having count(*) > 1


