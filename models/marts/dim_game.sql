{{ config(
    materialized='incremental',
    unique_key='game_id'
) }}



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
    from {{ ref('stg_games_data') }}
    {{ incremental_filter('loaded_at') }}
)

select * from base
