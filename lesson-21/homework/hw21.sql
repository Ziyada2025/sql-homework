1. Write a query to assign a row number to each sale based on the SaleDate. 
SELECT 
    SaleID,
    ProductName,
    SaleDate,
    SaleAmount,
    Quantity,
    CustomerID,
    ROW_NUMBER() OVER (ORDER BY SaleDate) as RowNumber
FROM ProductSales
ORDER BY SaleDate;
2. Write a query to rank products based on the total quantity sold. give the same rank for the same amounts without skipping numbers. 
SELECT 
    ProductName,
    SUM(Quantity) as TotalQuantitySold,
    DENSE_RANK() OVER (ORDER BY SUM(Quantity) DESC) as QuantityRank
FROM ProductSales
GROUP BY ProductName
ORDER BY QuantityRank;
3. Write a query to identify the top sale for each customer based on the SaleAmount. 
WITH RankedSales AS (
    SELECT 
        SaleID,
        ProductName,
        SaleDate,
        SaleAmount,
        Quantity,
        CustomerID,
        ROW_NUMBER() OVER (PARTITION BY CustomerID ORDER BY SaleAmount DESC, SaleDate) as SaleRank
    FROM ProductSales
)
SELECT 
    SaleID,
    ProductName,
    SaleDate,
    SaleAmount,
    Quantity,
    CustomerID
FROM RankedSales
WHERE SaleRank = 1
ORDER BY CustomerID;
4. Write a query to display each sale's amount along with the next sale amount in the order of SaleDate. 
SELECT 
    SaleID,
    ProductName,
    SaleDate,
    SaleAmount,
    Quantity,
    CustomerID,
    LEAD(SaleAmount) OVER (ORDER BY SaleDate) as NextSaleAmount
FROM ProductSales
ORDER BY SaleDate;
5. Write a query to display each sale's amount along with the previous sale amount in the order of SaleDate. 
SELECT 
    SaleID,
    ProductName,
    SaleDate,
    SaleAmount,
    Quantity,
    CustomerID,
    LAG(SaleAmount) OVER (ORDER BY SaleDate) as PreviousSaleAmount
FROM ProductSales
ORDER BY SaleDate;
6. Write a query to identify sales amounts that are greater than the previous sale's amount
WITH SalesWithPrevious AS (
    SELECT 
        SaleID,
        ProductName,
        SaleDate,
        SaleAmount,
        Quantity,
        CustomerID,
        LAG(SaleAmount) OVER (ORDER BY SaleDate) as PreviousSaleAmount
    FROM ProductSales
)
SELECT 
    SaleID,
    ProductName,
    SaleDate,
    SaleAmount,
    PreviousSaleAmount,
    Quantity,
    CustomerID,
    (SaleAmount - PreviousSaleAmount) as IncreaseAmount
FROM SalesWithPrevious
WHERE SaleAmount > PreviousSaleAmount
ORDER BY SaleDate;
7. Write a query to calculate the difference in sale amount from the previous sale for every product 
WITH ProductSalesWithPrevious AS (
    SELECT 
        SaleID,
        ProductName,
        SaleDate,
        SaleAmount,
        Quantity,
        CustomerID,
        LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) as PreviousSaleAmount
    FROM ProductSales
)
SELECT 
    SaleID,
    ProductName,
    SaleDate,
    SaleAmount,
    PreviousSaleAmount,
    CASE 
        WHEN PreviousSaleAmount IS NULL THEN 'First Sale'
        ELSE CAST((SaleAmount - PreviousSaleAmount) AS VARCHAR(20))
    END as AmountDifference,
    Quantity,
    CustomerID
FROM ProductSalesWithPrevious
ORDER BY ProductName, SaleDate;
8. Write a query to compare the current sale amount with the next sale amount in terms of percentage change. 
SELECT 
    SaleID,
    ProductName,
    SaleDate,
    SaleAmount,
    LEAD(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) as NextSaleAmount,
    CASE 
        WHEN LEAD(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) IS NOT NULL
        THEN ROUND(
            ((LEAD(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) - SaleAmount) / 
             SaleAmount) * 100, 
            2
        )
        ELSE NULL
    END as PercentageChangeToNext,
    Quantity,
    CustomerID
