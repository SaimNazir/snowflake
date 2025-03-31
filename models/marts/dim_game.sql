{{ config(
    materialized='incremental',
    unique_key='game_id'
) }}

with base as (
    select
        game_id,
        name,
        developer,
        publisher,
        {{ generate_surrogate_key('platform') }} as platform_id,
        {{ generate_surrogate_key('genre') }} as genre_id,
        year,
        release_season,
        age_rating,
        multiplayer_support,
        dlc_available,
        remastered_version,
        loaded_at
    from {{ ref('stg_games_data') }}
    {{ incremental_filter('loaded_at') }}
)

select * from base
