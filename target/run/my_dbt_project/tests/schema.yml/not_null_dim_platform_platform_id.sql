select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select platform_id
from MY_PROJECT_DB.MY_SCHEMA.dim_platform
where platform_id is null



      
    ) dbt_internal_test