1.Select firstName, lastName, city, state from person p 
left join Address a on p.personId = a.personId
2.Select emp.name as EmpName from Employee Emp join Employee Man
on emp.managerId = man.id
where emp.salary > man.salary
3.select email from Person_
group by email
having count(*) > 1 
4.delete b from Person_ a 
join Person_ b on a.email=b.email and a.id<b.id
5.select * from girls g
left join boys b  on g.ParentName = b.ParentName
where b.ParentName is null
6.Select o.custid,
sum( case when freight>50 then qty*unitprice else 0 end ) TotalSales,
count(case when freight>50 then qty*unitprice else 0 end),
min(o.freight) MInWeight
from TSQL2012.Sales.orders o
join TSQL2012.Sales.OrderDetails ord on o.orderid = ord.orderid
group by o.custid
7.Select  ISNULL(Cart1.item, '') Cart1_Item,
	    ISNULL(Cart2.item, '') Cart2_Item
from Cart1
full join Cart2 on Cart1.Item = Cart2.Item 
8.Select * from customers c 
Left join orders o 
On o.customerID=c.id 
Where o.id is null 
9.Select
    s.student_id,
    s.student_name,
    sub.subject_name,
    Count(e.student_id) As attended_exams
from 
    Students s
cross join
    Subjects sub
left join 
    Examinations e ON s.student_id = e.student_id AND sub.subject_name = e.subject_name
group by 
    s.student_id, s.student_name, sub.subject_name
order by 
    s.student_id, sub.subject_name;
