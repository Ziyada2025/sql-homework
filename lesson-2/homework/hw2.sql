Question 1: Create a table Employees with columns: EmpID INT, Name (VARCHAR(50)), and Salary (DECIMAL(10,2)).
  Answer 1:
CREATE TABLE Employees 
(EmpID INT, 
Name VARCHAR(50),
Salary DECIMAL (10,2)) 
Question 2: Insert three records into the Employees table using different INSERT INTO approaches (single-row insert and multiple-row insert). 
Answer2: ----MULTIPLE-row insert :---
INSERT INTO Employees 
VALUES ( 1, 'Shakhlo', 5600)  
INSERT INTO Employees 
VALUES ( 2, 'Shakhzod', 8800) 
INSERT INTO Employees 
VALUES ( 3, 'Shakhzoda', 12000) 
----SINGLE-row insert:---  
INSERT INTO Employees 
VALUES ( 1, 'Shakhlo', 5600), 
       ( 2, 'Shakhzod', 8800),
	     ( 3, 'Shakhzoda', 12000) 
Question 3: Update the Salary of an employee to 7000 where EmpID = 1.
Answer3: 
UPDATE Employees 
SET Salary=7000 
WHERE EmpID=1 
Question 4: Delete a record from the Employees table where EmpID = 2. 
Answer4: 
DELETE FROM Employees 
WHERE EmpID=2
Question 5: Give a brief definition for difference between DELETE, TRUNCATE, and DROP. 
Answer5:   
In SQL, understanding the DELETE, DROP, and TRUNCATE commands is important for efficient data management.
While these commands are all used to remove data, they differ significantly in functionality, usage, and performance.
  The DELETE command is a Data Manipulation Language (DML) operation used to remove specific rows from a table based on a given condition. 
 With the help of the “DELETE” command, we can either delete all the rows in one go or delete rows one by one. i.e., 
we can use it as per the requirement or the condition using the Where clause. It is comparatively slower than the TRUNCATE command.
  Here we can use the “ROLLBACK” command to restore the tuple because it does not auto-commit. 
The DROP command is a Data Definition Language (DDL) operation used to completely remove a table, its structure, and all its data from the database.
  Once executed, the table is permanently deleted and cannot be recovered unless from a backup.
  Here we can’t restore the table by using the “ROLLBACK” command because it auto commits.
  The TRUNCATE command is also a Data Definition Language (DDL) operation. 
  It is used to remove all rows from a table efficiently, without deleting the table’s structure. 
  By using this command the existence of all the rows of the table is lost. 
  Here we can’t restore the tuples of the table by using the “ROLLBACK” command. 
  In conclusion we can use all three DELETE, DROP and TRUNCATE to delete the data in the SQL database but they serve different purposes.
  The DELETE command offers fine-grained control over data removal with the ability to roll back changes,
  while DROP permanently removes tables or databases. TRUNCATE provides a fast way to remove all data from a table without affecting its schema.
  It is comparatively faster than the delete command as it deletes all the rows fastly. 
  Question 6: Modify the Name column in the Employees table to VARCHAR(100). 
  Answer6: 
ALTER TABLE Employees 
ALTER COLUMN Name VARCHAR (100) 
QUESTION 7: Add a new column Department (VARCHAR(50)) to the Employees table. 
Answer 7: 
ALTER TABLE Employees 
ADD Department VARCHAR (50) 
Question 8: Change the data type of the Salary column to FLOAT. 
  Answer 8: 
ALTER TABLE Employees 
ALTER COLUMN Salary FLOAT 
Question 9: Create another table Departments with columns DepartmentID (INT, PRIMARY KEY) and DepartmentName (VARCHAR(50)).
  Answer 9: 
CREATE TABLE Departments 
( DepartmentID INT PRIMARY KEY,
DepartmentName VARCHAR (50)) 
Question 10: Remove all records from the Employees table without deleting its structure. 
  Answer 10: 
TRUNCATE TABLE Employees 
Question 11: Insert five records into the Departments table using INSERT INTO SELECT method(you can write anything you want as data). 
  Answer 11: 
