select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select region_id
from MY_PROJECT_DB.MY_SCHEMA.dim_region
where region_id is null



      
    ) dbt_internal_test