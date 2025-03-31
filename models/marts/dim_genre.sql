{{ config(
    materialized='incremental',
    unique_key='genre_id'
) }}



with base as (
    select distinct
        genre as genre_id,
        genre,
        loaded_at
    from {{ ref('stg_games_data') }}
    {{ incremental_filter('loaded_at') }}
    )

select
    genre_id,
    genre,
    loaded_at
from base
