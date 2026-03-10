with 

source as (

    select * from {{ source('rockproject-489813', 'albums_51to00') }}

),

renamed as (

    select
        id,
        artist_id,
        album_title,
        genre,
        year_of_pub,
        num_of_tracks,
        num_of_sales,
        rolling_stone_critic,
        mtv_critic,
        music_maniac_critic

    from source

)

select * from renamed