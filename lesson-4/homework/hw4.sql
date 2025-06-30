Q1: Write a query to select the top 5 employees from the Employees table. 
SELECT TOP 5  * FROM Employees;
Q2: Use SELECT DISTINCT to select unique Category values from the Products table. 
SELECT DISTINCT * FROM Products; 
Q3:Write a query that filters the Products table to show products with Price > 100.
SELECT * FROM Products
WHERE PRICE>100; 
Q4: Write a query to select all Customers whose FirstName start with 'A' using the LIKE operator.
SELECT * FROM Customers 
WHERE FirstName LIKE 'A%'; 
Q5: Order the results of a Products table by Price in ascending order. 
SELECT * FROM Products 
ORDER BY Price asc;
Q6:Write a query that uses the WHERE clause to filter for employees with Salary >= 60000 and Department = 'HR'.
SELECT * FROM Employees 
WHERE SALARY>=60000 AND DEPARTMENT='HR'; 
Q7:Use ISNULL to replace NULL values in the Email column with the text "noemail@example.com".From Employees table 
UPDATE Employees
SET Email = ISNULL (Email, 'noemail@example.com')
WHERE Email IS NULL; 
Q8: Write a query that shows all products with Price BETWEEN 50 AND 100. 
SELECT * from Products
WHERE Price BETWEEN 50 AND 100; 
Q9,10:Use SELECT DISTINCT on two columns (Category and ProductName) in the Products table. After SELECT DISTINCT on two columns (Category and ProductName) Order the results by ProductName in descending order. 
SELECT DISTINCT Category, ProductName 
 FROM Products
ORDER BY ProductName desc; 
Q11: Write a query to select the top 10 products from the Products table, ordered by Price DESC. 
SELECT TOP 10 * FROM Products 
Order by Price DESC; 
Q12: Use COALESCE to return the first non-NULL value from FirstName or LastName in the Employees table. 
 SELECT  COALESCE(FirstName, LastName, 'No Name Available') AS PrimaryName
FROM  Employees; 
Q13:Write a query that selects distinct Category and Price from the Products table.
  SELECT DISTINCT Category, Price 
	FROM Products; 
Q14:Write a query that filters the Employees table to show employees whose Age is either between 30 and 40 or Department = 'Marketing'.
  SELECT * FROM Employees 
	WHERE Age BETWEEN 30 AND 40 OR DepartmentName='Marketing' 
Q15:Use OFFSET-FETCH to select rows 11 to 20 from the Employees table, ordered by Salary DESC.
  SELECT * FROM Employees 
	ORDER BY SALARY DESC OFFSET 11 ROW FETCH NEXT 9 ROW ONLY; 
Q 16:Write a query to display all products with Price <= 1000 and Stock > 50, sorted by Stock in ascending order. 
  SELECT * FROM Products 
	WHERE Price <=1000 and StockQuantity>50 
	ORDER BY StockQuantity ASC ; 
Q 17:Write a query that filters the Products table for ProductName values containing the letter 'e' using LIKE. 
  SELECT * FROM Products 
	WHERE ProductName LIKE '%e%'; 
Q 18:Use IN operator to filter for employees who work in either 'HR', 'IT', or 'Finance'. 
  SELECT * FROM Employees 
	WHERE DepartmentName IN ( 'HR', 'IT', 'Finance'); 
Q 19: Use ORDER BY to display a list of customers ordered by City in ascending and PostalCode in descending order.Use customers table 
SELECT * FROM Customers
Order by City asc, PostalCode desc; 
Q 20:Write a query that selects the top 5 products with the highest sales, using TOP(5) and ordered by SalesAmount DESC. 
SELECT TOP 5 * FROM SALES 
ORDER BY SaleAmount DESC; 
Q 21: Combine FirstName and LastName into one column named FullName in the Employees table. (only in select statement) 
SELECT  EmployeeID,
TRIM(CONCAT(FirstName, ' ', LastName)) AS FullName
FROM  Employees; 
Q 22: Write a query to select the distinct Category, ProductName, and Price for products that are priced above $50, using DISTINCT on three columns.
SELECT DISTINCT Category, ProductName, Price FROM Products 
  WHERE Price>50; 
Q 23: Write a query that selects products whose Price is less than 10% of the average price in the Products table. (Do some research on how to find average price of all products) 
SELECT *
FROM  Products
WHERE  Price < (SELECT AVG(Price) * 0.10 FROM Products)
Q 24: Use WHERE clause to filter for employees whose Age is less than 30 and who work in either the 'HR' or 'IT' department.
 SELECT * FROM Employees 
WHERE Age<30 and DepartmentName='IT'or Age<30 and DepartmentName='HR';
Q 25:Use LIKE with wildcard to select all customers whose Email contains the domain '@gmail.com'. 
 SELECT * FROM Employees  
WHERE Email LIKE '%@gmail.com%'; 
Q 27:Write a query that filters the Orders table for orders placed in the last 180 days using BETWEEN and LATEST_DATE in the table. (Search how to get the current date and latest date) 
SELECT * FROM  Orders
WHERE 
 OrderDate BETWEEN 
 DATEADD(day, -180, (SELECT MAX(OrderDate) FROM Orders))   AND 
  (SELECT MAX(OrderDate) FROM Orders);
