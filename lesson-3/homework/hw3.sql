Q 1:Define and explain the purpose of BULK INSERT in SQL Server? 
BULK INSERT is a Transact-SQL (T-SQL) command in Microsoft SQL Server that allows high-performance importing of large volumes of data from a 
data file directly into a SQL Server table.  It is optimized for fast data loading with minimal logging, making it ideal for bulk operations.
  The primary purposes of BULK INSERT are:
Fast Data Import – Efficiently loads large datasets (millions of rows) much faster than row-by-row INSERT statements.
Minimal Logging – Reduces transaction log overhead by using bulk-logged or minimal logging (depending on recovery model).
Flexible Format Support – Works with structured text files (CSV, TSV, fixed-width) and can handle different delimiters.
Automation & ETL – Useful in data warehousing, ETL (Extract, Transform, Load) processes, and scheduled data imports. 
Q 2:List four file formats that can be imported into SQL Server? 
SQL Server supports importing data from various structured file formats. Here are four common ones:
1. CSV (Comma-Separated Values)
Description: Plain text where values are separated by commas (,). 
Best for: Simple tabular data, Excel exports, log files.
2. TXT (Tab-Delimited Text File)
Description: Similar to CSV but uses tabs (\t) as separators.
Best for: Data exported from databases or legacy systems.
3. JSON (JavaScript Object Notation)
Description: Lightweight structured data format (key-value pairs).
Best for: Web APIs, NoSQL data, configuration files.
4. XML (Extensible Markup Language)
Description: Hierarchical data format with tags.
  Best for: Complex nested data, SOAP APIs, legacy enterprise systems. 
  Q 3:Create a table Products with columns: ProductID (INT, PRIMARY KEY), ProductName (VARCHAR(50)), Price (DECIMAL(10,2)).
 CREATE TABLE PRODUCTS 
(ProductID INT PRIMARY KEY, 
ProductName VARCHAR (50), 
Price DECIMAL (10,2)) 
Q 4: Insert three records into the Products table using INSERT INTO. 
INSERT INTO PRODUCTS 
 VALUES ( 1, 'TV',1230), 
          (2, 'MIXER', 306), 
	        (3, 'DISHWASHER', 2200) 
Q 5:Explain the difference between NULL and NOT NULL. 
  NULL means a column can store missing, unknown, or inapplicable data (e.g., an optional "Middle Name" field). 
  It’s not zero, empty text, or a default—it’s the absence of a value. 
SQL treats NULL uniquely: comparisons like NULL = NULL return NULL (not TRUE), and you must use IS NULL or IS NOT NULL to check for it.
NOT NULL enforces that a column must always contain a value (e.g., a "UserID" or "Email"). 
  It prevents missing data, ensuring integrity. Unlike NULL, NOT NULL columns have no storage overhead for NULL flags and work 
  predictably in indexes and comparisons.
Key Implications:
Performance: NOT NULL is slightly faster (no NULL-check overhead).
Constraints: Primary keys are implicitly NOT NULL; foreign keys can be NULL if optional.
Design: Use NOT NULL for critical data; NULL for optional fields. 
  Q 6: Add a UNIQUE constraint to the ProductName column in the Products table. 
ALTER TABLE PRODUCTS 
ADD UNIQUE (ProductName) 
Q 7: Write a comment in a SQL query explaining its purpose. 
/* SQL SQL comments serve to document and explain code for better understanding, maintenance, and collaboration. 
They help developers clarify complex logic, record the purpose of queries, disable code during testing, and provide 
context for future modifications. Comments can be single-line (using --) or multi-line (enclosed in /* */), and 
are essential for explaining business rules, optimizations, warnings, and dependencies. 
Well-commented SQL improves readability, reduces errors, and ensures smoother teamwork by making the code's
intent and functionality clear to all stakeholders */ 
Q 8: Add CategoryID column to the Products table.
ALTER TABLE PRODUCTS 
ADD CategoryID INT  
Q 9: Create a table Categories with a CategoryID as PRIMARY KEY and a CategoryName as UNIQUE. 
CREATE TABLE Categories 
(CategoryID INT PRIMARY KEY, 
CategoryName VARCHAR(50) UNIQUE)
Q 10: Explain the purpose of the IDENTITY column in SQL Server. 
  The IDENTITY property in SQL Server is used to automatically generate sequential numeric values for a column, typically serving as a surrogate primary key.
 It simplifies the creation of unique identifiers by eliminating the need for manual value assignment, ensuring each new row receives a distinct number that increments (or decrements) according to specified parameters. 
 Defined as IDENTITY(seed, increment), where seed is the starting value and increment is the step size (e.g., IDENTITY(1,1) starts at 1 and increments by 1).
Key Features and Purpose
Automatic Uniqueness:
Generates unique values like 1, 2, 3... (or custom patterns like 10, 20, 30...), ideal for primary keys.
Avoids duplication risks from manual entry.
Surrogate Key:
Acts as an artificial, database-managed identifier (e.g., OrderID), decoupled from business logic.
Performance Optimization:
Streamlines inserts by offloading value generation to SQL Server, reducing overhead.
Restrictions:
One per table: Only one IDENTITY column allowed.
No manual inserts (unless IDENTITY_INSERT is temporarily enabled).
Gaps may occur: Rollbacks or deletions can create gaps in the sequence (e.g., 1, 2, *4*). 
Q 11: Use BULK INSERT to import data from a text file into the Products table. 
 bulk insert [employeesnew].[dbo].[PRODUCTSTABLE]
