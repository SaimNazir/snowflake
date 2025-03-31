select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select sales_category_id
from MY_PROJECT_DB.MY_SCHEMA.dim_sales_category
where sales_category_id is null



      
    ) dbt_internal_test