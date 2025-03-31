{{ config(
    materialized='table',
    unique_key='genre_id'
) }}

with base as (
    select
        {{ generate_surrogate_key('genre') }} as genre_id,
        genre
    from {{ ref('stg_games_data') }}
    group by genre
)

select
    genre_id,
    genre
from base