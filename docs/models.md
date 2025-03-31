# dbt Models Overview

## `stg_games_data`
Raw game data cleaned and typed.

## `fact_game_sales`
Fact table containing sales, reviews, and financials by game and region.

## `dim_game`
Describes game attributes including developer, publisher, and features.

## `dim_platform`
Reference table for platform names.

## `dim_genre`
Reference table for game genres.

## `dim_region`
Reference table for dominant sales regions.

## `dim_sales_category`
Reference table for sales performance categories.

---
# Notes:
- Fact and dimension tables follow a star schema
- Surrogate keys are implied through consistent alias naming (e.g., `platform_id`, `region_id`)
- All dimensions are materialized as tables
- Data is clean, typed, and documented with enforced tests