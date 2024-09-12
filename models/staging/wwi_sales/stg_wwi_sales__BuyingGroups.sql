with 

source as (

    select * from {{ source('wwi_sales', 'BuyingGroups') }}

),

renamed as (

    select
        buyinggroupid,
        buyinggroupname

    from source

)

select * from renamed
