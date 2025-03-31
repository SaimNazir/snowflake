


with base as (
    select * 
    from MY_PROJECT_DB.MY_SCHEMA.stg_games_data
    
    
        where loaded_at > (select max(loaded_at) from MY_PROJECT_DB.MY_SCHEMA.fact_game_sales)
    

)

select
    game_id,
    
    md5(lower(trim(region_with_highest_sales)))
 as region_id,
    
    md5(lower(trim(platform)))
 as platform_id,
    
    md5(lower(trim(genre)))
 as genre_id,
    
    md5(lower(trim(sales_category)))
 as sales_category_id,
    
    na_sales,
    eu_sales,
    jp_sales,
    other_sales,
    global_sales,
    critic_score,
    user_score,
    review_count,
    revenue,
    cost_of_production,
    profit,
    roi,
    loaded_at
from base