with 

source as (

    select * from {{ source('wwi_purchasing', 'Suppliers') }}

),

renamed as (

    select
        supplierid,
        suppliername,
        suppliercategoryid,
        supplierreference

    from source

)

select * from renamed
