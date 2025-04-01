-- back compat for old kwarg name
  
  begin;
    

        insert into MY_PROJECT_DB.MY_SCHEMA.fact_game_sales ("GAME_ID", "PLATFORM_ID", "GENRE_ID", "GLOBAL_SALES", "NA_SALES", "EU_SALES", "JP_SALES", "OTHER_SALES", "CRITIC_SCORE", "USER_SCORE", "REVIEW_COUNT", "LOADED_AT")
        (
            select "GAME_ID", "PLATFORM_ID", "GENRE_ID", "GLOBAL_SALES", "NA_SALES", "EU_SALES", "JP_SALES", "OTHER_SALES", "CRITIC_SCORE", "USER_SCORE", "REVIEW_COUNT", "LOADED_AT"
            from MY_PROJECT_DB.MY_SCHEMA.fact_game_sales__dbt_tmp
        );
    commit;