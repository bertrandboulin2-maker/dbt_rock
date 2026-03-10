with 

source as (

    select * from {{ source('rockproject-489813', 'artists_51to00') }}

),

renamed as (

    select
        id,
        real_name,
        art_name,
        role,
        year_of_birth,
        country,
        city,
        email,
        zip_code

    from source

)

select * from renamed