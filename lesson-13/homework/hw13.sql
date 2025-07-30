1.SELECT CONCAT (EMPLOYEE_ID, '-', FIRST_NAME, ' ', LAST_NAME) 
FROM Employees 
WHERE FIRST_NAME='Steven' AND LAST_NAME='King'; 
2.UPDATE Employees 
SET PHONE_NUMBER=REPLACE ( PHONE_NUMBER, '124', '999') 
WHERE PHONE_NUMBER LIKE '%124%';  
3.SELECT FIRST_NAME as nameinfo, LEN (FIRST_NAME) as lengthinfo FROM Employees 
WHERE FIRST_NAME LIKE 'A%' or FIRST_NAME LIKE 'J%' or FIRST_NAME LIKE 'M%'
ORDER BY FIRST_NAME; 
4.SELECT  e.first_name, m.manager_id, sum(m.salary) as totalsalary
FROM employees m 
JOIN employees e 
ON m.MANAGER_ID=e.EMPLOYEE_ID 
GROUP BY e.first_name, m.manager_id
5.SELECT Year1,
CASE 
WHEN Max1 > Max2 THEN MAX1 
WHEN Max2 > Max3 THEN Max2  
else Max3 end as highestvalue
FROM TestMax; 
6.SELECT * FROM cinema 
WHERE id%2=1 and description!='boring'; 
7.SELECT * FROM SingleOrder  
ORDER BY 
CASE 
WHEN ID=0 THEN 1 
ELSE 0 end, id; 
8.SELECT id ,
CASE 
WHEN SSN IS NOT NULL THEN ssn 
WHEN passportid IS NOT NULL THEN passportid 
WHEN itin IS NOT NULL then itin
Else NULL end Asked_values 
FROM Person; 
--MEDIUM level questions 
1. SELECT*, Substring( Fullname, 1,CHARINDEX (' ', Fullname) ) as Firstname, 
Substring(Fullname, CHARINDEX (' ', Fullname), ChARINDEX ( ' ', fullname, CHARINDEX (' ', Fullname)+1 )-CHARINDEX (' ', Fullname) ) as Middlename, 
Substring(Fullname, ChARINDEX ( ' ', fullname, CHARINDEX (' ', Fullname)+1), 
datalength(fullname)-ChARINDEX ( ' ', fullname, CHARINDEX (' ', Fullname)+1)+1) as lastname
from students;
2.SELECT c.deliverystate, t.CustomerID, t.OrderID, t.Amount 
FROM Orders c 
JOIN Orders t 
ON c.CustomerID=t.CustomerID 
WHERE c.deliverystate='CA'and t.DeliveryState='tx'; 
3.SELECT SequenceNumber , STRING_AGG(string, ', ') within group (order by sequencenumber) as word from DMLTable 
group by SequenceNumber  
4.SELECT *, CONCAT(First_name,' ', LAST_NAME) as Fullname FROM Employees
WHERE CONCAT(First_name,' ', LAST_NAME) LIKE '%a%a%a%' 
5. SELECT department_id,
COUNT(employee_id) as numbeerofemployees, 
SUM (CASE WHEN datediff(year, Hire_date, getdate())>3 THEN 1 ELSE 0 end) as empyears, 
SUM (CASE WHEN datediff(year, Hire_date, getdate())>3 THEN 1 ELSE 0 end)*100/COUNT(employee_id) as percentageofemployeees 
FROM Employees 
GROUP BY department_id 
6. SELECT * FROM
 ( SELECT jobdescription, 
  MAX(missioncount) AS max_experienced, 
  MIN(missioncount) AS min_experienced 
  FROM Personal 
  GROUP BY JobDescription) a
 JOIN personal b 
 ON a.JobDescription=b.JobDescription 
 WHERE max_experienced=missioncount OR min_experienced=missioncount 
DIfficult level 
1. DECLARE @str VARCHAR(100) = 'tf56sd#%OqH';
DECLARE @i INT = 1;
DECLARE @len INT = LEN(@str);
DECLARE @upper VARCHAR(100) = '';
DECLARE @lower VARCHAR(100) = '';
DECLARE @numbers VARCHAR(100) = '';
DECLARE @other VARCHAR(100) = '';

WHILE @i <= @len
BEGIN
    DECLARE @char CHAR(1) = SUBSTRING(@str, @i, 1);
    DECLARE @ascii INT = ASCII(@char);
    
    -- Uppercase letters (ASCII 65-90)
    IF @ascii BETWEEN 65 AND 90
        SET @upper = @upper + @char;
    -- Lowercase letters (ASCII 97-122)
    ELSE IF @ascii BETWEEN 97 AND 122
        SET @lower = @lower + @char;
    -- Numbers (ASCII 48-57)
    ELSE IF @ascii BETWEEN 48 AND 57
        SET @numbers = @numbers + @char;
    ELSE
        SET @other = @other + @char;
    
    SET @i = @i + 1;
END

SELECT 
    @str AS original_string,
    @upper AS uppercase_letters,
    @lower AS lowercase_letters,
    @numbers AS numbers,
    @other AS other_characters;
2.SELECT studentid,fullname, 
  SUM(grade) OVER (ORDER BY studentid) AS cumilative 
  FROM Students 
3.SELECT *, 
CASE 
WHEN Equation='1+2+3' THEN 1+2+3 
WHEN Equation='1+23' THEN 1+23 
WHEN Equation='1+2-3' THEN 1+2-3 
WHEN Equation='12+3' THEN 12+3 
WHEN Equation='1-2+3' THEN 1-2+3 
WHEN Equation='1-23' THEN 1-23 
WHEN Equation='1-2-3' THEN 1-2-3  
WHEN Equation='12-3' THEN 12-3 
ELSE 123 END AS Result 
FROM Equations 
4.select b.* from
(SELECT  Replace(birthday,'-', '') as replacednumbers, COUNT (Replace(birthday,'-', '')) as cntbirthday 
from student 
GROUP BY Replace(birthday,'-', '')
HAVING COUNT (Replace(birthday,'-', ''))>1) a 
JOIN student b 
ON  Replace(birthday,'-', '')= replacednumbers 
5.SELECT 
    CASE WHEN playera < playerb THEN playera ELSE playerb END AS player1,
    CASE WHEN playera < playerb THEN playerb ELSE playera END AS player2,
    SUM(score) AS total_score
FROM PlayerScores
GROUP BY 
    CASE WHEN playera < playerb THEN playera ELSE playerb END,
    CASE WHEN playera < playerb THEN playerb ELSE playera END
ORDER BY player1, player2;
