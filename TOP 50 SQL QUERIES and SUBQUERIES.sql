--1.Write a query to display the name ( first name and last name ) for those employees who gets more salary than the employee whose ID is 163.
select e.first_name, e.last_name, e.salary
from epmloyees 
where e.salary >(
select e.salary from employee e 
where e.employee_id = 163
)
--2.Write a query to display the name ( first name and last name ), salary, department id, job id for 
--those employees who works in the same designation as the employee works whose id is 169
select e.first_name, e.last_name, e.salary, e.department_id, e.job_id
from employees e
where e.job_id in(
select e.job_id from employees e 
where e.employee_id = 169 
)

--3.Write a query to display the name ( first name and last name ), salary, department id for those employees who earn such amount
--of salary which is the smallest salary of any of the departments.

select e.first_name, e.last_name, e.salary, e.department_id
from employees e
where e.salary in(
select min(e.salary) from employee e
group by e.department_id
)

--4. Write a query to display the employee id, employee name 
--(first name and last name ) for all employees who earn more than the average salary.
select e.employee.id, e.first_name, e.last_name
from employees e
where e.salary>(
select avg(e.salary) from employee e
)

--5.Write a query to display the employee name ( first name and last name ),
-- employee id and salary of all employees who report to Payam.
select e.first_name, e.last_name, e.employee_id, e.salary
from employees e
where e.manager_id =(
select e.employee_id from employees e
where e.last_name ="Payam"
)

--6.Write a query to display the department number, name ( first name and last name ), job
--and department name for all employees in the Finance department.
select department_id,e.first_name, e.last_name, e.job_id
from employees e, department d
where e.department_id = d.department_id
and d.department_name = "finance"

--7.Write a query to display all the information of an employee whose salary
--and reporting person id is 3000 and 121 respectively.
select * from
employees e 
where e.salary = 3000
and e.manager_id in(
select * from employees e
where e.manager_id = 121
)
 --another way
select * from
employees e 
where (e.salary,e.manager_id) = (select 3000, 121)


--8.Display all the information of an employee 
--whose id is any of the number 134, 159 and 183. 

select * 
from employees e 
where e.employee_id IN (134,159,183)


--9.Write a query to display all the information 
--of the employees whose salary is within the range 1000 and 3000.
select *
from employees e 
where e.salary  between 1000 and 3000

--10.Write a query to display all the information of the employees
--whose salary if within the range of smallest salary and 2500.
select *
from employees e 
where e.salary between (select min(e.salary) from employees e) and 2500

--11.Write a query to display all the information of the employees who does not work in
--those departments where some employees works whose manager id within the range 100 and 200.

select *
from employees e 
where e.department_id not in(
select d.department_id from
departments  d
where e.manager_id between 100 and 200
)


--12.Write a query to display all the information for those employees
--whose id is any id who earn the second highest salary.


select *
from employees e 
where e.employee_id in (
select e.employee_id 
from employees e 
where e.salary =
(select max(e.salary)
from employees e
where e.salary<
select max(e.salary)
 from employees e)))

--13.Write a query to display the employee name( first name and last name ) and
--hiredate for all employees in the same department as Clara. Exclude Clara

select e.first_name, e.last_name, e.hire_date
from employees e 
where e.department_id in(
select e.department_id from employees e 
where e.first_name = "clara"
)
and e.first_name <> "clara"

--14.Write a query to display the employee ID and name ( first name and last name ) of all employees who works 
--in such a department where the employees are working whose name containing a letter 'T'

select e.employee_id, e.first_name, e.last_name
from employees e 
where e.department_id in(
select e.department_id from employees e 
where e.first_name like '%T%'
)

--15.Write a query to display the employee number, name( first name and last name ), and salary for all 
--employees who earn more than the average salary and who work in a department with any employee with a J in their name.

select e.employee_id , e.first_name, e.last_name, e.salary
from employees e 
where e.salary > (select avg(e.salary) from employees e)
and e.department_id in(
select e.department_id from employees e
where e.first_name like '%J%'
)

--16.Display the employee name( first name and last name ), employee id, 
--and job title for all employees whose department location is Toronto

select e.first_name, e.last_name,e.employee_id, e.job_id 
from employees e, departments d , locations l 
where e.department_id = d.department_id
and d.location_id = l.location_id
where l.city = "Toronto" 


--17. Write a query to display the employee number, name( first name and last name ) and job title for all employees whose salary is 
--smaller than any salary of those employees whose job title is MK_MAN.

select e.employee_id, e.first_name, e.last_name, e.job_id
from employees e 
where e.salary < any
(select e.salary  from employees e 
where e.job_id = "MK_MAN")

--18. Write a query to display the employee number, name( first name and last name ) and job title for all employees whose 
--salary is smaller than any salary of those employees whose job title is MK_MAN. Exclude Job title MK_MAN.

select e.employee_id, e.first_name, e.last_name, e.job_id
from employees e 
where e.salary < any(
select e.salary from employees e 
where e.job_id ="MK_MAN"
)
and e.job_id <> "MK_MAN"

