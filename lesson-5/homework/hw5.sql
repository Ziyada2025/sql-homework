Q1: Write a query that uses an alias to rename the ProductName column as Name in the Products table. 
SELECT 
ProductName AS Name 
FROM Products; 
Q2:Write a query that uses an alias to rename the Customers table as Client for easier reference. 
SELECT * FROM Customers  
AS CLIENT;
Q3:Use UNION to combine results from two queries that select ProductName from Products and ProductName from Products_Discounted. 
SELECT ProductName 
FROM Products
UNION
SELECT ProductName  
FROM Products_Discounted; 
Q4:Write a query to find the intersection of Products and Products_Discounted tables using INTERSECT. 
SELECT *
FROM Products 
INTERSECT
SELECT * 
FROM Products_Discounted; 
Q5: Write a query to select distinct customer names and their corresponding Country using SELECT DISTINCT. 
SELECT DISTINCT 
FirstName,LastName, Country 
From Customers; 
Q6: Write a query that uses CASE to create a conditional column that displays 'High' if Price > 1000, and 'Low' if Price <= 1000 from Products table.
SELECT Price, 
CASE 
WHEN Price>1000 THEN 'HIGH' 
WHEN Price<=1000 THEN 'LOW' 
END 
FROM Products; 
Q7:Use IIF to create a column that shows 'Yes' if Stock > 100, and 'No' otherwise (Products_Discounted table, StockQuantity column).
 SELECT *,
IIF ( StockQuantity>100, 'Yes', 'No') 
FROM Products_Discounted; 
Q8: Use UNION to combine results from two queries that select ProductName from Products and ProductName from Products_Discounted tables. 
SELECT ProductName 
FROM Products
UNION
SELECT ProductName  
FROM Products_Discounted; 
Q9:Write a query that returns the difference between the Products and Products_Discounted tables using EXCEPT. 
SELECT * FROM Products 
EXCEPT
SELECT * FROM Products_Discounted; 
Q10:Create a conditional column using IIF that shows 'Expensive' if the Price is greater than 1000, and 'Affordable' if less, from Products table.
 SELECT *, 
IIF ( Price>100, 'EXPENSIVE', 'AFFORDABLE') 
FROM Products; 
Q11:Write a query to find employees in the Employees table who have either Age < 25 or Salary > 60000. 
SELECT *
FROM Employees
WHERE Age<25 OR Salary>60000; 
Q12:Update the salary of an employee based on their department, increase by 10% if they work in 'HR' or EmployeeID = 5
SELECT *, 
CASE 
WHEN DepartmentName='HR' or  EmployeeID=5 THEN Salary*0.10
END
FROM Employees; 
Q13:Write a query that uses CASE to assign 'Top Tier' if SaleAmount > 500, 'Mid Tier' if SaleAmount BETWEEN 200 AND 500, and 'Low Tier' otherwise. (From Sales table 
SELECT *, 
CASE 
WHEN SaleAmount> 500 THEN'Top Tier' 
WHEN SaleAmount BETWEEN 200 AND 500 THEN 'MID TIER' 
ELSE 'LOW TIER' 
END 
FROM Sales; 
Q14:Use EXCEPT to find customers' ID who have placed orders but do not have a corresponding record in the Sales table. 
SELECT CustomerID FROM Orders
EXCEPT
SELECT CustomerID FROM Sales; 
Q15:Write a query that uses a CASE statement to determine the discount percentage based on the quantity purchased. Use orders table. Result set should show customerid, quantity and discount percentage. The discount should be applied as follows: 1 item: 3% Between 1 and 3 items : 5% Otherwise: 7% 
 SELECT CustomerID,Quantity,
CASE 
WHEN Quantity=1 THEN TotalAmount*0.03 
WHEN Quantity BETWEEN 1 AND 3 THEN TotalAmount*0.05 
ELSE TotalAmount*0.07 
END discountpercentage
FROM Orders;
  
