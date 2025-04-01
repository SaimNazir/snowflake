{{ config(
    materialized='table',
    unique_key='game_id'
) }}

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
    from {{ ref('stg_games_data') }}

)

select * from base



