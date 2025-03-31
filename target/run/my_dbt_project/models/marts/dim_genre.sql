
  
    

        create or replace transient table MY_PROJECT_DB.MY_SCHEMA.dim_genre
         as
        (

with base as (
    select
        
    md5(lower(trim(genre)))
 as genre_id,
        genre
    from MY_PROJECT_DB.MY_SCHEMA.stg_games_data
    group by genre
)

select
    genre_id,
    genre
from base
        );
      
  