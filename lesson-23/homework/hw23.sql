1. Puzzle 1: In this puzzle you have to extract the month from the dt column and then append zero single digit month if any. Please check out sample input and expected output. 
SELECT 
    Id,
    Dt,
    RIGHT('0' + CAST(MONTH(Dt) AS VARCHAR(2)), 2) as MonthPrefixedWithZero
FROM Dates
ORDER BY Id;
2. Sum of Max Values for Each ID and rID 
WITH MaxVals AS (
    SELECT 
        Id,
        rID,
        MAX(Vals) as MaxVal
    FROM MyTabel
    GROUP BY Id, rID
)
SELECT 
    COUNT(DISTINCT Id) as Distinct_Ids,
    rID,
    SUM(MaxVal) as TotalOfMaxVals
FROM MaxVals
GROUP BY rID;
3. 3: Filter Records by String Length 
SELECT 
    Id,
    Vals
FROM TestFixLengths
WHERE LEN(COALESCE(Vals, '')) BETWEEN 6 AND 10
ORDER BY Id, Vals;
4.Find Maximum Value and Corresponding Item for Each ID 
WITH RankedItems AS (
    SELECT 
        ID,
        Item,
        Vals,
        ROW_NUMBER() OVER (PARTITION BY ID ORDER BY Vals DESC) as rn
    FROM TestMaximum
)
SELECT 
    ID,
    Item,
    Vals
FROM RankedItems
WHERE rn = 1
ORDER BY Vals DESC;
5. 5: Sum of Maximum Values for Each DetailedNumber and ID 
WITH MaxVals AS (
    SELECT 
        DetailedNumber,
        Id,
        MAX(Vals) as MaxVal
    FROM SumOfMax
    GROUP BY DetailedNumber, Id
)
SELECT 
    Id,
    SUM(MaxVal) as SumofMax
FROM MaxVals
GROUP BY Id
ORDER BY Id;
6. Difference with Zero Replacement 
SELECT 
    Id,
    a,
    b,
    CASE 
        WHEN a - b = 0 THEN ''
        ELSE CAST(a - b AS VARCHAR(20))
    END as OUTPUT
FROM TheZeroPuzzle
ORDER BY Id;
-- 7. Total revenue
SELECT SUM(QuantitySold * UnitPrice) as TotalRevenue FROM Sales;

-- 8. Average unit price
SELECT AVG(UnitPrice) as AvgUnitPrice FROM Sales;

-- 9. Total transactions
SELECT COUNT(*) as TotalTransactions FROM Sales;

-- 10. Highest units sold
SELECT MAX(QuantitySold) as MaxUnitsSold FROM Sales;

-- 11. Products sold by category
SELECT Category, SUM(QuantitySold) as TotalSold 
FROM Sales GROUP BY Category;

-- 12. Revenue by region
SELECT Region, SUM(QuantitySold * UnitPrice) as TotalRevenue 
FROM Sales GROUP BY Region;

-- 13. Product with highest revenue
SELECT TOP 1 Product, SUM(QuantitySold * UnitPrice) as TotalRevenue 
FROM Sales GROUP BY Product ORDER BY TotalRevenue DESC;

-- 14. Running total of revenue
SELECT SaleDate, SUM(QuantitySold * UnitPrice) OVER (ORDER BY SaleDate) as RunningTotal 
FROM Sales GROUP BY SaleDate;

-- 15. Category contribution to revenue
SELECT Category, 
       SUM(QuantitySold * UnitPrice) as CategoryRevenue,
       ROUND(SUM(QuantitySold * UnitPrice) * 100.0 / SUM(SUM(QuantitySold * UnitPrice)) OVER (), 2) as Percentage
FROM Sales GROUP BY Category;
-- 17. Sales with customer names
SELECT s.*, c.CustomerName 
FROM Sales s JOIN Customers c ON s.CustomerID = c.CustomerID;

-- 18. Customers without purchases
SELECT c.* FROM Customers c 
LEFT JOIN Sales s ON c.CustomerID = s.CustomerID 
WHERE s.SaleID IS NULL;

-- 19. Revenue per customer
SELECT c.CustomerID, c.CustomerName, SUM(s.QuantitySold * s.UnitPrice) as TotalRevenue 
FROM Customers c LEFT JOIN Sales s ON c.CustomerID = s.CustomerID 
GROUP BY c.CustomerID, c.CustomerName;

-- 20. Top revenue customer
SELECT TOP 1 c.CustomerName, SUM(s.QuantitySold * s.UnitPrice) as TotalRevenue 
FROM Customers c JOIN Sales s ON c.CustomerID = s.CustomerID 
GROUP BY c.CustomerName ORDER BY TotalRevenue DESC;

-- 21. Total sales per customer
SELECT c.CustomerID, c.CustomerName, COUNT(s.SaleID) as TotalPurchases 
FROM Customers c LEFT JOIN Sales s ON c.CustomerID = s.CustomerID 
GROUP BY c.CustomerID, c.CustomerName;
-- 22. Products sold at least once
SELECT DISTINCT p.* FROM Products p 
JOIN Sales s ON p.ProductName = s.Product;

-- 23. Most expensive product
SELECT TOP 1 * FROM Products ORDER BY SellingPrice DESC;

-- 24. Products above category average price
WITH CategoryAverages AS (
    SELECT Category, AVG(SellingPrice) as AvgPrice 
    FROM Products GROUP BY Category
)
SELECT p.*, ca.AvgPrice
FROM Products p JOIN CategoryAverages ca ON p.Category = ca.Category
WHERE p.SellingPrice > ca.AvgPrice;

