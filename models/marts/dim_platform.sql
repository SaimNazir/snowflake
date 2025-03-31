{{ config(
    materialized='table',
    unique_key='platform_id'
) }}

with base as (
    select
        {{ generate_surrogate_key('platform') }} as platform_id,

        platform
    from {{ ref('stg_games_data') }}
    group by platform
)

select
    platform_id,
    platform
from base