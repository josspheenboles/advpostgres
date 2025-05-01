-- -- -- select * from employee;
-- -- -- ---join employee & dept
-- -- -- select * 
-- -- -- from employee inner join department 
-- -- -- on employee.did=department.id
-- -- -- --
-- -- -- create view getempdptdata
-- -- -- as
-- -- -- 	select employee.id as eid,department.id as depid,
-- -- -- 	employee.name as ename,department.name as dname
-- -- -- 	from employee inner join department 
-- -- -- 	on employee.did=department.id
-- -- -- ;

-- -- -- select * from getempdptdata;
-- -- -- select *
-- -- -- from getempdptdata inner join
-- -- -- empret
-- -- -- on 
-- -- -- -----------------
-- -- -- --overloading
-- -- -- create function display11 ( idn int)
-- -- -- RETURNS integer AS $$
-- -- -- begin
-- -- -- 	RETURN     idn;
-- -- -- end;
-- -- -- $$ LANGUAGE plpgsql;

-- -- -- --overloading
-- -- -- create function display11 ( idn int,name varchar(50) )
-- -- -- RETURNS integer AS $$
-- -- -- begin
-- -- -- 	RETURN     idn;
-- -- -- end;
-- -- -- $$ LANGUAGE plpgsql;
-- -- -- select 'hi'
-- -- -- select display11(1000)
-- -- -- select display11(1000,'al')

-- -- -- ------

-- -- -- create function displayintout (name varchar(50),
-- -- -- out ename varchar(50) )
-- -- -- RETURNS integer AS $$
-- -- -- begin
-- -- -- 	ename='ALI';
-- -- -- 	RETURN     idn;
-- -- -- end;
-- -- -- $$ LANGUAGE plpgsql;
-- -- -- ---
-- -- -- create function displayintout (inout name varchar(50),
-- -- --  )
-- -- -- -- RETURNS integer AS $$
-- -- -- begin
-- -- -- 	name=upper(name);
-- -- -- 	-- RETURN     idn;
-- -- -- end;
-- -- -- $$ LANGUAGE plpgsql;

-- -- -- select displayintout('ali');
-- -- -- ----
-- -- -- --fiunction reyurn table
-- -- -- --custom compsotir type
-- -- -- create type empinfo as (num int ,name varchar(50));
-- -- -- create function xxx ( )
-- -- -- RETURNS empinfo AS $$
-- -- -- begin
-- -- -- 	RETURN query select id,name from employee;
-- -- -- end;
-- -- -- $$ LANGUAGE plpgsql;

-- -- -- create function xxx ( )
-- -- -- RETURNS table (id int,name varchar(50)) AS $$
-- -- -- begin
-- -- -- 	RETURN query select id,name from employee;
-- -- -- end;
-- -- -- $$ LANGUAGE plpgsql;

-- -- -- -----------
-- -- create function iseven (in n int ) as $$
-- -- begin
-- -- if n /% 2 ==0 then 
-- -- 	select 'eve';
-- -- else
-- -- 	select 'False';
-- -- endif;

-- -- end;
-- -- $$ LANGUAGE plpgsql;




-- -- create table logs(id serial primary key,opertion varchar(50));
-- create function insertintologs(ide int)
-- returns int as $$
-- begin
-- insert into logs (opertion) values('insert new row in employee %',ide);
-- return 1;
-- end;
-- $$ LANGUAGE plpgsql;

-- create TRIGGER logemptable before insert
-- on employee FOR EACH ROW
-- EXECUTE PROCEDURE insertintologs(select id from NEW limit 1);
--function save audit data
CREATE function insert_log_data()
RETURNS TRIGGER as $$
BEGIN
	--body
	--TG_OP
	if TG_OP ='INSERT' then
		insert into logs(opertion) values('you inserted employee');
	elsif TG_OP ='UPDATE' then
		insert into logs(opertion) values(
		concat('you updated employee',NEW.id));
	else
		insert into logs(opertion) values('you delete employee');
	End if;
	return NEW;
end;
$$language plpgsql;
--create trigger
create TRIGGER emp_Logs
after insert or update or delete
on employee
for each row
execute  function insert_log_data();
--insert_log_data function
--emp_Logs
insert into employee (name,salary) values ('ab ayamn',10000);
select * from employee;
update employee set salary=12000
where id =12
delete from employee where id=13
select * from logs;


drop trigger emp_retired;
drop function insert_ret_employee;

CREATE or replace function insert_ret_employee()
RETURNS TRIGGER as $$
BEGIN
	--body
		--trigger delete
		--insert empret
		insert into empret  values (OLD.ID,OLD.name);
	return OLD;
end;
$$language plpgsql;

--create trigger
create TRIGGER emp_retired
before  delete
on employee
for each row
execute  function insert_ret_employee();

drop table empret;
create table empret
(id int ,name varchar(50));
select * from employee;
select * from empret;

delete from employee where id=9;
-----------