FROM ProductSales
ORDER BY ProductName, SaleDate;
9. Write a query to calculate the ratio of the current sale amount to the previous sale amount within the same product. 
SELECT 
    SaleID,
    ProductName,
    SaleDate,
    SaleAmount,
    LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) as PreviousSaleAmount,
    CASE 
        WHEN LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) IS NOT NULL
        THEN ROUND(
            SaleAmount / LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate),
            3
        )
        ELSE NULL
    END as RatioToPrevious,
    Quantity,
    CustomerID
FROM ProductSales
ORDER BY ProductName, SaleDate;
10. Write a query to calculate the difference in sale amount from the very first sale of that product.
SELECT 
    SaleID,
    ProductName,
    SaleDate,
    SaleAmount,
    FIRST_VALUE(SaleDate) OVER (PARTITION BY ProductName ORDER BY SaleDate) as FirstSaleDate,
    FIRST_VALUE(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) as FirstSaleAmount,
    SaleAmount - FIRST_VALUE(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) as AmountDifferenceFromFirst
FROM ProductSales
ORDER BY ProductName, SaleDate;
11. Write a query to find sales that have been increasing continuously for a product (i.e., each sale amount is greater than the previous sale amount for that product).
SELECT 
    curr.SaleID as CurrentSaleID,
    curr.ProductName,
    curr.SaleDate as CurrentSaleDate,
    curr.SaleAmount as CurrentSaleAmount,
    prev.SaleID as PreviousSaleID,
    prev.SaleDate as PreviousSaleDate,
    prev.SaleAmount as PreviousSaleAmount,
    curr.SaleAmount - prev.SaleAmount as IncreaseAmount
FROM ProductSales curr
JOIN ProductSales prev ON curr.ProductName = prev.ProductName 
    AND prev.SaleDate = (
        SELECT MAX(SaleDate) 
        FROM ProductSales 
        WHERE ProductName = curr.ProductName 
        AND SaleDate < curr.SaleDate
    )
WHERE curr.SaleAmount > prev.SaleAmount
ORDER BY curr.ProductName, curr.SaleDate; 

12. Write a query to calculate a "closing balance"(running total) for sales amounts which adds the current sale amount to a running total of previous sales.
SELECT 
    SaleID,
    ProductName,
    SaleDate,
    SaleAmount,
    SUM(SaleAmount) OVER (ORDER BY SaleDate) as RunningTotal,
    Quantity,
    CustomerID
FROM ProductSales
ORDER BY SaleDate;
13. Write a query to calculate the moving average of sales amounts over the last 3 sales.
SELECT 
    SaleID,
    ProductName,
    SaleDate,
    SaleAmount,
    ROUND(
        AVG(SaleAmount) OVER (
            ORDER BY SaleDate 
            ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
        ), 
        2
    ) as MovingAvg3Sales,
    Quantity,
    CustomerID
FROM ProductSales
ORDER BY SaleDate;
14. Write a query to show the difference between each sale amount and the average sale amount. 
SELECT 
    SaleID,
    ProductName,
    SaleDate,
    SaleAmount,
    ROUND(AVG(SaleAmount) OVER (), 2) as OverallAvgSaleAmount,
    ROUND(SaleAmount - AVG(SaleAmount) OVER (), 2) as DifferenceFromOverallAvg,
    Quantity,
    CustomerID
FROM ProductSales
ORDER BY SaleDate;
15. Find Employees Who Have the Same Salary Rank
SELECT 
    EmployeeID,
    Name,
    Department,
    Salary,
    DENSE_RANK() OVER (PARTITION BY Department ORDER BY Salary DESC) as SalaryRank,
    COUNT(*) OVER (PARTITION BY Department, Salary) as TiesCount
