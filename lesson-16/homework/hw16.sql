1.;with mainpart as 
(select 1 as numbers
union all 
select numbers+1 
from mainpart 
where numbers<1000 )
select numbers from mainpart 
option (maxrecursion 1000); 
2. select e.employeeid, 
  e.firstname, 
  e.lastname, 
  s.totalsale
from employees e
join 
(select employeeid, 
  Sum(salesamount) as totalsale 
  from sales 
  group by employeeid) as s
on e.employeeid=s.employeeid; 
3.;with employee as 
(select employeeid, departmentid, firstname, lastname, Salary
from employees ), 
average as 
(select departmentid, Avg(salary) as avgsalary from employees  group by departmentid) 
select e.employeeid, e.DepartmentID, e.firstname, e.lastname, e.salary, a.avgsalary 
from employee e
join average a
on e.DepartmentID=a.DepartmentID; 
4.Select p.productid, p.productname, s.thehighestsales 
from  products p
join (select productid, Max(salesamount) as thehighestsales from sales group by productid) as s 
on p.productid=s.ProductID; 
5.Declare @number int=1 
while  @number*2<1000000 
begin 
print @number 
set @number=@number*2
end  
6.;with employee as 
(select employeeid, firstname, lastname from employees), 
salestable as 
(select employeeid, count(employeeid) as cnt from sales group by employeeid having count(employeeid)>5) 
select e.employeeid, e.firstname, e.lastname, s.cnt 
from employee e 
join salestable s 
on e.EmployeeID=s.EmployeeID  
7.WITH HighValueSales AS (
    SELECT 
        ProductID,
        SalesAmount
    FROM 
        Sales
    WHERE 
        SalesAmount > 500
)
SELECT 
    p.ProductID,
    p.ProductName,
    h.SalesAmount
FROM 
    Products p
JOIN 
    HighValueSales h ON p.ProductID = h.ProductID 
8. ;with findaveragesalary as 
(select avg(salary) as averagesalary from 
employees ) 
Select e.employeeid, e.firstname, e.lastname, e.salary 
from employees e 
join findaveragesalary f
on e.salary>f.averagesalary
where e.salary>f.averagesalary 
1.Select top 5 e.employeeID, e.firstname, e.lastname, numberoforders 
from employees e
Join (select employeeID, Count(*) as numberoforders 
from sales group by employeeID ) as derivedtable 
on e.employeeid=derivedtable.EmployeeID  
2.Select p.categoryID, SUM(derivedtable.totalsale) as categorysale 
From products p 
JOIN (select productID, SUM(salesamount) as totalsale from sales group by productid) as derivedtable 
ON p.ProductID=derivedtable.ProductID
group by p.categoryID
3.;with factorialcte as 
(select 1 as n, 
1 as factorial 
union all 
select n+1, factorial*(n+1) 
from factorialcte
where n<=9) 
Select n.number, f.factorial 
from numbers1 n 
join factorialcte f 
on n.number=f.n 
4.;with cte as 
(select id, 1 as position, substring(string, 1,1) as s, string from example 
union all 
select id, position+1, substring(string, position+1,1), string from cte
where position<=len(string)) 
Select e.id,s 
from example e
join cte c
on e.id=c.id 
order by e.id 
5. ;with cte as 
(select employeeid,  SUM(salesamount) as totalsale,
Month(saledate) as salemonth, 
Year(saledate) as saleyear
from sales 
group by employeeid, Month(saledate), Year(saledate) ), 
cte1 as 
(select employeeid,  totalsale, salemonth, saleyear,  totalsale-lag(totalsale) over 
(partition by employeeid order by  saleyear, salemonth) as differences
from cte) 
select * from cte1 
order by saleyear, salemonth, employeeid; 
6.Select e.employeeid, 
e.firstname, 
e.lastname, 
s.saleyear, 
s.quarterr, 
s.totalsaleinquarter 
from employees e 
join ( select employeeid, 
year(saledate) as saleyear, 
datepart(quarter, saledate) as quarterr, 
sum(salesamount)  
as totalsaleinquarter
from sales 
group by employeeid, 
year(saledate), 
datepart(quarter, saledate)
having sum(salesamount) >45000) s
on e.EmployeeID=s.EmployeeID  
order by s.quarterr 
1.DECLARE @a INT = 0
DECLARE @b INT = 1
DECLARE @temp INT
DECLARE @javob TABLE (fib_number INT)

-- Handle F(0) = 0
INSERT INTO @javob VALUES (0)

WHILE @b < 100  -- Continue while next number is less than 100
BEGIN
    -- Store the current Fibonacci number
    INSERT INTO @javob VALUES (@b)
    
    -- Calculate next number in sequence
    SET @temp = @a + @b
    SET @a = @b
    SET @b = @temp
END

SELECT fib_number FROM @javob 
2.SELECT vals
FROM FindSameCharacters 
WHERE 
    LEN(vals) > 1
    AND REPLACE(vals, LEFT(vals, 1), '')=''  
3.;with cte as 
(
select a=cast(1 as varchar(50)), b=2 
union all 
select a=cast(concat(a,b) as varchar(50)),  b=b+1  from cte 
where b<=5
) 
select a
 from cte  
4.select  e.firstname, e.lastname, s.total
from employees e 
join 
(select employeeid, SUM(salesamount) as total
from sales 
where saledate>dateadd(month, -6, getdate()) and
 saledate<=getdate() 
group  by employeeid 
) s 
on e.EmployeeID=s.EmployeeID 
order by total desc 
5. ;with cte as 
(select distinct PawanName, Pawan_slug_name ,  substring( Pawan_slug_name, 1, patindex('%-%', Pawan_slug_name )) as firstpart, 
substring( Pawan_slug_name, patindex('%-%', Pawan_slug_name )+1, len(Pawan_slug_name)) as secondpart
from RemoveDuplicateIntsFromNames), cte2 as
(select pawanname,  Pawan_slug_name, firstpart, 
case 
when replace(secondpart, left(secondpart,1), '')='' then null 
else secondpart end as valuess
from cte)  
select pawanname, Pawan_slug_name
from cte2 
where valuess is not null
