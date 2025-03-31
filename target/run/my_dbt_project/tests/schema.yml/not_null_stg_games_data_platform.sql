select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select platform
from MY_PROJECT_DB.MY_SCHEMA.stg_games_data
where platform is null



      
    ) dbt_internal_test