-- back compat for old kwarg name
  
  begin;
    
        
            
	    
	    
            
        
    

    

    merge into MY_PROJECT_DB.MY_SCHEMA.dim_sales_category as DBT_INTERNAL_DEST
        using MY_PROJECT_DB.MY_SCHEMA.dim_sales_category__dbt_tmp as DBT_INTERNAL_SOURCE
        on ((DBT_INTERNAL_SOURCE.sales_category_id = DBT_INTERNAL_DEST.sales_category_id))

    
    when matched then update set
        "SALES_CATEGORY_ID" = DBT_INTERNAL_SOURCE."SALES_CATEGORY_ID","SALES_CATEGORY" = DBT_INTERNAL_SOURCE."SALES_CATEGORY","LOADED_AT" = DBT_INTERNAL_SOURCE."LOADED_AT"
    

    when not matched then insert
        ("SALES_CATEGORY_ID", "SALES_CATEGORY", "LOADED_AT")
    values
        ("SALES_CATEGORY_ID", "SALES_CATEGORY", "LOADED_AT")

;
    commit;