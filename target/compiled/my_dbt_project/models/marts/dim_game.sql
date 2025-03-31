



with base as (
    select distinct
        game_id,
        name,
        developer,
        publisher,
        platform as platform_id,
        genre as genre_id,
        year,
        decade,
        release_season,
        years_since_release,
        age_rating,
        multiplayer_support,
        dlc_available,
        remastered_version,
        loaded_at
    from MY_PROJECT_DB.MY_SCHEMA.stg_games_data
    
    
        where loaded_at > (select max(loaded_at) from MY_PROJECT_DB.MY_SCHEMA.dim_game)
    

)

select * from base