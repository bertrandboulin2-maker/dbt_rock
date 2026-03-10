with 

source as (

    select * from {{ source('rockproject-489813', 'artists_51to00') }}

),

renamed as (

    select
        id
     
        
    from source

)

select * from renamed