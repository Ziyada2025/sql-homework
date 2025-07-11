Q1: Write a query to find the minimum (MIN) price of a product in the Products table. 
SELECT * FROM Products 
WHERE PRICE=(SELECT MIN(PRICE) FROM Products); 
Q2: Write a query to find the maximum (MAX) Salary from the Employees table. 
SELECT * FROM Employees 
WHERE SALARY=(SELECT MAX(SALARY) FROM Employees); 
Q3:Write a query to count the number of rows in the Customers table. 
SELECT COUNT (*)
FROM Customers; 
Q4: Write a query to count the number of unique product categories from the Products table. 
SELECT COUNT (DISTINCT CATEGORY) 
FROM Products; 
Q5:Write a query to find the total sales amount for the product with id 7 in the Sales table. 
SELECT * FROM Sales 
WHERE ProductID=7; 
Q6: Write a query to calculate the average age of employees in the Employees table.
SELECT AVG (Age) FROM Employees; 
Q7: Write a query to count the number of employees in each department. 
SELECT DepartmentName,
COUNT (EmployeeID) as employee_count
FROM Employees 
GROUP BY DepartmentName 
Q8:Write a query to show the minimum and maximum Price of products grouped by Category. Use products table. 
  SELECT Category, 
MIN (PRICE) AS MIN_PRICE, 
MAX (PRICE) AS MAX_PRICE 
FROM Products 
GROUP BY Category; 
Q9:Write a query to calculate the total sales per Customer in the Sales table. 
SELECT CustomerID, 
SUM (SaleAmount) as Total_sale_per_customer
FROM Sales 
GROUP BY CustomerID; 
Q10: Write a query to filter departments having more than 5 employees from the Employees table.(DeptID is enough, if you don't have DeptName).
  SELECT DepartmentName, 
COUNT ( EmployeeID) as Numer_of_employees 
FROM employees 
GROUP BY DepartmentName 
HAVING COUNT (EmployeeID) >5; 
Q11: Write a query to calculate the total sales and average sales for each product category from the Sales table.
  SELECT ProductID, 
SUM(SaleAmount) as [Total_sales], 
AVG(SaleAmount) as [AVG_amount] 
FROM Sales 
GROUP BY ProductID; 
  q12: Write a query to count the number of employees from the Department HR. 
  SELECT DepartmentName,
COUNT (EmployeeID) as Numer_of_employees 
FROM employees 
GROUP BY DepartmentName 
HAVING DepartmentName='HR'; 
Q13:Write a query that finds the highest and lowest Salary by department in the Employees table.(DeptID is enough, if you don't have DeptName). 
  SELECT DepartmentName, 
MAX(Salary) as MAX_SALARY, 
MIN(Salary) as MIN_SALARY 
FROM employees 
GROUP BY DepartmentName; 
Q14:Write a query to calculate the average salary per Department.(DeptID is enough, if you don't have DeptName).
  SELECT DepartmentName, 
AVG(Salary) as AVG_SALARY
FROM employees 
GROUP BY DepartmentName;  
Q15:Write a query to show the AVG salary and COUNT(*) of employees working in each department.(DeptID is enough, if you don't have DeptName).
  
SELECT DepartmentName, 
AVG(Salary) as AVG_SALARY, 
COUNT (EmployeeID) as Number_of_employees
FROM employees 
GROUP BY DepartmentName;  
Q16:Write a query to filter product categories with an average price greater than 400.
SELECT Category, 
AVG(Price) as AVG_price 
FROM Products 
GROUP BY Category 
HAVING AVG (Price)>400; 
Q17:Write a query that calculates the total sales for each year in the Sales table. 
SELECT 
YEAR (SaleDate) as SAle_year, 
SUM(SaleAmount) as Total_sales 
FROM Sales 
GROUP BY YEAR (SaleDate); 
Q18:Write a query to show the list of customers who placed at least 3 orders. 
  Select CustomerID
FROM Orders 
GROUP BY CustomerID 
HAVING COUNT(CustomerID)>=3; 
Q19:Write a query to filter out Departments with average salary expenses greater than 60000.(DeptID is enough, if you don't have DeptName). 
  SELECT DepartmentName, 
AVG(Salary) as AVG_SALARY 
FROM employees 
GROUP BY DepartmentName 
HAVING AVG(Salary)>60000; 
Q20: Write a query that shows the average price for each product category, and then filter categories with an average price greater than 150. 
  SELECT Category, 
AVG(price) as AVG_Price 
FROM Products 
GROUP BY Category 
HAVING AVG(price)>150; 
Q21:Write a query to calculate the total sales for each Customer, then filter the results to include only Customers with total sales over 1500.
  
SELECT CustomerID, 
SUM (SaleAmount) as Total_Sale 
FROM Sales 
GROUP BY CustomerID 
HAVING SUM(SaleAmount)>1500; 
Q22:Write a query to find the total and average salary of employees in each department, and filter the output to include only departments with an average salary greater than 65000.
  SELECT DepartmentName, 
SUM(Salary) as Total_salary, 
AVG(salary) as AVG_salary 
FROM Employees 
GROUP BY DepartmentName 
HAVING AVG(salary)>65000; 
Q24: Write a query that calculates the total sales and counts unique products sold in each month of each year, and then filter the months with at least 2 products sold.(Orders)
    SELECT 
    YEAR(OrderDate) AS Year,
    MONTH(OrderDate) AS Month,
    SUM(TotalAmount) AS Total_Sales,
    COUNT(DISTINCT ProductID) AS Unique_Products
FROM 
    Orders
GROUP BY 
    YEAR(OrderDate), MONTH(OrderDate)
HAVING 
    COUNT(DISTINCT ProductID) >= 2
ORDER BY 
    Year, Month; 
Q25: Write a query to find the MIN and MAX order quantity per Year. From orders table. 
  SELECT 
YEAR(OrderDate) as [year], 
MAX(Quantity) as [MAX_quantity], 
MIN(Quantity) as [MIN_quantity] 
FROM Orders 
GROUP BY YEAR (OrderDate);
  
