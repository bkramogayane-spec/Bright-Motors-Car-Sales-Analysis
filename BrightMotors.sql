
----------------Key Objectives from Case Study--------------
------------------------------------------------------------
---Top revenue-generating car makes and models
---Relationship between price, mileage, and year
---Regional performance (state or city)
---Trends in selling price over time
---Profit margin calculations and performance tiers

---Check all column names and data types
SELECT*
FROM BRIGHTCAR.SALES.DATA;

---How many cars recorded----550297 on record
SELECT COUNT(DISTINCT VIN)
FROM BRIGHTCAR.SALES.DATA;

-- ============================================
---Top 10 Revenue-Generating Car Makes and Models
-- ============================================
SELECT make, 
       model, 
SUM(sellingprice) AS total_revenue
FROM BRIGHTCAR.SALES.DATA
GROUP BY make, model
ORDER BY total_revenue DESC
LIMIT 10;

-- ============================================
---Average Selling Price by Year
-- ============================================
SELECT year, 
ROUND(AVG(sellingprice), 2) AS avg_price
FROM BRIGHTCAR.SALES.DATA
GROUP BY year
ORDER BY year;

-- ============================================
---Relationship Between Price and Mileage -- The higher the mileage, the lower the selling price
-- ============================================
SELECT odometer, 
       sellingprice
FROM BRIGHTCAR.SALES.DATA
WHERE odometer IS NOT NULL AND sellingprice IS NOT NULL;

SELECT 
    CORR(odometer, sellingprice) AS Mileage_Price_Correlation
FROM BRIGHTCAR.SALES.DATA
WHERE odometer IS NOT NULL AND sellingprice IS NOT NULL;

SELECT
    ROUND(odometer, 0) AS Mileage_Band,
    ROUND(AVG(sellingprice), 2) AS Avg_Selling_Price,
    COUNT(*) AS Num_Cars
FROM BRIGHTCAR.SALES.DATA
WHERE odometer IS NOT NULL AND sellingprice IS NOT NULL
GROUP BY ROUND(odometer, 0)
ORDER BY Mileage_Band;

-- ============================================
-- Sales Volume and Revenue by State, Make,Transmission
-- ============================================
SELECT state, make,transmission,
       COUNT(*) AS total_sales, 
       SUM(sellingprice) AS revenue
FROM BRIGHTCAR.SALES.DATA
GROUP BY state,make,transmission
ORDER BY total_sales DESC;
------Revenue by state
SELECT 
    state,
    SUM(sellingprice) AS Total_Revenue,
    COUNT(*) AS Total_Sales
FROM BRIGHTCAR.SALES.DATA
GROUP BY state;

-- ============================================
--Monthly Price Trend
-- ============================================
SELECT 
    year,
    ROUND(AVG(sellingprice), 2) AS Avg_Price,
    ROUND(AVG(odometer), 2) AS Avg_Mileage
FROM BRIGHTCAR.SALES.DATA
GROUP BY year
ORDER BY year;

---Selling Price Trends Over Time
SELECT 
    EXTRACT(YEAR FROM TRY_TO_TIMESTAMP(saledate, 'DY MON DD YYYY HH24:MI:SS'))AS Sale_Year,
    TO_CHAR(TRY_TO_TIMESTAMP(saledate, 'DY MON DD YYYY HH24:MI:SS'), 'Mon') AS Sale_Month,
    ROUND(AVG(sellingprice), 2) AS Avg_Selling_Price
FROM BRIGHTCAR.SALES.DATA
GROUP BY Sale_Year, Sale_Month
ORDER BY Sale_Year, Sale_Month;

-- Average, minimum, and maximum selling price by make & model
SELECT 
    make,
    model,
    ROUND(AVG(sellingprice), 0) AS AvgPrice,
    MIN(sellingprice) AS MinPrice,
    MAX(sellingprice) AS MaxPrice
FROM BRIGHTCAR.SALES.DATA
GROUP BY make, model;

SELECT
    YEAR(saledate) AS Sale_Year,
    transmission,
    COUNT(*) AS Total_Sales,
    SUM(sellingprice) AS Total_Revenue,
    ROUND(AVG(sellingprice), 2) AS Avg_Selling_Price,
    ROUND(AVG((((sellingprice - mmr) / sellingprice) * 100)), 2) AS Avg_Profit_Margin