from 'C:\Users\islom\Desktop\MAAB Classes\Source\productstable_.txt'
with (firstrow=2,
fieldterminator=',',
rowterminator='\n') 
Q 12: Create a FOREIGN KEY in the Products table that references the Categories table.
ALTER TABLE PRODUCTS
ADD FOREIGN KEY (CategoryID) REFERENCES Categories (CategoryID)
Q 13:Explain the differences between PRIMARY KEY and UNIQUE KEY.
  In SQL databases, Primary Keys (PK) and Unique Keys (UK) are essential constraints that enforce data integrity by ensuring uniqueness in table columns. While they share similarities, they serve distinct purposes in database design. 
  This guide explains their differences, use cases, and best practices.
Primary Key (PK). A Primary Key is a column (or combination of columns) that uniquely identifies each row in a table. It ensures:
No duplicate values (all entries must be unique).
No NULL values (every row must have a value in the PK column).
Only one PK per table (though it can consist of multiple columns as a composite key).
Unique Key (UK). A Unique Key ensures that values in a column (or set of columns) are unique, but unlike a PK:
Allows one NULL value (unless explicitly set to NOT NULL).
Multiple UKs can exist in a single table.
Does not serve as the main row identifier (used for enforcing business rules).
Conclusion: Primary Key (PK) = Mandatory unique identifier (no NULLs, one per table).
Unique Key (UK) = Optional uniqueness constraint (allows NULLs, multiple per table).
Both are crucial for data integrity, but they serve different roles in database design. Use PKs for row identification and UKs for enforcing business-level uniqueness.
Q 14: Add a CHECK constraint to the Products table ensuring Price > 0. 
ALTER TABLE PRODUCTS 
ADD CHECK (PRICE>0) 
Q 15: Modify the Products table to add a column Stock (INT, NOT NULL).
 ALTER TABLE PRODUCTS 
ADD Stock INT NOT NULL DEFAULT 0 
Q 16: Use the ISNULL function to replace NULL values in Price column with a 0. 
UPDATE Products
SET Price = ISNULL(Price, 0)
WHERE Price IS NULL 
Q 17: Describe the purpose and usage of FOREIGN KEY constraints in SQL Server.
A FOREIGN KEY (FK) is a fundamental relational database concept that creates an enforced link between two tables, establishing a parent-child relationship.
  This constraint ensures that values in one table (the child) must match values in another table (the parent), maintaining what's known as referential integrity. 
  By implementing FOREIGN KEY constraints, database designers prevent invalid data relationships that could compromise data accuracy and consistency.
  The primary purpose of FOREIGN KEY constraints is to maintain logical relationships between tables while enforcing several critical rules:
Existence Validation: Every value in the foreign key column(s) of the child table must exist in the referenced primary key or unique key column(s) of the parent table. This prevents orphaned records that reference non-existent data.
Data Consistency: The constraint guarantees that relationships between tables remain valid throughout all database operations, including inserts, updates, and deletes.
Relationship Enforcement: It formally defines the connection between tables, making the database schema self-documenting and ensuring proper join operations in queries.
  Adding to Existing Tables:
sql
ALTER TABLE OrderDetails
ADD CONSTRAINT FK_OrderDetails_Products
FOREIGN KEY (ProductID) REFERENCES Products(ProductID) 
Q 18: Write a script to create a Customers table with a CHECK constraint ensuring Age >= 18.
  CREATE TABLE CUSTOMERS ( AGE INT CHECK ( AGE>=18)) 
  Q 19: Create a table with an IDENTITY column starting at 100 and incrementing by 10. 
  CREATE TABLE MACHINES (ID INT IDENTITY (100,10)) 
  Q 20:Write a query to create a composite PRIMARY KEY in a new table OrderDetails 
  CREATE TABLE OrderDetails 
  (OrderID INT NOT NULL REFERENCES Orders(OrderID),
    ProductID INT NOT NULL REFERENCES Products(ProductID),
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (OrderID, ProductID)) 
  Q 21: Explain the use of COALESCE and ISNULL functions for handling NULL values. 
  NULL values represent missing or unknown data in SQL databases.
  Proper handling of NULLs is crucial for accurate query results and data integrity. 
  SQL provides two primary functions for managing NULL values: ISNULL (SQL Server-specific) and COALESCE (ANSI-standard). 
  While both replace NULLs with specified values, they differ in syntax, flexibility, and use cases.
  Feature       	ISNULL	               COALESCE
Standard	      SQL Server only	      ANSI SQL (cross-platform)
Arguments     	Exactly 2	             2 or more
Return Type   	First argument's type 	Highest precedence type
Performance	     Slightly faster	    Marginally slower
NULL Handling	Simple replacement	   Complex fallback chains
Use Case	Basic NULL substitution  	Advanced conditional logic
Performance Considerations
ISNULL generally has minimal overhead for simple replacements
COALESCE may require more evaluation for multiple argument 
Q 22: Create a table Employees with both PRIMARY KEY on EmpID and UNIQUE KEY on Email.
  CREATE TABLE EMPLOYEES (EMID INT PRIMARY KEY, EMAIL VARCHAR (55) UNIQUE) 
Q 23:Write a query to create a FOREIGN KEY with ON DELETE CASCADE and ON UPDATE CASCADE options. 
  CREATE TABLE OrderItems
  ( OrderItemID INT PRIMARY KEY,
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL,
    CONSTRAINT FK_OrderItems_Orders 
        FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT FK_OrderItems_Products 
        FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
        ON DELETE CASCADE
        ON UPDATE CASCADE)

