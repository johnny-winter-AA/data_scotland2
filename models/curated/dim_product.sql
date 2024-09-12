{{ config(tags=["dimension"]) }}

WITH 
stockItems AS (SELECT * FROM {{ ref("stg_wwi_warehouse__StockItems") }}),

colors AS (SELECT * FROM {{ ref("stg_wwi_warehouse__Colors") }}),

suppliers AS (SELECT * FROM {{ ref("stg_wwi_purchasing__Suppliers") }}),

supplierCategories AS (SELECT * FROM {{ ref("stg_wwi_purchasing__SupplierCategories") }}),

final AS (
SELECT 
    ROW_NUMBER() OVER (ORDER BY si.StockItemID) AS ProductKey,
    si.StockItemID,
    si.ProductName,
    si.ProductBrand,
    c.ProductColour,
    s.SupplierName,
    s.SupplierReference,
    sc.SupplierCategoryName
FROM 
    stockItems si
    LEFT OUTER JOIN colors c
        ON si.ColorID = c.ColorID
    LEFT OUTER JOIN suppliers s
        ON si.SupplierID = s.SupplierID 
    LEFT OUTER JOIN supplierCategories sc
        ON s.SupplierCategoryID = sc.SupplierCategoryID
)

SELECT * FROM final