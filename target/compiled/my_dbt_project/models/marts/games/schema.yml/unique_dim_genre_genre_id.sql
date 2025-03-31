
    
    

select
    genre_id as unique_field,
    count(*) as n_records

from MY_PROJECT_DB.MY_SCHEMA.dim_genre
where genre_id is not null
group by genre_id
having count(*) > 1


