
with table1 as (SELECT 
  Nom,
  COUNT(*) AS nbre_concert,
  Genre
FROM {{ source('projectrawdata', 'genre_artist_boxscore') }}
GROUP BY Nom, Genre
ORDER BY nbre_concert DESC)

SELECT Nom , REGEXP_REPLACE(
            LOWER(TRIM(Nom)),
            r'[^a-z0-9\s]',
            ''
        ) AS artist_name_clean, 
        COUNT(*) AS nbre_concert, 
        Genre, 
        sum(Total_Tickets) as total_tickets, 
from table1
join {{ source('projectrawdata', 'box_scores_all') }}
on Artist = Nom
group by Nom, Genre
order by nbre_concert desc

