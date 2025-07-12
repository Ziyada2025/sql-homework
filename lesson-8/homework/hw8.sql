Q1: Using Products table, find the total number of products available in each category 
SELECT CATEGORY, 
COUNT(PRODUCTNAME) AS TOTAL_NUMBER_OF_PRODUCTS 
FROM Products 
GROUP BY CATEGORY; 
Q2:Using Products table, get the average price of products in the 'Electronics' category.
  2.1 IF I need to find AVG price per product in Electronics category:
SELECT CATEGORY, PRODUCTNAME,
AVG(PRICE) AS AVG_PRICE_PRODUCT 
FROM Products 
GROUP BY CATEGORY, PRODUCTNAME 
HAVING Category='ELECTRONICS'; 
2.2 IF i have to find avg price in electronics categroy: 
  SELECT AVG(Price) AS AvgPrice
FROM Products
WHERE Category = 'Electronics';
Q3:Using Customers table, list all customers from cities that start with 'L'. 
SELECT * FROM Customers 
WHERE CITY LIKE 'L%';  
Q4:Using Products table, get all product names that end with 'er'. 
SELECT * FROM PRODUCTS 
WHERE PRODUCTNAME LIKE '%er';
Q5:SELECT * FROM Customers 
WHERE Country LIKE '%a'; 
Q6:Using Products table, show the highest price among all products. 
SELECT * FROM Products 
WHERE PRICE=( SELECT MAX(PRICE) FROM Products);
Q7:Using Products table, label stock as 'Low Stock' if quantity < 30, else 'Sufficient'. 
SELECT *, 
CASE 
WHEN StockQuantity<30 THEN 'LOW STOCK' 
ELSE 'SUFFICIENT' END AS QUANTITY_STATUS 
FROM Products; 
Q8: Using Customers table, find the total number of customers in each country. 
SELECT COUNTRY, 
COUNT (CustomerID) AS NUMBER_OF_VISITED_CUSTOMERS 
FROM CUSTOMERS 
GROUP BY COUNTRY; 
Q9:Using Orders table, find the minimum and maximum quantity ordered. 
SELECT 
MAX(QUANTITY) AS [MAX_QUANTITY],
MIN(QUANTITY) AS [MIN_QUANTITY] 
FROM Orders; 
Q10:Using Orders and Invoices tables, list customer IDs who placed orders in 2023 January to find those who did not have invoices. 
SELECT *
FROM Orders o 
LEFT JOIN Invoices i 
ON o.customerID=i.customerID 
WHERE YEAR(OrderDate)=2023 
AND MONTH(OrderDate)=1 
AND i.customerID is null; 
Q11: Using Products and Products_Discounted table, Combine all product names from Products and Products_Discounted including duplicates. 
SELECT ProductName FROM Products 
UNION all
SELECT ProductName FROM Products_Discounted; 
Q12: Using Products and Products_Discounted table, Combine all product names from Products and Products_Discounted without duplicates. 
SELECT ProductName FROM Products 
UNION 
SELECT ProductName FROM Products_Discounted; 
Q13: Using Orders table, find the average order amount by year. 
13.1 (IF order amount means monetary value) 
SELECT 
 YEAR (OrderDate) as Year_of_order, 
 AVG(TotalAmount) as Order_amount_ 
 FROM Orders 
 GROUP BY YEAR (OrderDate); 
13.2 (IF order amount means quantity value) 
SELECT 
  YEAR (OrderDate) as Year_of_order, 
 AVG(Quantity) as Order_amount_ 
 FROM Orders 
 GROUP BY YEAR (OrderDate); 
Q 14:Using Products table, group products based on price: 'Low' (<100), 'Mid' (100-500), 'High' (>500). Return productname and pricegroup. 
 SELECT  ProductName, 
CASE 
WHEN Price>500 THEN 'HIGH'
WHEN Price between 100 and 500 THEN 'MID'
ELSE 'LOW' END as Pricegroup 
FROM Products; 
Q15: Using City_Population table, use Pivot to show values of Year column in seperate columns ([2012], [2013]) and copy results to a new Population_Each_Year table.
  SELECT district_name, [2012], [2013] 
INTO Population_Each_Year
FROM City_Population 
PIVOT (SUM(Population) FOR Year IN ([2012], [2013])) AS PivotTable; 
Q16: Using Sales table, find total sales per product Id. 
  SELECT ProductID, 
SUM (SaleAmount) as TotalSale_per_product 
FROM Sales 
GROUP BY ProductID; 
Q17:Using Products table, use wildcard to find products that contain 'oo' in the name. Return productname. 
  SELECT ProductName 
FROM Products 
WHERE ProductName LIKE '%oo%'; 
Q18:SELECT year, [Bektemir], [Chilonzor], [Yakkasaroy] 
INTO Population_Each_City
FROM (
    SELECT year, district_name, population
    FROM city_population
    WHERE district_name IN ('Bektemir', 'Chilonzor', 'Yakkasaroy')
) AS SourceTable
PIVOT (SUM(population) FOR district_name IN ([Bektemir], [Chilonzor], [Yakkasaroy])) AS PivotTable;
Q19:Using Invoices table, show top 3 customers with the highest total invoice amount. Return CustomerID and Totalspent. 
  SELECT TOP 3 
CustomerID, 
SUM (TotalAmount) as TotalSpent 
FROM Invoices 
GROUP BY CustomerID 
ORDER BY TotalSpent DESC; 
Q20:Transform Population_Each_Year table to its original format (City_Population). 
  SELECT p.district_name, u.Population, u.Year
FROM (
    SELECT district_name, [2012], [2013] 
    FROM City_Population 
    PIVOT (SUM(Population) FOR Year IN ([2012], [2013])) AS p
) p
UNPIVOT (
    Population FOR Year IN ([2012], [2013])
) AS u;
Q21: Using Products and Sales tables, list product names and the number of times each has been sold. (Research for Joins)
  SELECT p.ProductName, 
COUNT (s.ProductID) as TImes_sold 
FROM Products p
JOIN Sales s 
ON p.ProductID=s.ProductID 
GROUP BY p.ProductName; 
Q22:Transform Population_Each_City table to its original format (City_Population). 
SELECT p.year, u.district_name, u.Population
FROM (
    SELECT year, [Bektemir], [Chilonzor], [Yakkasaroy] 
    FROM (
        SELECT year, district_name, population
        FROM city_population
        WHERE district_name IN ('Bektemir', 'Chilonzor', 'Yakkasaroy')
    ) AS SourceTable
    PIVOT (SUM(population) FOR district_name IN ([Bektemir], [Chilonzor], [Yakkasaroy])) AS PivotTable
) p
UNPIVOT (
    Population FOR district_name IN ([Bektemir], [Chilonzor], [Yakkasaroy])
) AS u;
