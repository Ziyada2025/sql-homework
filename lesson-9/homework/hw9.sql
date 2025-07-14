Q1: Using Products, Suppliers table List all combinations of product names and supplier names. 
SELECT p.productname, s.suppliername 
FROM Products p CROSS JOIN Suppliers s; 
Q2:Using Departments, Employees table Get all combinations of departments and employees. 
2.1 If i should find all combination of departments and employees using their IDs':
SELECT e.DepartmentID, d.DepartmentID 
FROM Employees e CROSS JOIN Departments d; 
2.2 If i shoul find all combination of departments and employees using their names:
SELECT e.Name, d.DepartmentName 
FROM Employees e CROSS JOIN Departments d 
order by 1; 
Q3:Using Products, Suppliers table List only the combinations where the supplier actually supplies the product. Return supplier name and product name 
SELECT p.productname, s.suppliername 
FROM Products p JOIN Suppliers s 
ON p.productID=s.supplierID; 
Q4: Using Orders, Customers table List customer names and their orders ID. 
SELECT o.OrderID, c.FirstName+' '+LastName as [ Customers_full_name]
FROM Orders o JOIN Customers c 
ON o.customerID=c.customerID; 
Q5:Using Courses, Students table Get all combinations of students and courses.
SELECT s.name, c.coursename 
FROM Students s CROSS JOIN Courses c 
ORDER BY 1; 
Q6:Using Products, Orders table Get product names and orders where product IDs match. 
SELECT p.productname, o.* 
FROM Products p 
JOIN Orders o 
ON p.productID=o.productID;  
Q7: Using Departments, Employees table List employees whose DepartmentID matches the department. 
SELECT e.name 
FROM employees e 
JOIN departments d 
ON e.DepartmentID=d.DepartmentID; 
Q8:Using Students, Enrollments table List student names and their enrolled course IDs. 
  SELECT s.name, e.courseID 
FROM Students s 
JOIN Enrollments e 
ON s.studentID=e.studentID; 
Q9:Using Payments, Orders table List all orders that have matching payments. 
SELECT o.* 
FROM Orders o 
JOIN Payments p 
ON o.OrderID=p.OrderID; 
Q10:Using Orders, Products table Show orders where product price is more than 100. 
SELECT o.*, p.price 
FROM Orders o
JOIN Products p 
ON o.ProductID=p.ProductID 
WHERE p.price>100; 
Q11:Using Employees, Departments table List employee names and department names where department IDs are not equal. It means: Show all mismatched employee-department combinations.
11.1 SELECT e.name, d.departmentname 
FROM Employees e 
JOIN Departments d 
ON e.DepartmentID<>d.DepartmentID;  
11.2 SELECT e.EmployeeID, e.Name, e.DepartmentID, 'Department Does Not Exist' AS DepartmentName
FROM Employees e
LEFT JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentID IS NULL; 
Q12:Using Orders, Products table Show orders where ordered quantity is greater than stock quantity. 
  SELECT o.orderID, o.productID, o.quantity, 'Orders quantity that greater than stock quantity'  AS orders 
FROM Orders o 
LEFT JOIN products p 
ON o.ProductID=p.ProductID 
WHERE o.quantity>p.StockQuantity; 
Q13:Using Customers, Sales table List customer names and product IDs where sale amount is 500 or more. 
  SELECT c.firstname+' '+lastname as [Fullname], s.productID 
FROM Customers c 
JOIN Sales s 
ON c.CustomerID=s.CustomerID 
WHERE s.SaleAmount>=500; 
Q14:Using Courses, Enrollments, Students table List student names and course names they’re enrolled in. 
  SELECT s.name, c.coursename 
 FROM students s 
 JOIN Enrollments e 
 ON s.studentID=e.StudentID
 JOIN Courses c
ON e.courseID=c.courseID; 
Q15:Using Products, Suppliers table List product and supplier names where supplier name contains “Tech”. 
SELECT p.productname, s.suppliername 
FROM Products p
JOIN Suppliers s 
ON p.productID=s.SupplierID 
WHERE s.SupplierName LIKE '%Tech%'; 
Q16:Using Orders, Payments table Show orders where payment amount is less than total amount.
  SELECT o.*, p.* 
FROM orders o 
JOIN Payments p 
ON o.OrderID=p.OrderID 
WHERE p.amount<o.TotalAmount; 
Q17:Using Employees and Departments tables, get the Department Name for each employee. 
  SELECT e.name, d.departmentname 
FROM Employees e 
JOIN Departments d 
ON e.DepartmentID=d.DepartmentID;
  Q18:Using Products, Categories table Show products where category is either 'Electronics' or 'Furniture'.
  SELECT c.categoryname, p.* 
FROM Categories c 
JOIN Products p 
ON p.Category=c.CategoryID 
WHERE c.CategoryName='electronics' or c.CategoryName='furniture'; 
Q19: Using Sales, Customers table Show all sales from customers who are from 'USA'.
SELECT c.*, s.*
 FROM Customers c 
 JOIN Sales s 
 ON c.CustomerID=s.CustomerID 
 WHERE c.Country='USA'; 
Q20:Using Orders, Customers table List orders made by customers from 'Germany' and order total > 100. 
  SELECT o.*, c.* 
 FROM orders o 
 JOIN customers c 
 ON o.CustomerID=c.CustomerID 
 WHERE c.Country='Germany' and o.TotalAmount>100; 
Q21:Using Employees table List all pairs of employees from different departments.
  SELECT
  a.Name AS Employee1,
    a.DepartmentID AS DeptID1,
    b.Name AS Employee2,
    b.DepartmentID AS DeptID2
FROM Employees a
JOIN Employees b ON a.DepartmentID <> b.DepartmentID
WHERE a.EmployeeID < b.EmployeeID  -- Prevents duplicates and self-pairs
ORDER BY a.DepartmentID, b.DepartmentID; 
Q22:Using Payments, Orders, Products table List payment details where the paid amount is not equal to (Quantity × Product Price). 
SELECT p.* 
FROM payments p 
JOIN orders o 
ON p.OrderID=o.OrderID 
JOIN products pr 
ON pr.ProductID=o.ProductID 
WHERE p.Amount<>(o.quantity*pr.Price); 
Q23: Using Students, Enrollments, Courses table Find students who are not enrolled in any course.v
 SELECT s.name, s.StudentID
FROM Students s
LEFT JOIN Enrollments e ON s.StudentID = e.StudentID
WHERE e.StudentID IS NULL; 
Q24:Using Employees table List employees who are managers of someone, but their salary is less than or equal to the person they manage. 
SELECT a.name as emp1, 
       b.name as emp2 
FROM Employees a 
JOIN Employees b ON a.EmployeeID=b.ManagerID
WHERE b.Salary>=a.Salary; 
Q25:Using Orders, Payments, Customers table List customers who have made an order, but no payment has been recorded for it. 
  SELECT o.*, c.*
FROM orders o 
JOIN customers c 
ON o.customerID=c.customerID 
LEFT JOIN payments p 
ON o.OrderID=p.OrderID 
WHERE p.OrderID is null;