--19. Write a query to display the employee number, name( first name and last name ) and job title for all employees whose salary 
--is more than any salary of those employees whose job title is PU_MAN. Exclude job title PU_MAN.

select e.employee_id, e.first_name, e.last_name, e.job_id
from employees e 
where e.salary > all(
select e.salary from employees e 
where e.job_id = "PU_MAN"
)
and e.job_id <> "PU_MAN"

--20. Write a query to display the employee number, name( first name and last name ) and 
--job title for all employees whose salary is more than any average salary of any department.

select e.employee_id, e.first_name, e.last_name, e.job_id
from employees e 
where e.salary > all(
select avg(e.salary) from employees e 
group by e.department_id
)

--21. Write a query to display the employee name( first name and last name ) and 
--department for all employees for any existence of those employees whose salary is more than 3700.

select e.first_name, e.last_name, e.department_id
from employees e 
where exists(select e.first_name, e.last_name, e.department_id
from employees e 
where e.salary >3700)
)

--22.Write a query to display the department id and the total salary
--for those departments which contains at least one employee.
select d.department_id, res.total_salary 
from departments d, 
(select e.department_id, sum(e.salary) as total_salary
from employees e 
group by e.department_id)res 
where d.department_id = res.department_id

--23.Write a query to display the employee id, name ( first name and last name ) and the job id column with a modified title SALESMAN 
--for those employees whose job title is ST_MAN and DEVELOPER for whose job title is IT_PROG.

select e.employee_id, e.first_name, e.last_name,
case e.job_id
when "ST_MAN" THEN "SALESMAN"
when  "IT_PROG" THEN "DEVELOPER"
else e.job_id
end as job_title, e.salary 
from employees e



--24.Write a query to display the employee id, name ( first name and last name ), salary and the SalaryStatus column with a
 --title HIGH and LOW respectively for those employees whose salary is more than and less than the average salary of all employees.

select e.employee_id, e.first_name, e.last_name, e.salary,
case
when e.salary >(select avg(e.salary) from emoloyees e) THEN "HIGH"
else "LOW"
end as SalaryStatus
from employees e 



--25.Write a query to display the employee id, name ( first name and last name ), SalaryDrawn, 
--AvgCompare (salary - the average salary of all employees) and the SalaryStatus column witha title HIGH and 
--LOW respectively for those employees whose salary is more than and less than the average salary of all employees.

select e.employee_id, e.first_name, e.last_name , e.salary as SalaryDrwan,
round(select e.salary -(select avg(e.salary) from employees e)),2) as AvgCompare,
case e.salary 
when e.salary >= (select avg(e.salary) from employees e) THEN "HIGH"
else "LOW"
end as SalaryStatus
from employees e

--26.Write a subquery that returns a set of rows to find all departments that do actually have one or more employees assigned to them.

select d.department_name from
departments d 
where d.department_id in(
select distinct(e.department_id) from employees e
)

--27.Write a query that will identify all employees who work in departments located in the United Kingdom

--with joining
select e.employee_id, e.first_name, e.last_name, d.department_name
from employees e, departments d, locations l, countries c
where e.department_id = d.department_id
and d.location_id = l.location_id
and l.country_id = c.country_id
 where c.country_name = "United Kingdom"
 
--without joining(subqueries)
select e.first_name, e.last_name
from employees e where e.department_id in(
select d.department_id from departments d 
where d.location_id in (
select l.location_id from locations l 
where l.country_id in (
select c.country_id from countries c 
where c.country_name ="United Kingdom"
)))

--28.Write a query to identify all the employees who earn more than the average and who work in any of the IT departments.

select e.first_name, e.last_name
from employees e, departments d 
where e.department_id = d.department_id
and e.salary >(select avg(e.salary) from employees e)
and d.department_name like 'IT%'

--29. Write a query to determine who earns more than Mr. Ozer.

select e.lastname, e.first_name, e.salary
from employees e 
where e.salary >
(select e.salary from employees e
where e.last_name = "ozer"
order by e.last_name
)

--30.Write a query to find out which employees have a manager who works for a department based in the US.

select e.employee_id
from employees e, departments d, locations l 
where e.department_id = d.department_id
and d.location_id = l.location_id
and e.manager_id in(
select l.location_id
from locations l 
where l.country_id = "US"
)

--31. Write a query which is looking for the names of all employees whose 
--salary is greater than 50% of their department’s total salary bill.

select e.first_name, e.last_name
from employees e 
where e.salary>(
select (sum(e1.salary))*.5
from employees e1
where e.department_id = e1.department_id
)

--32. Write a query to get the details of employees who are managers.
select *
from employees e 
where exists(
select * from departments d 
where e.employee_id = d.manager_id
)

--33. Write a query to get the details of employees who manage a department
select *
from employees e 
where e.employee_id = any(
select d.manager_id from  departments d 
)

