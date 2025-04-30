-- select * from employee;
-- select * from department;

-- --- joins
-- --get employee data including department name
-- select *
-- from employee inner join department
-- on employee.did=department.id

-- select *
-- from employee,department
-- where employee.did=department.id

-- --get all employee and its dept name even not joined to dept.

-- select *
-- from department right join employee
-- on employee.did=department.id
-- select *
-- from department left join employee
-- on employee.did=department.id


-- select *
-- from employee left join department
-- on employee.did=department.id

-- ---get all employee data and its dept name 
-- --,get all dept data and its employee
-- select *
-- from employee left join department
-- on employee.did=department.id
-- union
-- select *
-- from employee right join department
-- on employee.did=department.id
-- ----full join
-- select *
-- from employee full join department
-- on employee.did=department.id


-- -- select *
-- -- from table1 inner join table2
-- -- on tabel1.fk==table2.pk
-- -- inner join tabl3
-- -- on tabel.fk == table3.fk
-- -- select *
-- -- from table1 ,table2,table3
-- -- where table1.fk=table2.pk
-- -- and table2.fk=table3.pk
-- ---views --->virtual table
-- --security?
-- --simplicity query
-- --simple view
-- create view get_emp_data_with_out_salary
-- as 
-- 	select id,name,gender ---data
-- 	from employee
-- ;
-- ---------------------
-- --simple view (regular)
-- --updatable (insert,update,delete)
-- --condition
-- 	--single table
-- 	--not contain distinct,group by,having,aggregation...
-- 	--column allow null
	
-- insert into  employee (name,salary) values('ahmed',10000);
-- select * from get_emp_data_with_out_salary;
-- select * from employee;
-- --update,insert,delete
-- insert into  get_emp_data_with_out_salary (name) 
-- values('amira');



-- select salary from employee;
-- ------------------
-- -- get employee name & dept name
-- drop view get_emp_dept;
-- create view get_emp_dept
-- as
-- select employee.name as ename,department.name as dname
-- from employee join department
-- on employee.did= department.id;


-- select dname from get_emp_dept ;
-- insert into  employee (name) 
-- values('sayed');


-- select * from get_emp_data_with_out_salary;
-- alter view get_emp_data_with_out_salary
-- add column test char(1);
-- --materialized view 
-- --run view store physical
-- --MATERIALIZED join group distinct
-- create MATERIALIZED view view1
-- as
-- --99.9 query complex
-- select name,id from employee;

-- REFRESH MATERIALIZED view view1;--drop view,create
-- select * from view1;
-- insert into view1 (name) values('ddfdf');

-- create or replace view viewname 
-- as 
-- newquery;
-- select * 
-- from information_schema.views
create index testhasindex
on employee using gis(name)

--function
create or replace  function displayhi22 (namee int)
returns str as $$
declare 
name constant  not null datatype=value;
-- countn integer=1;
begin
	-- countn=countn+10;
	name=(select name from employee where id=1);
	return concat('hi ',namee);
end ;
$$LANGUAGE plpgpythn;

select displayhi22('mark');
