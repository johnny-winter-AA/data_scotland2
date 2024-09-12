with 

source as (

    select * from {{ source('wwi_warehouse', 'StockItems') }}

),

renamed as (

    select
        stockitemid,
        brand AS ProductBrand,
        stockitemname AS ProductName,
        supplierid,
        colorid

    from source

)

select * from renamed
