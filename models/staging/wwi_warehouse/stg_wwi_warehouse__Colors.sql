with 

source as (

    select * from {{ source('wwi_warehouse', 'Colors') }}

),

renamed as (

    select
        colorid,
        colorname AS ProductColour

    from source

)

select * from renamed
