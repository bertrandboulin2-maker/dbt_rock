SELECT *
from {{ ref('Boxscore_Spotify_Genre_Followers') }} as t
inner join {{ ref('Top50_rock_artists_characteristics') }} as q
on q.artist_name = t.Nom 

Where Genre = "Rock"