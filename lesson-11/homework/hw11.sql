1.SELECT o.orderID, YEAR (o.orderdate) as [Orderyear],  c.firstname, c.lastname 
FROM orders o 
LEFT JOIN customers c 
ON o.customerID=c.CustomerID 
WHERE YEAR (o.orderdate)>2022; 
2.SELECT e.name, d.departmentname 
FROM employees e 
LEFT JOIN departments d 
ON e.departmentID=d.DepartmentID 
WHERE d.DepartmentName IN ('sales', 'marketing'); 
3.SELECT d.DepartmentName, MAX(e.salary) as [Maxsalary] 
FROM employees e 
LEFT JOIN departments d 
ON e.DepartmentID=d.DepartmentID 
GROUP BY d.DepartmentName; 
4.SELECT c.firstname, c.lastname, o.orderID, YEAR(o.orderdate) as [YEAR]
FROM customers c 
LEFT JOIN orders o 
ON c.CustomerID=o.CustomerID 
WHERE c.country='USA' AND YEAR(o.orderdate)=2023; 
5.SELECT c.firstname, c.lastname, COUNT(o.orderID) as [Totalorders]
FROM customers c 
LEFT JOIN orders o 
ON c.CustomerID=o.CustomerID 
GROUP BY c.firstname, c.lastname; 
6.SELECT p.productname, s.suppliername 
FROM products p 
LEFT JOIN suppliers s 
ON p.SupplierID=s.SupplierID 
WHERE s.suppliername in ('Gadget Supplies', 'Clothing Mart'); 
7.SELECT c.firstname, c.lastname,  MAX(o.OrderDate) AS [themostrecent] 
FROM customers c 
LEFT JOIN orders o 
ON c.customerID=o.CustomerID 
GROUP BY c.firstname, c.lastname; 
8.SELECT c.firstname, c.lastname,o.totalamount 
FROM customers c 
JOIN orders o 
ON c.CustomerID=o.CustomerID 
WHERE o.totalamount>500; 
9.SELECT p.productname, YEAR(s.saledate) AS [SaleDate], s.saleamount 
FROM products p 
LEFT JOIN sales s 
ON p.ProductID=s.ProductID 
WHERE YEAR(s.saledate)=2022 AND s.saleamount>400; 
10.SELECT p.productname, SUM(s.saleamount) as [Totalsaleamount]
FROM products p 
LEFT JOIN sales s 
ON p.ProductID=s.ProductID 
GROUP BY p.productname;
11.SELECT e.name, e.salary, d.departmentname 
FROM employees e 
LEFT JOIN departments d 
ON e.DepartmentID=d.DepartmentID 
WHERE d.DepartmentName='Human resources' AND e.salary>60000; 
12.SELECT p.productname, YEAR(s.saledate) AS year, SUM(p.stockquantity) as stockquantity
FROM products p 
LEFT JOIN sales s 
ON p.ProductID=s.ProductID 
GROUP BY p.productname, YEAR(s.saledate) 
HAVING YEAR(s.saledate)=2023 AND SUM(p.stockquantity)>100; 
13.SELECT e.name, YEAR(e.hiredate) AS [hiredate], d.departmentname 
FROM employees e 
LEFT JOIN departments d 
ON e.DepartmentID=d.DepartmentID 
WHERE YEAR(e.hiredate)>2020 OR d.DepartmentName='sales'; 
14.SELECT c.firstname, c.lastname, o.orderid, c.address, o.orderdate 
FROM customers c 
LEFT JOIN orders o 
ON c.CustomerID=o.CustomerID 
WHERE c.country='USA' AND c.address LIKE '[0-9][0-9][0-9][0-9]%'; 
15.SELECT p.productname, p.category, SUM(s.saleamount) as saleamount
FROM products p 
JOIN sales s 
ON p.ProductID=s.ProductID 
GROUP BY  p.productname, p.category
HAVING p.category='Electronics' or SUM(s.SaleAmount)>350 
16.SELECT c.categoryname, SUM(p.productID) AS Productcount 
FROM products p 
JOIN categories c 
ON p.categoryID=c.CategoryID 
GROUP BY c.categoryname 
17.SELECT c.firstname, c.lastname, c.city, o.orderid, o.totalamount 
FROM customers c 
JOIN orders o 
ON c.CustomerID=o.CustomerID 
WHERE c.city='Los Angeles' and o.totalamount>300; 
18.SELECT e.name, d.departmentname 
FROM employees e 
JOIN departments d 
ON e.DepartmentID=d.DepartmentID 
WHERE d.DepartmentName IN ('Human resources', 'Finance') 
OR e.name LIKE '%[a,e,i,o,u]%[a,e,i,o,u]%[a,e,i,o,u]%[a,e,i,o,u]%'; 
19.SELECT e.name, d.departmentname, e.salary 
FROM employees e 
JOIN departments d 
ON e.DepartmentID=d.DepartmentID 
WHERE d.DepartmentName IN ('sales', 'marketing') AND e.salary>60000;
