-- back compat for old kwarg name
  
  begin;
    
        
            
	    
	    
            
        
    

    

    merge into MY_PROJECT_DB.MY_SCHEMA.mart_region_sales as DBT_INTERNAL_DEST
        using MY_PROJECT_DB.MY_SCHEMA.mart_region_sales__dbt_tmp as DBT_INTERNAL_SOURCE
        on ((DBT_INTERNAL_SOURCE.concat(u.game_id, '-', r.region_id) = DBT_INTERNAL_DEST.concat(u.game_id, '-', r.region_id)))

    
    when matched then update set
        "GAME_ID" = DBT_INTERNAL_SOURCE."GAME_ID","REGION_ID" = DBT_INTERNAL_SOURCE."REGION_ID","SALES" = DBT_INTERNAL_SOURCE."SALES","LOADED_AT" = DBT_INTERNAL_SOURCE."LOADED_AT"
    

    when not matched then insert
        ("GAME_ID", "REGION_ID", "SALES", "LOADED_AT")
    values
        ("GAME_ID", "REGION_ID", "SALES", "LOADED_AT")

;
    commit;