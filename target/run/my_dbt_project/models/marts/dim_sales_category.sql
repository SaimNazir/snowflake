
  
    

        create or replace transient table MY_PROJECT_DB.MY_SCHEMA.dim_sales_category
         as
        (

with base as (
    select
        
    md5(lower(trim(['sales_category'])))
 as surrogate_key,
        sales_category as sales_category_name
    from MY_PROJECT_DB.MY_SCHEMA.stg_games_data
)

select
    surrogate_key,
    sales_category_name
from base
        );
      
  