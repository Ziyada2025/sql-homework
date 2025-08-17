1.Select distributor, 
Sum( case when region='east' then sales else 0 end) as east_cnt, 
Sum( case when region='north' then sales else 0 end) as north_cnt, 
Sum( case when region='south' then sales else 0 end) as south_cnt,  
Sum( case when region='west' then sales else 0 end) as west_cnt, 
Sum(sales) as totalsales 
from #RegionSales 
group by distributor
2.select a.id, a.name, Count(b.id) as cntmanagers 
from employee a 
join employee b 
on a.id=b.managerId 
group by a.id, a.name
having count(b.id)>=5 
3.Select p.productname, p.price, Datename(Month, o.order_date) as month, year(o.order_date) as year, sum(o.unit) as totalorder, 
sum(p.price*o.unit) as amount
from products p 
join orders o
on p.productid=o.product_id 
where Datename(Month, o.order_date)='february' and year(o.order_date)='2020'
group by Datename(Month, o.order_date),year(o.order_date), p.productname, p.price 
having sum(o.unit)>=100   
4.; with cte as 
(select customerid, vendor, 
count(orderid) as cnt, row_number() over (partition by customerid order by count(orderid) desc) as rn 
from orders 
group by customerid, vendor) 
select customerid, vendor 
from cte 
where rn=1 
5.DECLARE @Check_Prime INT = 91; -- Change this to test any number
DECLARE @IsPrime BIT = 1; -- Start by assuming it's prime
DECLARE @Divisor INT = 2; -- Start checking from 2

-- Handle special cases
IF @Check_Prime <= 1
    SET @IsPrime = 0; -- Numbers ≤ 1 are not prime
ELSE IF @Check_Prime = 2
    SET @IsPrime = 1; -- 2 is prime
ELSE IF @Check_Prime % 2 = 0
    SET @IsPrime = 0; -- Even numbers > 2 are not prime
ELSE
BEGIN
    -- Check odd divisors only, up to square root
    WHILE @Divisor * @Divisor <= @Check_Prime AND @IsPrime = 1
    BEGIN
        IF @Check_Prime % @Divisor = 0
            SET @IsPrime = 0;
        
        SET @Divisor = @Divisor + 1;
    END
END

-- Return the result
SELECT 
    CASE 
        WHEN @IsPrime = 1 THEN 'This number is prime'
        ELSE 'This number is not prime'
    END AS Result;
6.;with cte as (
select  device_id, count(device_id) as numberofsignals, 
count ( distinct locations)  as numberoflocations 
from device 
group by device_id ), 
cte2 as 
(select  distinct locations,device_id,  Count(device_id) as cnt, 
row_number() over (partition by device_id order by Count(device_id) desc) as rn 
from device 
group by locations, device_id) 
select b.locations, a.device_id, a.numberofsignals,
a.numberoflocations 
from cte a
join cte2 b
on a.device_id=b.device_id 
where rn=1 
7.select e.empid, e.empname, e.salary, e.deptid 
from employee e
where e.salary>(select  avg(salary) from employee ee where e.deptid=ee.deptid ) 
8.WITH TicketMatches AS (
    SELECT 
        t.TicketID,
        COUNT(DISTINCT t.Number) AS MatchedNumbers
    FROM 
        Tickets t
    INNER JOIN 
        Numbers n ON t.Number = n.Number
    GROUP BY 
        t.TicketID
),
TicketPrizes AS (
    SELECT
        TicketID,
        CASE
            WHEN MatchedNumbers = (SELECT COUNT(*) FROM Numbers) THEN 100
            WHEN MatchedNumbers > 0 THEN 10
            ELSE 0
        END AS Prize
    FROM
        TicketMatches
)
SELECT 
    SUM(Prize) AS TotalWinnings
FROM 
    TicketPrizes; 
9.;WITH UserPlatforms AS (
    SELECT 
        User_id,
        Spend_date,
        MAX(CASE WHEN Platform = 'Mobile' THEN 1 ELSE 0 END) AS used_mobile,
        MAX(CASE WHEN Platform = 'Desktop' THEN 1 ELSE 0 END) AS used_desktop,
        SUM(Amount) AS total_amount
    FROM 
        Spending
    GROUP BY 
        User_id, Spend_date
),
CategorizedUsers AS (
    SELECT
        Spend_date,
        CASE
            WHEN used_mobile = 1 AND used_desktop = 1 THEN 'Both'
            WHEN used_mobile = 1 THEN 'Mobile Only'
            WHEN used_desktop = 1 THEN 'Desktop Only'
        END AS user_category,
        User_id,
        total_amount
    FROM
        UserPlatforms
)
SELECT
    Spend_date,
    user_category,
    COUNT(User_id) AS total_users,
    SUM(total_amount) AS total_amount_spent
FROM
    CategorizedUsers
GROUP BY
    Spend_date, user_category
ORDER BY
    Spend_date, user_category; 
10.CREATE TABLE Number (n INT PRIMARY KEY);
INSERT INTO Number VALUES (1), (2), (3), (4), (5), (6), (7), (8), (9), (10); 
select * from number 
select * from grouped  
SELECT 
    g.product,
    1 AS quantity
FROM 
    grouped g
JOIN 
    Number n 
	ON n.n <= g.quantity;
