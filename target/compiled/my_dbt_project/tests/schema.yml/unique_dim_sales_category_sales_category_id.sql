
    
    

select
    sales_category_id as unique_field,
    count(*) as n_records

from MY_PROJECT_DB.MY_SCHEMA.dim_sales_category
where sales_category_id is not null
group by sales_category_id
having count(*) > 1


