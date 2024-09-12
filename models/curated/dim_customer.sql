{{ config(tags=["dimension"]) }}

WITH
customers AS ( SELECT * FROM {{ ref("stg_wwi_sales__Customers") }}),

customerCategories AS ( SELECT * FROM {{ ref("stg_wwi_sales__CustomerCategories") }}),

buyingGroups AS ( SELECT * FROM {{ ref("stg_wwi_sales__BuyingGroups") }}),

final AS (
SELECT 
    ROW_NUMBER() OVER (ORDER BY c.CustomerID) AS CustomerKey,
    c.CustomerID,
    c.CustomerName,
    c.WebsiteURL,
    cc.CustomerCategoryName,
    bg.BuyingGroupName
FROM
    customers c
    LEFT OUTER JOIN customerCategories cc
        ON c.CustomerCategoryID = cc.CustomerCategoryID
    LEFT OUTER JOIN buyingGroups bg
        ON c.BuyingGroupID = bg.BuyingGroupID
)

SELECT * FROM final