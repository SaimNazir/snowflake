select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select game_id
from MY_PROJECT_DB.MY_SCHEMA.stg_games_data
where game_id is null



      
    ) dbt_internal_test