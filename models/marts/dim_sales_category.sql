{{ config(
    materialized='incremental',
    unique_key='sales_category_id'
) }}



with base as (
    select distinct
        sales_category as sales_category_id,
        sales_category,
        loaded_at
    from {{ ref('stg_games_data') }}
    {{ incremental_filter('loaded_at') }}
    )


select
    sales_category_id,
    sales_category,
    loaded_at
from base
