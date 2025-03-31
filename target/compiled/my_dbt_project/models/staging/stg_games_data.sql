

with source as (
    select * from MY_PROJECT_DB.MY_SCHEMA.RAW_GAMES_DATA
    
        where loaded_at > (select max(loaded_at) from MY_PROJECT_DB.MY_SCHEMA.stg_games_data)
    
),

renamed as (
    select
        rank,
        game_id,
        name,
        platform,
        year::int as year,
        genre,
        publisher,
        na_sales,
        eu_sales,
        jp_sales,
        other_sales,
        global_sales,
        age_rating,
        critic_score,
        user_score,
        review_count,
        developer,
        release_season,
        cast(multiplayer_support as boolean) as multiplayer_support,
        cast(dlc_available as boolean) as dlc_available,
        cast(remastered_version as boolean) as remastered_version,
        loaded_at
    from source
)

select * from renamed