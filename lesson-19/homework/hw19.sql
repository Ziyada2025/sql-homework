1.Create procedure sp_EmployeeBonus
as 
begin  
create table ##EmployeeBonus 
(employeeid int, 
fullname varchar(100), 
[Department] varchar(50), 
salary decimal(10,2), 
bonusamount decimal(10,2)) 
insert into ##EmployeeBonus 
select e.employeeid, 
concat(e.firstname, ' ', e.Lastname) as Fullname, 
d.Department, 
e.salary, 
Cast((e.salary*d.bonuspercentage/100) as decimal(10,2)) as Bonusamount 
from employees e 
join departmentbonus d 
on e.department=d.Department  
select * from 
##EmployeeBonus 
end 
2.CREATE PROCEDURE sp_UpdateDepartmentSalary
    @DepartmentName NVARCHAR(50),
    @IncreasePercentage DECIMAL(5,2)
AS
BEGIN
    UPDATE Employees
    SET Salary = Salary * (1 + @IncreasePercentage / 100)
    WHERE Department = @DepartmentName;
    SELECT 
        EmployeeID,
        FirstName,
        LastName,
        Department,
        Salary AS UpdatedSalary
    FROM Employees
    WHERE Department = @DepartmentName;
END; 
EXEC sp_UpdateDepartmentSalary 
    @DepartmentName = 'IT', 
    @IncreasePercentage = 10.00; 
3.MERGE INTO Products_Current AS target
USING Products_New AS source
ON (target.ProductID = source.ProductID)
WHEN MATCHED THEN 
    UPDATE SET 
        target.ProductName = source.ProductName,
        target.Price = source.Price
WHEN NOT MATCHED BY TARGET THEN
    INSERT (ProductID, ProductName, Price)
    VALUES (source.ProductID, source.ProductName, source.Price)
WHEN NOT MATCHED BY SOURCE THEN
    DELETE;
SELECT * FROM Products_Current
ORDER BY ProductID; 
4.SELECT 
    id,
    CASE 
        WHEN p_id IS NULL THEN 'Root'
        WHEN id IN (SELECT DISTINCT p_id FROM Tree WHERE p_id IS NOT NULL) THEN 'Inner'
        ELSE 'Leaf'
    END AS type
FROM Tree
ORDER BY id; 
5.SELECT 
    s.user_id,
    ROUND(
        AVG(CASE WHEN c.action = 'confirmed' THEN 1.0 ELSE 0 END),
        2
    ) AS confirmation_rate
FROM Signups s
LEFT JOIN Confirmations c ON s.user_id = c.user_id
GROUP BY s.user_id
ORDER BY s.user_id;  
6.SELECT * 
FROM employees 
WHERE salary = (SELECT MIN(salary) FROM employees); 
7.CREATE PROCEDURE GetProductSalesSummary
    @ProductID INT
AS
BEGIN
    SELECT 
        p.ProductName,
        SUM(s.Quantity) AS TotalQuantitySold,         
        SUM(s.Quantity * p.Price) AS TotalSalesAmount, 
        MIN(s.SaleDate) AS FirstSaleDate,
        MAX(s.SaleDate) AS LastSaleDate
    FROM Products p
    LEFT JOIN Sales s ON p.ProductID = s.ProductID
    WHERE p.ProductID = @ProductID
    GROUP BY p.ProductID, p.ProductName;
END;
