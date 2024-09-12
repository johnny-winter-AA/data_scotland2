WITH 
stockItems AS (SELECT * FROM {{ source("wwi_warehouse", "StockItems") }}),

colors AS (SELECT * FROM {{ source("wwi_warehouse", "Colors") }}),

suppliers AS (SELECT * FROM {{ source("wwi_purchasing", "Suppliers") }}),

supplierCategories AS (SELECT * FROM {{ source("wwi_purchasing", "SupplierCategories") }}),

final AS (
SELECT 
    ROW_NUMBER() OVER (ORDER BY si.StockItemID) AS ProductKey,
    si.StockItemID,
    si.StockItemName AS ProductName,
    si.Brand AS ProductBrand,
    c.ColorName AS ProductColour,
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

