1.SELECT s.CustomerName, s.Product, s.Quantity, s.Price, s.SaleDate
FROM #Sales s
WHERE EXISTS (
    SELECT 1 
    FROM #Sales s2 
    WHERE s2.CustomerName = s.CustomerName
    AND YEAR(s2.SaleDate) = 2024
    AND MONTH(s2.SaleDate) = 3
)
AND YEAR(s.SaleDate) = 2024 
2.SELECT 
    Product,
    SUM(Quantity * Price) AS TotalRevenue
FROM #sales
GROUP BY Product
HAVING SUM(Quantity * Price) = (
    SELECT MAX(TotalRevenue)
    FROM (
        SELECT SUM(Quantity * Price) AS TotalRevenue
        FROM #sales
        GROUP BY Product
    ) AS RevenueTable 
3.SELECT MAX(Quantity * Price) AS SecondHighestSale
FROM #sales
WHERE (Quantity * Price) < (
    SELECT MAX(Quantity * Price) 
    FROM #sales
);
4.SELECT 
    YEAR(SaleDate) AS Year,
    MONTH(SaleDate) AS Month,
    SUM(Quantity) AS TotalQuantity
FROM #sales
GROUP BY YEAR(SaleDate), MONTH(SaleDate)
ORDER BY Year, Month; 
5.SELECT DISTINCT 
    s1.CustomerName,
    s1.Product
FROM #sales s1
WHERE EXISTS (
    SELECT 1
    FROM #sales s2
    WHERE s2.Product = s1.Product
    AND s2.CustomerName <> s1.CustomerName
)
ORDER BY s1.Product, s1.CustomerName; 
6.select Name, 
COUNT(case when fruit='Apple' then fruit else null end) as Applecnt, 
COUNT(case when fruit='Orange' then fruit else null end) as orangecnt, 
COUNT(case when fruit='Banana' then fruit else null end) as bananacnt 
from fruits 
group by name  
  7.WITH FamilyHierarchy AS (
 SELECT 
        ParentId AS OlderPerson,
        ChildID AS YoungerPerson
    FROM Family
     UNION ALL
    SELECT 
        fh.OlderPerson,
        f.ChildID AS YoungerPerson
    FROM Family f
    INNER JOIN FamilyHierarchy fh ON f.ParentId = fh.YoungerPerson
)
SELECT DISTINCT
    OlderPerson,
    YoungerPerson
FROM FamilyHierarchy
ORDER BY OlderPerson, YoungerPerson; 
  
); 
8.;with cte as (
Select distinct Customerid, deliverystate, amount 
from #orders 
where deliverystate='ca') 
select c.customerid, o.deliverystate, o.amount 
from cte c 
join #orders o 
on c.customerid=o.customerid 
where o.deliverystate='tx' 
9.select *, 
case  
  when address like '%name=%' then address
  else STUFF(address, CHARINDEX('age', address), 0, 'name='+ fullname+' ' )
end new_address
from #residents
update #residents
set address = STUFF(address, CHARINDEX('age', address), 0, 'name='+ fullname+' ' )
where address not like '%name=%' 
10. WITH RoutePaths AS (
    -- Base case: Direct routes from Tashkent
    SELECT 
        RouteID,
        DepartureCity,
        ArrivalCity,
        Cost AS TotalCost,
        1 AS Stops,
        CAST(DepartureCity + ' ' + ArrivalCity AS VARCHAR(MAX)) AS FullRoute
    FROM #Routes 
    WHERE DepartureCity = 'Tashkent'
    
    UNION ALL
    
    -- Recursive case: Extend existing paths
    SELECT 
        r.RouteID,
        rp.DepartureCity,
        r.ArrivalCity,
        rp.TotalCost + r.Cost AS TotalCost,
        rp.Stops + 1 AS Stops,
        CAST(rp.FullRoute + ' ' + r.ArrivalCity AS VARCHAR(MAX)) AS FullRoute
    FROM RoutePaths rp
    JOIN #Routes r ON rp.ArrivalCity = r.DepartureCity
    WHERE rp.ArrivalCity <> 'Khorezm'
)
-- Get cheapest and most expensive routes
SELECT 
    'Cheapest' AS RouteType,
    FullRoute,
    TotalCost,
    Stops
FROM RoutePaths 
WHERE ArrivalCity = 'Khorezm'
AND TotalCost = (SELECT MIN(TotalCost) FROM RoutePaths WHERE ArrivalCity = 'Khorezm')

UNION ALL

SELECT 
    'Most Expensive' AS RouteType,
    FullRoute,
    TotalCost,
    Stops
FROM RoutePaths 
WHERE ArrivalCity = 'Khorezm'
AND TotalCost = (SELECT MAX(TotalCost) FROM RoutePaths WHERE ArrivalCity = 'Khorezm')
ORDER BY RouteType DESC;  
11. SELECT 
    ID,
    Vals,
    SUM(CASE WHEN Vals = 'Product' THEN 1 ELSE 0 END) OVER (ORDER BY ID) AS Rank
