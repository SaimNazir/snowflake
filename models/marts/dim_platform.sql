{{ config(
    materialized='incremental',
    unique_key='platform_id'
) }}


with base as (
    select distinct
        {{ generate_surrogate_key('platform') }} as platform_id,
        platform,
        loaded_at
    from {{ ref('stg_games_data') }}
    {{ incremental_filter('loaded_at') }}
    )

select
    platform_id,
    platform,
    loaded_at
from base
