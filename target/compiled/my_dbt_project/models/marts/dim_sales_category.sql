



with base as (
    select distinct
        sales_category as sales_category_id,
        sales_category,
        loaded_at
    from MY_PROJECT_DB.MY_SCHEMA.stg_games_data
    
    
        where loaded_at > (select max(loaded_at) from MY_PROJECT_DB.MY_SCHEMA.dim_sales_category)
    

    )


select
    sales_category_id,
    sales_category,
    loaded_at
from base