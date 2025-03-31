

with base as (
    select * from MY_PROJECT_DB.MY_SCHEMA.stg_games_data
    
        where loaded_at > (select max(loaded_at) from MY_PROJECT_DB.MY_SCHEMA.int_high_performance_games)
    
),

filtered as (
    select *
    from base
    where global_sales > 5
)

select * from filtered