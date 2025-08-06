1.  SELECT *, SUBSTRING(NAME,1,CHARINDEX(',', Name)-1) as Firstname, 
 SUBSTRING(NAME,CHARINDEX(',', Name)+1, LEN(NAME)-CHARINDEX(',', Name)+1) as Lastname
 FROM TestMultipleColumns;
2. SELECT *  
 FROM TestPercent 
 WHERE PATINDEX('%[%]%', Strs)>0; 
3. SELECT o.*, s.value 
From splitter o 
cross apply string_split( vals, '.') s
4.DECLARE @matn VARCHAR(100)='1234ABC123456XYZ1234567890ADS' 
DECLARE @raqam int 
WHILE 
PATINDEX('%[0-9]%', @matn)>0 
BEGIN 
SET @raqam=PATINDEX('%[0-9]%', @matn) 
SET @matn=STUFF(@matn,@raqam,1, 'X') 
END 
SELECT @matn; 
5.SELECT * FROM  testdots 
WHERE Vals LIKE '%.%.%' 
6.SELECT *, TRIM(texts), 
LEN(texts)-LEN(REPLACE(texts,' ', '')) 
FROM CountSpaces; 
7.SELECT e.Name, m.name as managers_name, e.salary 
FROM Employee e 
JOIN Employee m 
ON e.managerID=m.Id 
WHERE e.salary>m.salary; 
8.SELECT Employee_id, First_name,Last_name, Datediff(YEAR, Hire_date,getdate()) as Years_of_service 
FROM Employees 
WHERE Datediff(YEAR, Hire_date,getdate())>10 and Datediff(YEAR, Hire_date,getdate())<15  
1.DECLARE @texts VARCHAR(50)='rtcfvty34redt' 
DECLARE @Letters VARCHAR(50)='' 
DECLARE @Numbers VARCHAR(50)='' 
DECLARE @a int=1 
WHILE 
@a<=LEN(@texts) 
BEGIN 
DECLARE @yangi CHAR(1)=SUBSTRING(@texts, @a,1) 
IF @yangi LIKE '%[0-9]%' 
SET @numbers=@numbers+@yangi 
ELSE 
IF @yangi LIKE '%[a-z]%' 
SET @letters=@letters+@yangi 
SET @a=@a+1 
END 
SELECT @texts as string 
SELECT @letters as letters 
SELECT @numbers as numbers
2.SELECT a.*
FROM weather a 
JOIN weather b 
ON Datediff(Day, b.Recorddate, a.Recorddate)=1
WHERE a.Temperature>b.Temperature; 
3.SELECT player_id, 
MIN(Event_date) as first_time
FROM Activity 
GROUP BY player_id; 
4. SELECT
    PARSENAME(REPLACE(fruit_list, ',', '.'), 2) AS third_fruit
FROM fruits; 
5.Declare @soz Varchar(100)='sdgfhsdgfhs@121313131' 
Declare @position int=1 
declare @yangitable table ( character char(1), position int)
WHILE Len(@soz)>=@position 
Begin 
insert into  @yangitable values( Substring(@soz, @position, 1) , @position)
set @position=@position+1 
end 
SELECT character, position FROM @yangitable
6.SELECT a.id, 
CASE 
WHEN a.code=0 THEN b.code 
ELSE a.code 
END asked 
FROM p1 a 
JOIN p2 b 
ON a.id=b.id; 
7.SELECT employee_id, First_name,
CASE 
WHEN datediff(YEAR, Hire_date, getdate())>1 and datediff(YEAR, Hire_date, getdate())<5 THEN 'Junior' 
WHEN datediff(YEAR, Hire_date, getdate())>=5 and datediff(YEAR, Hire_date, getdate())<10 THEN 'Mid level' 
WHEN datediff(YEAR, Hire_date, getdate())>=10 and datediff(YEAR, Hire_date, getdate())<20 THEN 'Senior' 
WHEN datediff(YEAR, Hire_date, getdate())>=20 THEN 'Veteran' 
ELSE 'New hire' 
END as employment_stage 
FROM employees 
8.SELECT id, vals,
CASE 
WHEN Patindex('[0-9]%', VALS)=0 
THEN null
ELSE  Substring(Vals, 1, 1)  
end as numbers
FROM GetIntegers 
1.SELECT Id, vals, 
CASE 
WHEN Charindex(',', vals)>0 
THEN  substring(vals, 3,1)+','+ substring(vals, 1,1)+','+substring(vals, 5,1)
ELSE Vals 
END 
FROM MultipleVals  
2.select a.player_id, a.device_id 
FROM activity a
WHERE a.event_date in (Select Min(aa.event_date) from activity aa where a.player_id=aa.player_id) 
3.;with salesperarea  as 
(Select financialweek, area, SUM(saleslocal+salesremote) as sumsales
From WeekPercentagePuzzle  
Group by financialweek, area ),  
totalsales as ( 
SELECT financialweek, SUM(saleslocal+salesremote) as sumarea from WeekPercentagePuzzle group by financialweek)  
select s.financialweek, s.area, s.sumsales, t.sumarea, 
ROUND (s.sumsales*100/t.sumarea, 2) as percentageofsale 
FROM salesperarea s 
JOIN totalsales t 
ON s.financialweek=t.financialweek

