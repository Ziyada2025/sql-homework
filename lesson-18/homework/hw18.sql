1.Select p.productid, SUM(s.quantity) as totalquantity, SUM(s.quantity*p.price) as totalrevenue 
into #monthlysaless 
from products p
join sales s 
on p.productid=s.productid 
where year(saledate)=year(getdate()) 
and month(saledate)=month(getdate())
group by p.productid  
2.create view vw_prodductsalessummary 
as 
Select p.productid, p.productname, p.category, SUM(s.quantity) as totalquantitysold,  
SUM(s.quantity*p.price) as totalrevenue
from products p 
join sales s 
on p.productid=s.productid 
group by p.productid, p.productname, p.category  
3.CREATE or alter FUNCTION fn_GetTotalRevenueForProduct(@ProductID INT)
RETURNS TABLE
AS
RETURN 
(Select p.productid,  
SUM(s.quantity*p.price) as totalrevenue
from products p 
join sales s 
on p.productid=s.productid 
group by p.productid)  
4.create or alter function fn_GetSalesByCategory(@Category VARCHAR(50)) 
returns table 
as  
return 
(Select p.productname, p.category, SUM(s.quantity) as totalquantitysold,  
SUM(s.quantity*p.price) as totalrevenue
from products p 
join sales s 
on p.productid=s.productid 
where p.category=@category
group by  p.productname, p.category 
) 
5.Create or alter function fn_IsPrime (@Number INT)
Returns varchar(50)  
as 
begin 
declare @i int=2 
declare @check int=1 
if @number<2 
return 'tub son emas' 
while @i<@number 
begin 
if @number%@i=0 
begin 
set @check=0  
break 
end 
else 
set @i=@i+1 
end 
--result-- 

return case when @check=0 
then 'The number is not prime' 
else 'This is prime' 
end 
end
6.
CREATE  FUNCTION fn_GetNumbersBetween 
(
    @Start INT,
    @End INT
)
RETURNS TABLE
AS
RETURN
(
    WITH Numbers AS 
    (
        -- Anchor member: start with the first number
        SELECT @Start AS Number
        UNION ALL
        -- Recursive member: increment until we reach the end
        SELECT Number + 1
        FROM Numbers
        WHERE Number < @End
    )
    SELECT Number
    FROM Numbers
)
7.;WITH DistinctSalaries AS (
    SELECT DISTINCT salary FROM Employees
),
RankedSalaries AS (
    SELECT 
        salary,
        DENSE_RANK() OVER (ORDER BY salary DESC) as salary_rank
    FROM DistinctSalaries
)
SELECT 
    (SELECT salary FROM RankedSalaries WHERE salary_rank = 42) 
    as getNthHighestSalary;

8.;WITH AllFriendships AS (
    SELECT requester_id as person_id, accepter_id as friend_id FROM FriendRequests
    UNION ALL
    SELECT accepter_id as person_id, requester_id as friend_id FROM FriendRequests
),
FriendCounts AS (

    SELECT 
        person_id,
        COUNT(DISTINCT friend_id) as num_friends
    FROM AllFriendships
    GROUP BY person_id
)

SELECT 
    person_id as id,
    num_friends
FROM FriendCounts
WHERE num_friends = (SELECT MAX(num_friends) FROM FriendCounts); 
9.create or alter view vw_CustomerOrderSummary 
as 
( Select distinct  Count(a.order_id) over (partition by a. customer_id)as totalnubmeroforders, 
SUM(a.amount) over ( partition by a. customer_id) as totalamount, 
Max(a.order_date) over ( partition by a.customer_id) as last_order_date, 
b.name, b.customer_id 
from orders a 
right join customers b 
on a.customer_id=b.customer_id) 
10.;with cte as 
(select *, rownumber-row_number() over (partition by testcase order by testcase) as rn,
isnull(lag(testcase) over (order by rownumber), testcase) as newtestcase 
from gaps ) 
select *, max(newtestcase) 
over (partition by rn order by rownumber) from cte  order by 1
