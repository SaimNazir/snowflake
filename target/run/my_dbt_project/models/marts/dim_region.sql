-- back compat for old kwarg name
  
  begin;
    
        
            
	    
	    
            
        
    

    

    merge into MY_PROJECT_DB.MY_SCHEMA.dim_region as DBT_INTERNAL_DEST
        using MY_PROJECT_DB.MY_SCHEMA.dim_region__dbt_tmp as DBT_INTERNAL_SOURCE
        on ((DBT_INTERNAL_SOURCE.region_id = DBT_INTERNAL_DEST.region_id))

    
    when matched then update set
        "REGION_ID" = DBT_INTERNAL_SOURCE."REGION_ID","REGION_NAME" = DBT_INTERNAL_SOURCE."REGION_NAME","LOADED_AT" = DBT_INTERNAL_SOURCE."LOADED_AT"
    

    when not matched then insert
        ("REGION_ID", "REGION_NAME", "LOADED_AT")
    values
        ("REGION_ID", "REGION_NAME", "LOADED_AT")

;
    commit;