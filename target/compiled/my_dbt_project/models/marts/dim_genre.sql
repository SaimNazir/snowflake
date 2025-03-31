



with base as (
    select distinct
        genre as genre_id,
        genre,
        loaded_at
    from MY_PROJECT_DB.MY_SCHEMA.stg_games_data
    
    
        where loaded_at > (select max(loaded_at) from MY_PROJECT_DB.MY_SCHEMA.dim_genre)
    

    )

select
    genre_id,
    genre,
    loaded_at
from base