

with fact as (
    select *
    from MY_PROJECT_DB.MY_SCHEMA.fact_game_sales
    where global_sales > 5
),

dim_game as (
    select * from MY_PROJECT_DB.MY_SCHEMA.dim_game
),

dim_platform as (
    select * from MY_PROJECT_DB.MY_SCHEMA.dim_platform
),

dim_genre as (
    select * from MY_PROJECT_DB.MY_SCHEMA.dim_genre
),

dim_sales_category as (
    select * from MY_PROJECT_DB.MY_SCHEMA.dim_sales_category
),

dim_region as (
    select * from MY_PROJECT_DB.MY_SCHEMA.dim_region
)

select
    f.game_id,
    g.name as game_name,
    g.developer,
    g.publisher,

    pl.platform,
    ge.genre,
    sc.sales_category,
    rg.region_name as region_with_highest_sales,

    g.year,
    g.decade,
    g.release_season,
    g.years_since_release,

    g.age_rating,
    g.multiplayer_support,
    g.dlc_available,
    g.remastered_version,

    f.na_sales,
    f.eu_sales,
    f.jp_sales,
    f.other_sales,
    f.global_sales,
    f.critic_score,
    f.user_score,
    f.review_count,
    f.revenue,
    f.cost_of_production,
    f.profit,
    f.roi,

    f.loaded_at

from fact f
left join dim_game g on f.game_id = g.game_id
left join dim_platform pl on f.platform_id = pl.platform_id
left join dim_genre ge on f.genre_id = ge.genre_id
left join dim_sales_category sc on f.sales_category_id = sc.sales_category_id
left join dim_region rg on f.region_id = rg.region_id