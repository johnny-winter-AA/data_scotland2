{{ config(tags=["dimension"]) }}

/* generates a list with 10 values */
WITH 
orders AS (SELECT * FROM {{ ref("stg_wwi_sales__Orders") }}),

List AS (
    SELECT  
        n
    FROM
        (VALUES (0),(1),(2),(3),(4),(5),(6),(7),(8),(9)) v(n)
),

/* generates 10k rows by cross joining List with itself */
Range AS (
    SELECT 
        ROW_NUMBER() OVER (ORDER BY (SELECT NULL))-1 AS RowNumber
    FROM
        List a
        CROSS JOIN List b
        CROSS JOIN List c
        CROSS JOIN List d
),

/* query to specify date range based on Orders table */
DateRange AS (
    SELECT
        CAST(CONCAT(YEAR(MIN(o.OrderDate)),'-01-01') AS DATE) AS StartDate /* should always start on 1st January */,
        CAST(CONCAT(YEAR(MAX(o.OrderDate)), '-12-31') AS DATE) AS EndDate /* should always end on 31st December*/
    FROM
        orders o 
),

/* query to generate dates between given start date and end date */
Calendar AS (
SELECT
    DATEADD(DAY, r.RowNumber, dr.StartDate ) AS Date
FROM
    Range r
    CROSS JOIN DateRange dr
WHERE
    DATEADD(DAY, r.RowNumber, dr.StartDate ) <= dr.EndDate
),

final AS (
/* date table query */
SELECT
    {{ smart_date_key('c.Date') }} AS DateKey,
    c.Date,
    YEAR(c.Date) AS Year,
    CONCAT('Qtr ',DATE_PART('QUARTER', c.Date)) AS Quarter,
    DATE_FORMAT(c.Date, 'MMMM') AS Month,
    DATE_PART('DAY', c.Date) AS Day,
    DATE_PART('MONTH', c.Date) AS MonthNumber,
    DATE_PART('DAYOFWEEK', c.Date) AS DayOfWeekNumber,
    DATE_FORMAT(c.Date, 'EEEE') AS DayOfWeekName,
    DATE_PART('DOY', c.Date) AS DayOfYear,
    DATE_PART('WEEK', c.Date) AS ISOWeek
FROM
    Calendar c
)

SELECT * FROM final