with 

source as (

    select * from {{ source('wwi_sales', 'CustomerCategories') }}

),

renamed as (

    select
        customercategoryid,
        customercategoryname

    from source

)

select * from renamed
