

with base as (
    select * 
    from MY_PROJECT_DB.MY_SCHEMA.stg_games_data
    
    

),

unpivoted as (
    select game_id, platform, genre, 'NA' as region_code, na_sales as sales, 
           critic_score, user_score, review_count, loaded_at
    from base
    union all
    select game_id, platform, genre, 'EU', eu_sales, 
           critic_score, user_score, review_count, loaded_at
    from base
    union all
    select game_id, platform, genre, 'JP', jp_sales, 
           critic_score, user_score, review_count, loaded_at
    from base
    union all
    select game_id, platform, genre, 'Other', other_sales, 
           critic_score, user_score, review_count, loaded_at
    from base
),

joined as (
    select
        u.game_id,
        dp.platform_id,
        dg.genre_id,
        dr.region_id,
        u.sales,
        u.critic_score,
        u.user_score,
        u.review_count,
        u.loaded_at
    from unpivoted u
    left join MY_PROJECT_DB.MY_SCHEMA.dim_platform dp on u.platform = dp.platform
    left join MY_PROJECT_DB.MY_SCHEMA.dim_genre dg on u.genre = dg.genre
    left join MY_PROJECT_DB.MY_SCHEMA.dim_region dr on u.region_code = dr.region_code
)

select * from joined