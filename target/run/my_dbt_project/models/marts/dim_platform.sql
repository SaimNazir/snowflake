-- back compat for old kwarg name
  
  begin;
    
        
            
	    
	    
            
        
    

    

    merge into MY_PROJECT_DB.MY_SCHEMA.dim_platform as DBT_INTERNAL_DEST
        using MY_PROJECT_DB.MY_SCHEMA.dim_platform__dbt_tmp as DBT_INTERNAL_SOURCE
        on ((DBT_INTERNAL_SOURCE.platform_id = DBT_INTERNAL_DEST.platform_id))

    
    when matched then update set
        "PLATFORM_ID" = DBT_INTERNAL_SOURCE."PLATFORM_ID","PLATFORM" = DBT_INTERNAL_SOURCE."PLATFORM","LOADED_AT" = DBT_INTERNAL_SOURCE."LOADED_AT"
    

    when not matched then insert
        ("PLATFORM_ID", "PLATFORM", "LOADED_AT")
    values
        ("PLATFORM_ID", "PLATFORM", "LOADED_AT")

;
    commit;