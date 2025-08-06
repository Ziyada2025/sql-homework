1.Select id, name, salary 
from employees 
where salary in (select min(salary) from employees);  
2.Select id, product_name, price 
from products 
where price>(select Avg(price) from products); 
3.select id, name, department_id 
from employees 
where department_id in (select id from departments where department_name='sales') 
4.Select customer_id, name 
from customers 
where customer_id not in ( select customer_id from orders) 
5.Select p.id, p.product_name, p.price, p.category_id
from products p
where p.price = ( select  MAX(price) as thehighest from products15 where p.category_id=category_id group by category_id) 
6. SELECT e.id, e.name, e.salary, e.department_id, d.department_name
FROM employees e
JOIN departments d ON e.department_id = d.id
WHERE e.department_id = (
    SELECT TOP 1 department_id
    FROM employees
    GROUP BY department_id
    ORDER BY AVG(salary) DESC
); 
7.select e.id, e.name, e.salary, e.department_id 
from employees1 e 
where e.salary>( select AVG(salary) from employees1 where department_id=e.department_id group by department_id) 
8.select s.student_id, s.name, g.course_id, g.grade 
From students s 
Join grades g
on s.student_id=g.student_id 
where g.grade=(select Max(grade) from grades where g.course_id=course_id group by course_id) 
9.select * from products15y 


;with rankedquery as 
(Select id, 
product_name, 
price, 
category_id,
ROW_NUMBER () over(Partition by category_id order by price desc) as rownumb 
from products15y) 
select id, 
product_name, 
price, 
category_id 
from rankedquery 
where rownumb=3  
10.select * from employees2005 
select avg(salary) from employees2005
select e.id, e.name, e.salary, e.department_id 
from employees2005 e
join 
employees2005 a 
on e.id=a.id 
where e.salary<( select MAX(a.salary) from employees2005 a where e.department_id=a.department_id group by a.department_id) 
and e.salary>(select Avg(b.salary) from employees2005 b)
