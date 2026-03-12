with table1 as (SELECT 
artist_name, Nom,  Genre,

sum(artist_followers) as followers,
sum(total_tickets) as total_tickets,

FROM {{ ref('Boxscore_genre') }}
inner join {{ source('projectrawdata', 'top_artist_2009_2023_spotify') }}
on Nom = artist_name

group by Nom, artist_name, Genre)
,
table2 as (
SELECT 
artist_name, Nom,  Genre,followers, total_tickets,
round(safe_divide( total_tickets, followers),2) as ratio
from table1
)
select count(*) as nbre, Genre, round(avg(ratio),2) as ratio
from table2
group by Genre
order by ratio desc