FROM #RankingPuzzle
ORDER BY ID; 
12.SELECT 
    e.EmployeeID,
    e.EmployeeName,
    e.Department,
    e.SalesAmount,
    e.SalesMonth,
    e.SalesYear,
    dept_avg.AvgDepartmentSales
FROM #EmployeeSales e
INNER JOIN (
    SELECT 
        Department,
        AVG(SalesAmount) AS AvgDepartmentSales
    FROM #EmployeeSales
    GROUP BY Department
) dept_avg ON e.Department = dept_avg.Department
WHERE e.SalesAmount > dept_avg.AvgDepartmentSales
ORDER BY e.Department, e.SalesAmount DESC; 
13.
SELECT 
    e1.EmployeeID,
    e1.EmployeeName,
    e1.Department,
    e1.SalesAmount,
    e1.SalesMonth,
    e1.SalesYear
FROM #EmployeeSales e1
WHERE NOT EXISTS (
    SELECT 1
    FROM #EmployeeSales e2
    WHERE e2.SalesMonth = e1.SalesMonth
      AND e2.SalesYear = e1.SalesYear
      AND e2.SalesAmount > e1.SalesAmount
)
ORDER BY e1.SalesYear, e1.SalesMonth; 
14.WITH AllMonths AS (
    SELECT DISTINCT SalesMonth, SalesYear
    FROM #EmployeeSales
)
SELECT 
    e.EmployeeID,
    e.EmployeeName,
    e.Department
FROM #EmployeeSales e
WHERE NOT EXISTS (
    -- Find months where this employee did NOT have sales
    SELECT 1
    FROM AllMonths am
    WHERE NOT EXISTS (
        -- Check if employee has sales in this specific month
        SELECT 1
        FROM #EmployeeSales e2
        WHERE e2.EmployeeID = e.EmployeeID
          AND e2.SalesMonth = am.SalesMonth
          AND e2.SalesYear = am.SalesYear
    )
)
GROUP BY e.EmployeeID, e.EmployeeName, e.Department
ORDER BY e.EmployeeID 
15.SELECT 
    Name AS ProductName,
    Category,
    Price,
    Stock
FROM Products
WHERE Price > (SELECT AVG(Price) FROM Products)
ORDER BY Price DESC; 
16.SELECT 
    ProductID,
    Name,
    Category,
    Price,
    Stock
FROM Products
WHERE Stock < (SELECT MAX(Stock) FROM Products)
ORDER BY Stock DESC; 
17.SELECT 
    ProductID,
    Name,
    Category,
    Price,
    Stock
FROM Products
WHERE Category = (SELECT Category FROM Products WHERE Name = 'Laptop')
ORDER BY Name; 
18.SELECT 
    ProductID,
    Name,
    Category,
    Price,
    Stock
FROM Products
WHERE Price > (SELECT MIN(Price) FROM Products WHERE Category = 'Electronics')
ORDER BY Price; 
19.SELECT 
    ProductID,
    Name,
    Category,
    Price,
    Stock,
    CategoryAvgPrice
FROM (
    SELECT 
        ProductID,
        Name,
        Category,
        Price,
        Stock,
        AVG(Price) OVER (PARTITION BY Category) AS CategoryAvgPrice
    FROM Products
) AS CategoryAverages
WHERE Price > CategoryAvgPrice
ORDER BY Category, Price DESC; 
20.SELECT 
    p.ProductID,
    p.Name,
    p.Category,
    p.Price,
    p.Stock
FROM Products p
WHERE EXISTS (
    SELECT 1
    FROM Orders o
    WHERE o.ProductID = p.ProductID
)
ORDER BY p.Name;
21.SELECT 
    p.ProductID,
    p.Name,
    p.Category,
    p.Price,
    SUM(o.Quantity) AS TotalQuantityOrdered,
    (SELECT AVG(Quantity) FROM Orders) AS AveragePerOrder,
    (SELECT AVG(Quantity) FROM Orders) * COUNT(o.OrderID) AS ExpectedAverageTotal
FROM Products p
JOIN Orders o ON p.ProductID = o.ProductID
GROUP BY p.ProductID, p.Name, p.Category, p.Price
HAVING SUM(o.Quantity) > (SELECT AVG(Quantity) FROM Orders) * COUNT(o.OrderID)
ORDER BY TotalQuantityOrdered DESC; 
22.SELECT 
    ProductID,
    Name,
    Category,
    Price,
    Stock
FROM Products
WHERE ProductID NOT IN (
    SELECT DISTINCT ProductID
    FROM Orders
)
ORDER BY Name; 
23.SELECT TOP 1
    p.ProductID,
    p.Name,
    p.Category,
    p.Price,
    SUM(o.Quantity) AS TotalQuantityOrdered
FROM Products p
JOIN Orders o ON p.ProductID = o.ProductID
GROUP BY p.ProductID, p.Name, p.Category, p.Price
ORDER BY TotalQuantityOrdered DESC;
