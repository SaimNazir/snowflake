

with base as (
    select
        game_id,
        name,
        developer,
        publisher,
        
    md5(lower(trim(platform)))
 as platform_id,
        
    md5(lower(trim(genre)))
 as genre_id,
        year,
        release_season,
        age_rating,
        multiplayer_support,
        dlc_available,
        remastered_version,
        loaded_at
    from MY_PROJECT_DB.MY_SCHEMA.stg_games_data
    
    

)

select * from base