FROM BRIGHTCAR.SALES.DATA
WHERE saledate IS NOT NULL
GROUP BY Sale_Year, transmission
ORDER BY Sale_Year, Total_Revenue DESC;

-- ============================================
-- Profit Margin Calculation
-- ============================================
SELECT *,
    ((sellingprice - mmr) / sellingprice) * 100 AS Profit_Margin,
    CASE 
        WHEN ((sellingprice - mmr) / sellingprice) * 100 >= 20 THEN 'High Margin'
        WHEN ((sellingprice - mmr) / sellingprice) * 100 BETWEEN 10 AND 19.99 THEN 'Medium Margin'
        ELSE 'Low Margin'
    END AS Margin_Category
FROM BRIGHTCAR.SALES.DATA;


SELECT 
    make, 
    model,
    MAX(((sellingprice - mmr) / sellingprice) * 100) AS profit_margin,
    CASE
        WHEN MAX(((sellingprice - mmr) / sellingprice) * 100) >= 20 THEN 'High Margin'
        WHEN MAX(((sellingprice - mmr) / sellingprice) * 100) BETWEEN 10 AND 19 THEN 'Medium Margin'
        ELSE 'Low Margin'
    END AS margin_category,
    COUNT(*) AS total_sales
FROM BRIGHTCAR.SALES.DATA
GROUP BY make, model
ORDER BY total_sales DESC;

-- ============================================
-- Separate the month and year on the DateTime column
-- ============================================
SELECT 
    TO_CHAR(TRY_TO_TIMESTAMP(saledate, 'DY MON DD YYYY HH24:MI:SS'), 'DY') AS DayOfWeek,
    TO_CHAR(TRY_TO_TIMESTAMP(saledate, 'DY MON DD YYYY HH24:MI:SS'), 'Mon') AS MonthName,
    TO_CHAR(TRY_TO_TIMESTAMP(saledate, 'DY MON DD YYYY HH24:MI:SS'), 'HH24:MI:SS') AS TimePart
FROM BRIGHTCAR.SALES.DATA
WHERE TRY_TO_TIMESTAMP(saledate, 'DY MON DD YYYY HH24:MI:SS') IS NOT NULL;

-- ============================================
-- Final Code
-- ============================================
SELECT 
    year,
    make, 
    model,
    trim,
    body,
    transmission,
    state,
    color,
    ODOMETER,
    SELLINGPRICE,

((sellingprice - mmr) / sellingprice) * 100 AS Profit_Margin,
    CASE 
        WHEN ((sellingprice - mmr) / sellingprice) * 100 >= 20 THEN 'High Margin'
        WHEN ((sellingprice - mmr) / sellingprice) * 100 BETWEEN 10 AND 19.99 THEN 'Medium Margin'
        ELSE 'Low Margin'
    END AS Margin_Category,

    COUNT(*) AS total_sales,
    ----Comparison of the selling price to the market price
    CASE 
        WHEN sellingprice > mmr THEN 'High Priced'
        WHEN sellingprice < mmr THEN 'Low Priced'
        ELSE 'Fair Priced'
    END AS Price_Range,
    
TO_CHAR(TRY_TO_TIMESTAMP(saledate, 'DY MON DD YYYY HH24:MI:SS'), 'DY') AS SaleDayOfWeek,
TO_CHAR(TRY_TO_TIMESTAMP(saledate, 'DY MON DD YYYY HH24:MI:SS'), 'Mon') AS SaleMonth,
EXTRACT(YEAR FROM TRY_TO_TIMESTAMP(saledate, 'DY MON DD YYYY HH24:MI:SS')) AS SaleYear,
TO_CHAR(TRY_TO_TIMESTAMP(saledate, 'DY MON DD YYYY HH24:MI:SS'), 'HH24:MI:SS') AS TimePart

FROM BRIGHTCAR.SALES.DATA
WHERE TRY_TO_TIMESTAMP(saledate, 'DY MON DD YYYY HH24:MI:SS') IS NOT NULL
GROUP BY ALL;
