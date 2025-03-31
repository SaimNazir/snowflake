{{ config(
    materialized='incremental',
    unique_key='region_id'
) }}

with base as (
    select distinct
        region_with_highest_sales as region_id,
        region_with_highest_sales as region_name,
        loaded_at
    from {{ ref('stg_games_data') }}
    {{ incremental_filter('loaded_at') }}
)

select
    region_id,
    region_name,
    loaded_at
from base
