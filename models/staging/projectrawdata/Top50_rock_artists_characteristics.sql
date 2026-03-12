WITH sub_1 AS (
  SELECT 
    a.artist_name, 
    b.Total_Tickets, 
    a.danceability, 
    a.energy, 
    a.loudness, 
    a.speechiness, 
    a.acousticness, 
    a.instrumentalness, 
    a.liveness, 
    a.valence, 
    a.tempo
  FROM `rockproject-489813.projectrawdata.top_artist_rock_caracteristics` AS a 
  LEFT JOIN `rockproject-489813.projectrawdata.box_scores_all` AS b 
    ON a.artist_name = b.Artist
)

SELECT 
  artist_name,
  SUM(Total_Tickets) AS total_tickets,
  
  ROUND(SUM(danceability * Total_Tickets) / NULLIF(SUM(Total_Tickets), 0), 3) AS weighted_danceability,
  ROUND(SUM(energy * Total_Tickets) / NULLIF(SUM(Total_Tickets), 0), 3) AS weighted_energy,
  ROUND(SUM(speechiness * Total_Tickets) / NULLIF(SUM(Total_Tickets), 0), 3) AS weighted_speechiness,
  ROUND(SUM(acousticness * Total_Tickets) / NULLIF(SUM(Total_Tickets), 0), 3) AS weighted_acousticness,
  ROUND(SUM(instrumentalness * Total_Tickets) / NULLIF(SUM(Total_Tickets), 0), 3) AS weighted_instrumentalness,
  ROUND(SUM(liveness * Total_Tickets) / NULLIF(SUM(Total_Tickets), 0), 3) AS weighted_liveness,
  ROUND(SUM(valence * Total_Tickets) / NULLIF(SUM(Total_Tickets), 0), 3) AS weighted_valence,
  ROUND(SUM(loudness * Total_Tickets) / NULLIF(SUM(Total_Tickets), 0), 1) AS weighted_loudness,
  ROUND(SUM(tempo * Total_Tickets) / NULLIF(SUM(Total_Tickets), 0), 1) AS weighted_tempo

FROM sub_1
GROUP BY artist_name
ORDER BY total_tickets DESC 