--34.Write a query to display the employee id, name ( first name and last name ), 
--salary, department name and city for all the employees who gets the salary as the salary earn by 
--the employee which is maximum within the joining person January 1st, 2002 and December 31st, 2003.

select e.employee_id, e.first_name, e.last_name, e.salary, e.department_name, e.city
from employees e, departments d, locations l 
where e.salary=(
select max(e.salary) from employees e 
where e.hire_date between '01/01/2002' and '31/12/2003'
)
and e.department_id = d.department_id
and d.location_id = l.location_id

--35. Write a query in SQL to display the department code and 
--name for all departments which located in the city London.

select d.department_id, d.department_name
from departments d, locations l 
where d.location_id = l.location_id
and l.city ="london"

--36. Write a query in SQL to display the first and last name, salary, and department ID for all those employees who
--earn more than the average salary and arrange the list in descending order on salary.

select e.first_name, e.last_name, e.salary, e.department_id
from employees e 
where  e.salary >(
select avg(e.salary) from employees e 
)
order by e.salary desc

--37. Write a query in SQL to display the first and last name, salary, and department ID for 
--those employees who earn more than the maximum salary of a department which ID is 40.

select e.first_name, e.last_name, e.salary, e.department_id
from employees e 
where e.salary > ALL(
select e.salary from employees e 
where e.department_id = 40
)
--38. Write a query in SQL to display the department name and Id for all departments where
--they located, that Id is equal to the Id for the location where department number 30 is located. 

select d.department_id, d.department_name
from departments d 
where d.location_id =(
select d.location_id from departments d 
where d.department_id = 30
)

--39. Write a query in SQL to display the first and last name, salary, and department ID for all 
--those employees who work in that department where the employee works who hold the ID 201
 
 select e.first_name, e.last_name, e.salary, e.department_id
 from employees e 
 where e.department_id = (
 select e.department_id from employees e 
 where e.employee_id = 201
 )
 
--40. Write a query in SQL to display the first and last name, salary, and department ID for those employees
--whose salary is equal to the salary of the employee who works in that department which ID is 40.

select e.first_name, e.last_name, e.salary, e.department_id
from employees e 
where e.salary = (
select e.salary from employees e 
where e.department_id = 40
)

--41.Write a query in SQL to display the first and last name, and department code for all employees who work in the department Marketing. 

select e.first_name, e.last_name, e.department_id
from employees e 
where e.department_id = d.department_id
and d.department_name = "Marketing"

--42.Write a query in SQL to display the first and last name, salary, and department ID for
--those employees who earn more than the minimum salary of a department which ID is 40.

select e.first_name, e.last_name, e.salary, e.department_id
from employees e 
where e.salary > any(
select min(e.salary) from employees e 
where e.department_id = 40 
)

--43.Write a query in SQL to display the full name,email, and designation
--for all those employees who was hired after the employee whose ID is 165.

select e.first_name || ' ' || e.last_name as full_name, e.email
from employees e 
where e.hire_date >(
select e.hire_date from employees e 
where e.employee_id = 165
)
 
--44. Write a query in SQL to display the first and last name, salary, and department ID for
 those employees who earn less than the minimum salary of a department which ID is 70.

select e.first_name, e.last_name, e.salary, e.department_id
from employees e 
where e.salary < ALL
(select min(e.salary) from employees e 
where e.department_id = 70) 

--45.Write a query in SQL to display the first and last name, salary, and department ID for those employees
who earn less than the average salary, and also work at the department where the employee Laura is working as a first name holder.

select e.first_name, e.last_name, e.salary, e.department_id
from employees e 
where e.salary <
(select avg(e.salary) from employees e )
 and e.departments_id = 
 (select e.department_id from employees e where e.first_name ="laura")
 
--46. Write a query in SQL to display the first and last name, salary and department ID
for those employees whose department is located in the city London.

select e.first_name, e.last_name, e.salary, e.department_id
from employees e, departments d, locations l 
where e.department_id = d.department_id
and d.location_id = = l.location_id
and l.city = "London" 

--47. Write a query in SQL to display the city of the employee whose ID 134 and works there.

select l.city
from employees e, departments d, locations l 
where e.department_id = d.department_id
and d.location_id = l.location_id
and e.employee_id = 134

--48. Write a query in SQL to display the details of those departments which max salary is 7000 
--or above for those employees who already done one or more jobs. 

select *
from departments d 
where d.department_id in(
select e.department_id from employees e 
where e.employee_id in(
select e.employee_id from job_history j 
group by j.employee_id
having count(employee_id)>1
)
group by d.department_id
having max(e.salary) > 7000
)

--49. Write a query in SQL to display the detail information 
--of those departments which starting salary is at least 8000.

select * 
from departments d 
where d.department_id in(
select e.department_id from employees e 
group by d.department_id
having min(e.salary) >=8000
)

--50. Write a query in SQL to display the full name
--(first and last name) of manager who is supervising 4 or more employees.


select first_name || ' ' || last_name as Manager
from employees e 
where e.employee_id IN(
select manager_id from employees e 
group by manager_id
having count(*)>=4
)





