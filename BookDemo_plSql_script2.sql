--记录类型和游标
declare
 cursor emp_cursor
 is
 select empno,ename,job,sal,hiredate
 from scott.emp;
 v_emp emp_cursor%ROWTYPE;
 begin
 open emp_cursor;
 loop
 fetch emp_cursor
 into v_emp;
 exit when emp_cursor%notfound;
 DBMS_OUTPUT.PUT_LINE(' ' || v_emp.empno
                          || ' '
                          || v_emp.ename
                          || ' '
                          || v_emp.job
                          || ' '
                          || v_emp.sal
                          || ' '
                          || to_char(v_emp.hiredate,'YYYY-MM-DD')
                          );
end loop;
close emp_cursor;
end;

--过程与函数
--查看子程序
select * from sys.user_objects where object_type in ('FUNCTION','PROCEDURE');
--删除过程
drop procedure newdept;
--过程及其调用
select * from SCOTT.dept;
create or replace procedure newdept ( --添加部门
    p_deptno in SCOTT.dept.deptno%type,
    p_dname in SCOTT.dept.dname%type,
    p_loc in SCOTT.dept.loc%type
)
as
    v_deptcount number;
begin
    select count(*) into v_deptcount from SCOTT.dept
    where deptno = p_deptno;
    if v_deptcount > 0
    then
    raise_application_error(-20002,'出现了相同的员工记录');
    end if;
    insert into SCOTT.dept(deptno,dname,loc)
    values (p_deptno, p_dname, p_loc);
    commit;
end newdept;

SET SERVEROUTPUT ON;
--调用添加部门过程
DECLARE
v_param VARCHAR(20);
begin
    v_param := testFun('hello22 world!');
    dbms_output.put_line('v_param:' ||  v_param);
exception
    when others then
   dbms_output.put_line('产生了错误:' ||  sqlerrm);
end;

--定义函数
drop FUNCTION testFun;
CREATE or replace FUNCTION testFun(v_param VARCHAR)
return varchar
as
v_test varchar(20);
begin
v_test := v_param;
RETURN v_test;
end testFun;

--员工加薪过程
drop PROCEDURE addempsalary;
CREATE or REPLACE PROCEDURE addempsalary (p_ratio IN number,p_empno IN number)
as
begin
if p_ratio > 0
then
update scott.emp
set sal = sal * (1 + p_ratio)
where empno = p_empno;
end if;
dbms_output.put_line('加薪成功!');
end addempsalary;

drop FUNCTION getaddsalaryratiocase;
--获取调薪比例                          
CREATE or REPLACE FUNCTION getaddsalaryratiocase (p_job VARCHAR2)
RETURN number
as
v_result number(7,2);
BEGIN
case p_job
when 'CLERK'
then
v_result := 0.10;
when 'SALESMAN'
then
v_result := 0.12;
when 'MANAGER'
then
v_result := 0.15;
ELSE
dbms_output.put_line('员工不在加薪范围!');
end case;
return v_result;
end getaddsalaryratiocase;

--为所有员工加薪
DECLARE
cursor c_emp
is
SELECT
    *
FROM SCOTT.emp;
 v_emp c_emp%ROWTYPE;
 p_ratio number;
BEGIN
open c_emp;
loop
fetch c_emp into v_emp;
p_ratio := getaddsalaryratiocase(v_emp.job);
dbms_output.put_line('p_ratio=' ||  p_ratio);
addempsalary(p_ratio,v_emp.empno);
dbms_output.put_line(v_emp.ename || '加薪成功');
exit when c_emp%notfound;
end loop;
close c_emp;
exception
when no_data_found
then dbms_output.put_line('没有找到员工数据!');
end;

--触发器记录表
create table scott.raisesalarylog
(
    empno number(10) not null primary key,
    raisedDate date,
    originSal number(10,2),
    raisedSal number(10,2)
)
select * from scott.raisesalarylog;
select * from scott.emp;

--创建触发器
create or replace trigger scott.raisesalarychange
after update of sal
on scott.emp
for each row
declare
v_reccount int;
begin
select count(*) into v_reccount
from scott.raisesalarylog
where empno = :old.empno;
if v_reccount = 0
then
insert into scott.raisesalarylog values(:old.empno,sysdate,:old.sal,:new.sal);
else
update scott.raisesalarylog
set raiseddate = sysdate,
    originsal = :old.salary,
    raisedsal=:new.sal
    where empno = :old.empno;
    end if;
exception
when others
then dbms_output.put_line(sqlerrm);
end;









