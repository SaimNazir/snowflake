

with base as (
    select * 
    from MY_PROJECT_DB.MY_SCHEMA.stg_games_data
    
    
        where loaded_at > (select max(loaded_at) from MY_PROJECT_DB.MY_SCHEMA.fact_game_sales)
    

),

joined as (
    select
        b.game_id,
        dp.platform_id,
        dg.genre_id,
        b.global_sales,
        b.na_sales,
        b.eu_sales,
        b.jp_sales,
        b.other_sales,
        b.critic_score,
        b.user_score,
        b.review_count,
        b.loaded_at
    from base b
    left join MY_PROJECT_DB.MY_SCHEMA.dim_platform dp on b.platform = dp.platform
    left join MY_PROJECT_DB.MY_SCHEMA.dim_genre dg on b.genre = dg.genre
)

select * from joined