with 

source as (

    select * from {{ source('wwi_sales', 'Orders') }}

),

renamed as (

    select
        orderid,
        orderdate,
        customerid

    from source

)

select * from renamed
