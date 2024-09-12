{{ config(tags=["fact"]) }}

WITH
orderLines AS (SELECT * FROM {{ ref("stg_wwi_sales__OrderLines") }}),

orders AS (SELECT * FROM {{ ref("stg_wwi_sales__Orders") }}),

dim_customer AS (SELECT * FROM {{ ref("dim_customer") }}),

dim_product AS (SELECT * FROM {{ ref("dim_product") }}),

final AS (
SELECT
    dc.CustomerKey,
    dp.ProductKey,
    {{ smart_date_key('o.OrderDate') }} AS DateKey,
    ol.Quantity,
    ol.SalesAmount
FROM
    orderLines ol
    LEFT OUTER JOIN orders o
        ON ol.OrderID = o.OrderID
    LEFT OUTER JOIN dim_customer dc
        ON o.CustomerID = dc.CustomerID
    LEFT OUTER JOIN dim_product dp
        ON ol.StockItemID = ol.StockItemID
)

SELECT * FROM final