FROM Employees1
ORDER BY Department, SalaryRank;
16. Identify the Top 2 Highest Salaries in Each Department
WITH RankedSalaries AS (
    SELECT 
        EmployeeID,
        Name,
        Department,
        Salary,
        DENSE_RANK() OVER (PARTITION BY Department ORDER BY Salary DESC) as SalaryRank
    FROM Employees1
)
SELECT 
    EmployeeID,
    Name,
    Department,
    Salary,
    SalaryRank
FROM RankedSalaries
WHERE SalaryRank <= 2
ORDER BY Department, SalaryRank, EmployeeID;
17. Find the Lowest-Paid Employee in Each Department
WITH RankedSalaries AS (
    SELECT 
        EmployeeID,
        Name,
        Department,
        Salary,
        HireDate,
        DENSE_RANK() OVER (PARTITION BY Department ORDER BY Salary ASC) as SalaryRank
    FROM Employees1
)
SELECT 
    EmployeeID,
    Name,
    Department,
    Salary,
    HireDate
FROM RankedSalaries
WHERE SalaryRank = 1
ORDER BY Department;
18. Calculate the Running Total of Salaries in Each Department 
SELECT 
    EmployeeID,
    Name,
    Department,
    Salary,
    HireDate,
    SUM(Salary) OVER (PARTITION BY Department ORDER BY HireDate) as RunningTotalSalary
FROM Employees1
ORDER BY Department, HireDate;
19. Find the Total Salary of Each Department Without GROUP BY

SELECT 
    EmployeeID,
    Name,
    Department,
    Salary,
    SUM(Salary) OVER (PARTITION BY Department) as DepartmentTotalSalary,
    COUNT(*) OVER (PARTITION BY Department) as DepartmentEmployeeCount
FROM Employees1
ORDER BY Department, Salary DESC;
20. Calculate the Average Salary in Each Department Without GROUP BY
SELECT DISTINCT
    Department,
    ROUND(AVG(Salary) OVER (PARTITION BY Department), 2) as AverageSalary,
    COUNT(*) OVER (PARTITION BY Department) as EmployeeCount,
    SUM(Salary) OVER (PARTITION BY Department) as TotalSalary
FROM Employees1
ORDER BY AverageSalary DESC; 
21. Find the Difference Between an Employee’s Salary and Their Department’s Average 
WITH SalaryComparison AS (
    SELECT 
        EmployeeID,
        Name,
        Department,
        Salary,
        ROUND(AVG(Salary) OVER (PARTITION BY Department), 2) as DepartmentAvgSalary,
        ROUND(Salary - AVG(Salary) OVER (PARTITION BY Department), 2) as DifferenceFromAvg
    FROM Employees1
)
SELECT 
    EmployeeID,
    Name,
    Department,
    Salary,
    DepartmentAvgSalary,
    DifferenceFromAvg
FROM SalaryComparison
WHERE DifferenceFromAvg > 0
ORDER BY DifferenceFromAvg DESC;
22. Calculate the Moving Average Salary Over 3 Employees (Including Current, Previous, and Next) 
SELECT 
    EmployeeID,
    Name,
    Department,
    Salary,
    HireDate,
    ROUND(
        AVG(Salary) OVER (
            ORDER BY HireDate
            ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
        ), 
        2
    ) as MovingAvg3Employees,
    LAG(Salary) OVER (ORDER BY HireDate) as PreviousSalary,
    LEAD(Salary) OVER (ORDER BY HireDate) as NextSalary
FROM Employees1
ORDER BY HireDate;
23. Find the Sum of Salaries for the Last 3 Hired Employees 
WITH Last3Hired AS (
    SELECT 
        EmployeeID,
        Name,
        Department,
        Salary,
        HireDate,
        ROW_NUMBER() OVER (ORDER BY HireDate DESC) as HireRank
    FROM Employees1
)
SELECT 
    SUM(Salary) as TotalSalaryLast3Hired,
    COUNT(*) as EmployeeCount,
    ROUND(AVG(Salary), 2) as AverageSalary
FROM Last3Hired
WHERE HireRank <= 3;

