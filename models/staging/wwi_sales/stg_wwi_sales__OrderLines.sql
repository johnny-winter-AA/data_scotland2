with 

source as (

    select * from {{ source('wwi_sales', 'OrderLines') }}

),

renamed as (

    select
        orderlineid,
        stockitemid,
        quantity,
        orderid,
        unitprice,
        unitPrice * quantity AS SalesAmount

    from source

)

select * from renamed
