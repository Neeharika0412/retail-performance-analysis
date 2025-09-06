-- retail_analysis.sql
-- SQL Queries for Retail Performance Analysis Project

---------------------------------------------------------
-- 1. Create table
---------------------------------------------------------
CREATE TABLE RetailSales (
    OrderDate DATE,
    Region VARCHAR(50),
    Category VARCHAR(50),
    Sales INT,
    Profit INT
);

---------------------------------------------------------
-- 2. Insert sample data (if needed for testing)
---------------------------------------------------------
INSERT INTO RetailSales (OrderDate, Region, Category, Sales, Profit)
VALUES
('2020-01-01', 'East', 'Furniture', 200, 20),
('2020-01-16', 'West', 'Technology', 450, 80),
('2020-01-31', 'Central', 'Office Supplies', 120, 10),
('2020-02-15', 'South', 'Technology', 300, 50),
('2020-03-01', 'East', 'Furniture', 500, 90);

---------------------------------------------------------
-- 3. Profit Margin Calculation
---------------------------------------------------------
SELECT 
    Category,
    SUM(Profit) AS TotalProfit,
    SUM(Sales) AS TotalSales,
    ROUND(SUM(Profit) * 100.0 / NULLIF(SUM(Sales), 0), 2) AS ProfitMarginPercent
FROM RetailSales
GROUP BY Category;

---------------------------------------------------------
-- 4. Regional Sales & Profit
---------------------------------------------------------
SELECT 
    Region,
    SUM(Sales) AS TotalSales,
    SUM(Profit) AS TotalProfit
FROM RetailSales
GROUP BY Region
ORDER BY TotalSales DESC;

---------------------------------------------------------
-- 5. Quarterly Sales Trend
---------------------------------------------------------
SELECT 
    DATEPART(QUARTER, OrderDate) AS Quarter,
    SUM(Sales) AS TotalSales,
    SUM(Profit) AS TotalProfit
FROM RetailSales
GROUP BY DATEPART(QUARTER, OrderDate)
ORDER BY Quarter;

---------------------------------------------------------
-- 6. Detect Low-Margin Categories (less than 15%)
---------------------------------------------------------
SELECT 
    Category,
    ROUND(SUM(Profit) * 100.0 / NULLIF(SUM(Sales), 0), 2) AS ProfitMarginPercent
FROM RetailSales
GROUP BY Category
HAVING ROUND(SUM(Profit) * 100.0 / NULLIF(SUM(Sales), 0), 2) < 15;

---------------------------------------------------------
-- END OF FILE
---------------------------------------------------------
