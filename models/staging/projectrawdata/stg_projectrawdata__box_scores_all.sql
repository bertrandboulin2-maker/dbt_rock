with 

source as (

    select * from {{ source('projectrawdata', 'box_scores_all') }}

),

renamed as (

    select
        rank,
        gross_millions,
        artist,
        average_ticket_price,
        average_tickets,
        total_tickets,
        average_gross,
        cities_shows,
        agency,
        `year` AS date_year

    from source

)

select * from renamed