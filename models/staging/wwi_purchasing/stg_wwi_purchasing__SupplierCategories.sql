with 

source as (

    select * from {{ source('wwi_purchasing', 'SupplierCategories') }}

),

renamed as (

    select
        suppliercategoryid,
        suppliercategoryname


    from source

)

select * from renamed
