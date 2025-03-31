{{ config(
    materialized='incremental',
    unique_key='game_id'
) }}

with source as (
    select * from {{ source('raw', 'RAW_GAMES_DATA') }}
    {% if is_incremental() %}
        where loaded_at > (select max(loaded_at) from {{ this }})
    {% endif %}
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
