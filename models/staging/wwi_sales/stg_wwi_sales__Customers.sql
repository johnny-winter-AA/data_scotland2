with 

source as (

    select * from {{ source('wwi_sales', 'Customers') }}

),

renamed as (

    select
        customername,
        customercategoryid,
        buyinggroupid,
        customerid,
        websiteurl

    from source

)

select * from renamed
