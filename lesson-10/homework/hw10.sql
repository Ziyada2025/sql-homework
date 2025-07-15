1.SELECT e.Name, e.salary, d.departmentname 
FROM employees e 
LEFT JOIN departments d
ON e.departmentID=d.departmentID 
WHERE e.salary>50000 
GROUP BY e.Name, e.salary, d.departmentname 
ORDER BY d.DepartmentName  asc; 
2.SELECT c.firstname, c.lastname, o.orderdate 
FROM customers c 
LEFT JOIN orders o 
ON c.CustomerID=o.CustomerID 
WHERE YEAR(o.OrderDate)=2023 
ORDER BY o.OrderDate asc; 
3.SELECT e.name, d.departmentname 
FROM  employees e 
LEFT JOIN departments d
ON e.departmentID=d.departmentID 
GROUP BY e.name, d.departmentname 
ORDER BY d.departmentname  asc; 
4.SELECT s.suppliername, p.productname 
FROM suppliers s 
LEFT JOIN products p 
ON s.SupplierID=p.SupplierID; 
5.SELECT o.orderID, o.orderdate, p.paymentdate, p.amount 
FROM orders o 
FULL OUTER JOIN payments p 
ON o.OrderID=p.OrderID 
ORDER BY o.orderdate asc; 
6.SELECT e.name as [EmployeeName], 
       ee.name as [ManagerName ] 
FROM employees e 
LEFT JOIN employees ee 
ON e.managerID=ee.employeeID 
7.SELECT s.name, c.coursename 
FROM students s 
LEFT JOIN enrollments e 
ON s.StudentID=e.StudentID 
LEFT JOIN courses c 
ON e.CourseID=c.CourseID 
WHERE c.coursename='Math 101'; 
8.SELECT c.firstname, c.lastname, SUM(o.quantity) as [quantity]
FROM customers c 
LEFT JOIN orders o 
ON c.CustomerID=o.CustomerID 
GROUP BY c.firstname, c.lastname
HAVING SUM(o.quantity)>3; 
9.SELECT e.name, d.departmentname 
FROM employees e 
LEFT JOIN departments d 
ON e.DepartmentID=d.DepartmentID 
WHERE d.DepartmentName='Human Resources'; 
10.SELECT d.DepartmentName ,COUNT(e.employeeID) as [EmployeeCount] 
FROM employees e 
LEFT JOIN departments d 
ON e.DepartmentID=d.DepartmentID 
GROUP BY d.DepartmentName  
HAVING COUNT(e.employeeID)>5 
11.SELECT p.productname, s.productID 
FROM products p 
LEFT JOIN sales s 
ON p.productID=s.ProductID 
WHERE s.productID is null; 
12.SELECT c.firstname, c.lastname, COUNT(o.orderID) as Totalorders
FROM customers c 
LEFT JOIN orders o 
ON c.customerID=o.CustomerID 
GROUP BY c.firstname, c.lastname 
HAVING COUNT(o.orderID) >=1; 
13.SELECT e.name, d.departmentname 
FROM employees e 
JOIN departments d 
ON e.DepartmentID=d.DepartmentID 
ORDER BY d.departmentname ; 
14.SELECT e.name as [Employee1], ee.name as [Employee2], e.managerID as [managerID] 
FROM employees e 
JOIN employees ee 
ON e.ManagerID=ee.ManagerID 
WHERE e.EmployeeID<ee.employeeID
ORDER BY e.managerID asc; 
15.SELECT o.orderID, o.orderdate, c.Firstname, c.lastname 
FROM orders o 
LEFT JOIN customers c 
ON o.customerID=c.customerID 
WHERE YEAR (o.orderdate)=2022 
ORDER BY YEAR (o.orderdate) ASC; 
16.SELECT e.name, e.salary, d.departmentname 
FROM employees e 
JOIN departments d 
ON e.DepartmentID=d.DepartmentID 
WHERE d.DepartmentName='sales' AND e.salary>60000 
ORDER BY e.salary ASC; 
17.SELECT o.orderID, o.orderdate, p.paymentdate, p.amount 
FROM orders o 
JOIN payments p 
ON o.OrderID=p.OrderID; 
18.SELECT p.productID, p.productname 
FROM products p 
LEFT JOIN orders o 
ON o.productID=p.ProductID 
WHERE o.productID IS NULL; 
19.SELECT e.name as [Employeename], e.salary as [salary]
FROM employees e 
JOIN 
(SELECT AVG(salary) as avg_salary, departmentID  FROM employees 
GROUP BY departmentID 
) as dtbl 
ON e.DepartmentID=dtbl.departmentID 
WHERE e.salary>dtbl.avg_salary; 
20.SELECT 
    o.orderID, 
    o.orderDate
FROM 
    orders o 
LEFT JOIN 
    payments p ON o.OrderID = p.OrderID
WHERE 
    o.orderDate < '2020-01-01' 
    AND p.orderID IS NULL; 
21.SELECT p.productID, p.productname 
FROM products p 
LEFT JOIN categories c 
ON p.categoryID=c.CategoryID 
WHERE c.categoryID IS NULL; 
22.SELECT e.name as [Employee1], ee.name as [Employee2], e.managerID as [managerID], e.salary as [salary]
FROM employees e 
JOIN employees ee 
ON e.ManagerID=ee.ManagerID 
WHERE e.EmployeeID<ee.employeeID AND e.salary>60000
ORDER BY e.managerID asc; 
23.SELECT 
    e.name AS EmployeeName,
    d.DepartmentName
FROM  employees e
JOIN  departments d ON e.departmentID = d.departmentID
WHERE  d.DepartmentName LIKE 'M%';
24.SELECT s.SaleID, p.ProductName, s.SaleAmount
FROM Products p 
JOIN Sales s ON p.ProductID = s.ProductID
WHERE s.SaleAmount > 500
ORDER BY s.SaleAmount DESC; 
25.SELECT s.name, c.coursename 
FROM students s 
LEFT JOIN enrollments e 
ON s.StudentID=e.StudentID 
LEFT JOIN courses c 
ON e.CourseID=c.CourseID 
WHERE c.coursename<>'Math 101'; 
26.SELECT   o.OrderID,  o.OrderDate,
 NULL AS PaymentID  
FROM   Orders o
LEFT JOIN  Payments p ON o.OrderID = p.OrderID
WHERE  p.OrderID IS NULL 
27.SELECT p.productID, p.productname, c.categoryname 
FROM products p 
LEFT JOIN categories c 
ON p.category=c.categoryID 
WHERE c.CategoryName='electronics' or c.CategoryName='furniture' 
ORDER BY c.categoryname ASC;
