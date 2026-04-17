-- Employee Workforce Management & Analysis

use employees;
create table employees(
employee_id int auto_increment primary key,
full_name varchar(100),
age int,
gender varchar(10),
department varchar(50),
designation varchar(50),
salary decimal(10,2),
experience_years decimal(4,1),
location varchar(50));

-- 1.Retrieve all employee details.
select * from employees;
insert into employees values(101,"Sanju Thakur",43,"Male","HR","HR Associate",35000,10.2,"Thane");
call employees_data(102,"Vijay Lokhande",47,"Male","HR","HR Associate",40000,17,"Vashi");
insert into employees values(102,"Vijay Lokhande",47,"Male","HR","HR Associate",40000,17,"Vashi"),
(103,"Priyal Bhosale",22,"Male","Finance","Finance Analyst",45000,3,"Bhandup"),
(104,"Shweta Prajapati",22,"Female","Sales","Sales Executive",30000,1,"Ambernath"),
(105,"Priyanka Prajapati",22,"Female","HR","HR Associate",30000,2,"Kalyan"),
(106,"Nita Kadam",31,"Female","IT","Software Engineer",55000,12,"Vikhroli"),
(107,"Ajin Kirtidas",27,"Male","IT","Software Engineer",60000,5.4,"Andheri"),
(108,"Tejas Bedekar",29,"Male","IT","Senior Developer",90000,7.3,"Ghatkopar"),
(109,"Karanvir Singh",32,"Male","Operations","Operations Manager",85000,10,"Thane"),
(110,"Aarti Mojar",36,"Female","Sales","Sales Executive",55000,7,"Dombivali"),
(111,"Kiran Shetty",41,"Male","Operations","Operations Manager",110000,13.4,"Badlapur"),
(112,"Harshada Baraskar",25,"Female","Finance","Finance Analyst",65000,5,"Borivali"),
(113,"Harsh Gore",39,"Male","IT","Senior Developer",95000,6,"Andheri"),
(114,"Shubham Thakkar",33,"Male","IT","Software Engineer",50000,3,"Kalyan"),
(115,"Divyaraj",34,"Male","Finance","Finance Analyst",45000,1.6,"Vashi");

-- 2.Find employees who work in the IT department.
select * FROM employees;
select full_name,department from employees where department ="IT";

-- 3.Show employees with salary greater than 60,000.
select * from employees where salary>60000;

-- 4.Get distinct department names.
select distinct department from employees;

-- 5.Retrieve employees where salary is between 50,000 and 1,00,000.
select * from employees where salary between 50000 and 100000;

-- 6.Find employees from Mumbai location.
update employees set location = "Mumbai" where location = "Andheri";
select * from employees where location = "Mumbai";

-- 7.Show employees whose name starts with ‘A’.
select * from employees where full_name like "a%";

-- 8. Sort employees by salary in descending order.
select * from employees order by salary desc;

-- 9. Find the average salary of each department.
select department,avg(salary) as Avg_Sal from employees group by department;

-- 10.Show total salary paid per department.
select department,sum(salary) as Total_Sal from employees group by department;

-- 11.Find the department with the highest number of employees.
select department,count(employee_id) as num_of_emp from employees group by department;

-- 12.List the minimum and maximum salary in the IT department.
select department,max(salary) as Max_Sal,min(salary) as Min_Sal from employees where department = "IT";

-- 13.Find employees with more than 10 years of experience.
select * from employees where experience_years > 10;

-- 14.Categorize employees as Junior/Mid/Senior level using CASE based on age.
select *,
case
when age between 22 and 30 then "Junior"
when age between 31 and 40 then "Mid-Level"
when age between 41 and 55 then "Senior"
else "Uncategorized"
end as Age_Range
from employees;

-- 15.Display salary range category based on designation.
select *,
case
when designation = "HR Associate" then "25,000 – 40,000"
when designation = "Software Engineer" then "50,000 – 90,000"
when designation = "Senior Developer" then "90,000 – 140,000"
when designation = "Sales Executive" then "30,000 – 55,000"
when designation = "Finance Analyst" then "45,000 – 80,000"
when designation = "Operations Manager" then "80,000 – 120,000"
else "Uncategorized"
end as Salary_Range_Category
from employees;

-- 16.Find all female employees in the Sales department.
select * from employees where gender = "Female" and department = "sales";

-- 17.Retrieve employees whose experience is between 2 and 8 years.
select * from employees where experience_years between 2 and 8;

-- 18.Create a view high_salary_employees showing employees who earn more than 80,000.
create view high_salary_employees as (select * from employees where salary>80000);
select * from high_salary_employees;

-- 19.Query the view to list employees with more than 5 years experience.
create view V1 as (select * from employees where experience_years>5);
select * from V1;







