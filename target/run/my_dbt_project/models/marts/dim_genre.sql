-- back compat for old kwarg name
  
  begin;
    
        
            
	    
	    
            
        
    

    

    merge into MY_PROJECT_DB.MY_SCHEMA.dim_genre as DBT_INTERNAL_DEST
        using MY_PROJECT_DB.MY_SCHEMA.dim_genre__dbt_tmp as DBT_INTERNAL_SOURCE
        on ((DBT_INTERNAL_SOURCE.genre_id = DBT_INTERNAL_DEST.genre_id))

    
    when matched then update set
        "GENRE_ID" = DBT_INTERNAL_SOURCE."GENRE_ID","GENRE" = DBT_INTERNAL_SOURCE."GENRE","LOADED_AT" = DBT_INTERNAL_SOURCE."LOADED_AT"
    

    when not matched then insert
        ("GENRE_ID", "GENRE", "LOADED_AT")
    values
        ("GENRE_ID", "GENRE", "LOADED_AT")

;
    commit;