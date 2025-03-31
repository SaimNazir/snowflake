
    
    

select
    game_id as unique_field,
    count(*) as n_records

from MY_PROJECT_DB.MY_SCHEMA.stg_games_data
where game_id is not null
group by game_id
having count(*) > 1


