

with base as (
    select
        game_id,
        name,
        developer,
        publisher,
        year,
        release_season,
        age_rating,
        multiplayer_support,
        dlc_available,
        remastered_version
    from MY_PROJECT_DB.MY_SCHEMA.stg_games_data

)

select * from base