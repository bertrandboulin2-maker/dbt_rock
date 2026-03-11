WITH renamed AS (
    SELECT
        track_name,
        artist_s__name,

        SPLIT(artist_s__name, ',')[SAFE_OFFSET(0)] AS main_artist,

        ARRAY_TO_STRING(
            ARRAY_SLICE(
                SPLIT(artist_s__name, ','),
                1,
                ARRAY_LENGTH(SPLIT(artist_s__name, ','))
            ),
            ', '
        ) AS featured_artists,

        REGEXP_REPLACE(
            LOWER(TRIM(SPLIT(artist_s__name, ',')[SAFE_OFFSET(0)])),
            r'[^a-z0-9\s]',
            ''
        ) AS main_artist_clean,

        artist_count,
        released_year,
        released_month,
        released_day,
        in_spotify_playlists,
        in_spotify_charts,
        streams,
        in_apple_playlists,
        in_apple_charts,
        in_deezer_playlists,
        in_deezer_charts,
        in_shazam_charts,
        bpm,
        key,
        mode,
        `danceability_%`,
        `valence_%`,
        `energy_%`,
        `acousticness_%`,
        `instrumentalness_%`,
        `liveness_%`,
        `speechiness_%`

    FROM {{ source('projectrawdata', 'spotify_2010_2019') }}
),

artist_followers AS (
    SELECT
        REGEXP_REPLACE(
            LOWER(TRIM(artist_name)),
            r'[^a-z0-9\s]',
            ''
        ) AS artist_name_clean,
        MAX(artist_followers) AS artist_followers
    FROM {{ source('projectrawdata', 'top_artist_2009_2023_spotify') }}
    GROUP BY artist_name_clean
),

joined AS (

SELECT
    a.*,
    b.artist_followers

FROM renamed a

LEFT JOIN artist_followers b
ON a.main_artist_clean = b.artist_name_clean

)

SELECT *
FROM joined