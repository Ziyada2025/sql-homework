Question 1: Define the following terms: data, database, relational database, and table.
Answer: Data -is raw information that may be saved, processed, and evaluated.A database- is a structured collection of information saved electronically in a computer system.Relational databases -arrange data into organized tables with rows (records) and columns (attributes). It connects relevant data by leveraging table connections.A table- is a structured collection of data arranged by rows and columns. Each row represents one record, and each column represents one of that record's attributes or fields.  
Question 2: List five key features of SQL Server
Answer: High availability, cloud integration, business intelligence and analytics, advanced security, high performance and scalability, and hybrid data solutions.
Question 3: What are the different authentication modes available when connecting to SQL Server? (Give at least 2)
Answer: Windows authentication, sql server authentication. 
Questions 4,5,8: Create a new database in SSMS named SchoolDB.
Write and execute a query to create a table called Students with columns: StudentID (INT, PRIMARY KEY), Name (VARCHAR(50)), Age (INT).Write a query to insert three records into the Students table.
Answers: Create database SchoolDB 
Create table Students ( StudentID Int primary key,name varchar (50), age int) 
insert into Students values( '123', 'Akmal', '19') 
insert into Students values( '456', 'Asror', '16') 
insert into Students values( '789', 'Amir', '23') 
select * from Students
Question 6: Describe the differences between SQL Server, SSMS, and SQL.
Answer: SQL Server- Microsoft’s relational database management system which purpose is store, process and secure the data. 
SQL Server Management Studio-A graphical tool for managing SQL Server which provides an interface to write SQL, design databases, and administer servers.
SQL- A standard language for querying and managing databases.
Question 7: Research and explain the different SQL commands: DQL, DML, DDL, DCL, TCL with examples.
Answer: There are 5 main types of SQL commands: DQL-data query language, which is used to retrieve the date from database. DML-data manipulation language, which is used to modify the data in database. DDL-data defination language-to modify the database structure. DCL-data control language, which is used to control the access. TCL-transaction control language, which is used to control the transactions. 
Question 9:Restore AdventureWorksDW2022.bak file to your server. (write its steps to submit) You can find the database from this link :https://github.com/Microsoft/sql-server-samples/releases/download/adventureworks/AdventureWorksDW2022.bak
Answer: In order to restore the database AdventureWorksDW2022.bak, firstly i have downloaded it and opened the SQL's object explorer pressed the right button of mice and selected "Restore database" window, then from opened new window i changed souce from database to device and fron new opened window with name "select backup devices" i pressed the butten "add" and chose the file and press the enter, then the file automotically uploaded to my sql.