INSERT INTO Departments 
VALUES (1, 'Finance'),
       (2, 'Management'),
	     (3, 'Education'), 
	     (4, 'Advertisement'), 
	      (5, 'IT') 
Question 12: Update the Department of all employees where Salary > 5000 to 'Management'.
  Answer 12: 
  ALTER TABLE Departments 
Add Salary INT 
UPDATE Departments 
  SET Salary = 4800 
  WHERE DepartmentID = 1
UPDATE Departments 
  SET Salary = 5600 
  WHERE DepartmentID = 2
UPDATE Departments
  SET Salary = 6000 
  WHERE DepartmentID = 3
UPDATE Departments
  SET Salary = 7000 
  WHERE DepartmentID = 4 
UPDATE Departments 
  SET Salary = 7000 
  WHERE DepartmentID = 5 
UPDATE Departments 
SET DepartmentName = 'Management'
WHERE Salary > 5000 
Question 13: Write a query that removes all employees but keeps the table structure intact. 
Answer 13: 
  TRUNCATE TABLE Departments 
Question 14: Drop the Department column from the Employees table.
  Answer 14: 
  ALTER TABLE Employees
  DROP COLUMN Department 
Question 15: Rename the Employees table to StaffMembers using SQL commands. 
Answer: 
exec sp_rename 'Employees', 'StaffMembers' 
Question 16: Write a query to completely remove the Departments table from the database. 
Answer 16: 
DROP TABLE Departments 
Question 17: Create a table named Products with at least 5 columns, including: ProductID (Primary Key), ProductName (VARCHAR), Category (VARCHAR), Price (DECIMAL)
Answer 17: 
  CREATE TABLE PRODUCTS 
(ProductID INT PRIMARY KEY, 
ProductName VARCHAR(50), 
Category VARCHAR(50), 
Price DECIMAL(10,2)) 
Question 18: Add a CHECK constraint to ensure Price is always greater than 0. 
Answer 18: 
ALTER TABLE PRODUCTS 
ADD CONSTRAINT CHK_PricePositive 
CHECK (Price > 0) 
Question 19: Modify the table to add a StockQuantity column with a DEFAULT value of 50. 
Answer 19: 
ALTER TABLE PRODUCTS 
ADD StockQuantity INT DEFAULT (50) 
Question 20: Rename Category to ProductCategory 
Answer: 
EXEC sp_rename 'PRODUCTS.Category', 'ProductCategory', 'COLUMN' 
Question 21: Insert 5 records into the Products table using standard INSERT INTO queries. 
  Answer 21: 
INSERT INTO PRODUCTS 
VALUES (1,'REFRIGIRATOR LG', 'LARGE HOUSEHOLD APPLIANCES', 1200, 18),
       (2,'MIXER SAMSUNG','SMALL HOUSEHOLD APPLIANCES', 500, 20),
	     (3, 'LAPTOP ASUS', 'HOUSEHOLD ELECTRONICS', 1000, 38), 
	     (4,'DISHWASHER LG', 'LARGE HOUSEHOLD APPLIANCES', 800, 23),
	     (5, 'TV ARTEL','HOUSEHOLD ELECTRONICS', 500, 50) 
Question 22: Use SELECT INTO to create a backup table called Products_Backup containing all Products data.
  Answer: 
SELECT *
INTO Products_Backup
FROM PRODUCTS 
Question 23: Rename the Products table to Inventory. 
  Answer 23: EXEC sp_rename 'PRODUCTS','INVENTORY' 
Question 24: Alter the Inventory table to change the data type of Price from DECIMAL(10,2) to FLOAT. 
  Answer 25: 
ALTER TABLE INVENTORY
DROP CONSTRAINT CHK_PricePositive 
ALTER TABLE INVENTORY
ALTER COLUMN Price FLOAT 
ALTER TABLE INVENTORY
ADD CONSTRAINT CHK_PricePositive CHECK (Price > 0) 
Question 25: Add an IDENTITY column named ProductCode that starts from 1000 and increments by 5 to Inventory table.
  Answer 25: 
ALTER TABLE INVENTORY 
ADD ProductCode INT IDENTITY (1000, 5) 





