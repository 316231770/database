SELECT
    *
FROM
    scott.emp;
--打开输出缓存
SET SERVEROUTPUT ON;

--顺序结构
DECLARE
    v_sal1     NUMBER;
    v_sal2     NUMBER;
    v_sumsal   NUMBER;
BEGIN
    SELECT
        sal
    INTO v_sal1
    FROM
        scott.emp
    WHERE
        empno = &&empno1;

    SELECT
        sal
    INTO v_sal2
    FROM
        scott.emp
    WHERE
        empno = &&empno2;

    v_sumsal := v_sal1 + v_sal2;
    dbms_output.put_line('员工编号为'
                         || &&empno1
                         || '的薪资和员工编号为'
                         || &&empno2
                         || '的薪资合计为'
                         || v_sumsal);

END;

--打开输出缓存
SET SERVEROUTPUT ON;
--分支结构
declare
 c_manager constant number := 0.15;
 c_salesman constant number := 0.12;
 c_clerk constant number := 0.10;
 v_job varchar (100);
 emp_salary number;
 begin 
 select job
 into v_job
 from scott.emp
 where empno = &&empno1;
 dbms_output.put_line('v_job=' || v_job);
 --字符串=判断区分大小写
 if v_job = 'CLERK'
 then
 dbms_output.put_line('clerk');
 update scott.emp
 set sal = sal * (1 + c_clerk)
 where empno = &&empno1;
 
 elsif v_job = 'SALESMAN'
 then
 dbms_output.put_line('salesman');
 update scott.emp
 set sal = sal * (1 + c_salesman)
 where empno = &&empno1;
 
 elsif v_job = 'MANAGER'
 then
 dbms_output.put_line('manager');
 update scott.emp
 set sal = sal * (1 + c_manager)
 where empno = &&empno1;
 end if;
 
 select sal into emp_salary
 from scott.emp
 where empno = &&empno1;
 dbms_output.put_line('已经为员工 ' || &&empno1 ||' 成功加薪!');
 dbms_output.put_line('当前薪资为:' || emp_salary);
 exception
 when no_data_found
 then
 dbms_output.put_line('没有找到该员工数据');
 end;
 
 --循环结构
 declare
 v_count number (2) := 0;
 begin
 loop
 v_count := v_count +1;
 dbms_output.put_line('行' || v_count || ': Hello pl/sql!');
-- if v_count = 10
-- then
--    exit;
--    end if;
exit when v_count = 10;
end loop;
 dbms_output.put_line('循环已经退出了!');
 end;
 
 --continue
 declare
  x number := 0;
  BEGIN
  loop
  dbms_output.put_line('内部循环值: x= ' || to_char(x));
  x := x + 1;
--  if x < 3
--  then
--  continue;
--  end if;
  continue when x < 3;
  dbms_output.put_line('continue之后的值: x= ' || to_char(x));
  exit when x = 5;
  end loop;
  dbms_output.put_line('循环结束后的值: x= ' || to_char(x));
  end;

-- for-loop
DECLARE
v_total integer := 0;
begin
for i in REVERSE 1 .. 3
loop
v_total := v_total + 1;
dbms_output.put_line('循环计数器: ' || i);
end loop;
dbms_output.put_line('循环总计: ' || v_total);
end;


 --内部嵌套块
DECLARE
v_deptcount number (2);
v_deptno number (2) :=60 ;
v_deptname VARCHAR2 (12);
BEGIN
    --内部嵌套块
    <<查询员工名称快>>
    begin
    SELECT dname
    into v_deptname
    from SCOTT.dept
    where Deptno = v_deptno;
    DBMS_OUTPUT.PUT_LINE('您查询的部门名称为:' || v_deptname);
    end;
    --内部嵌套块
    <<更新员工记录块>>
    DECLARE
    v_loc VARCHAR2 (10) :='深圳罗湖';
    BEGIN
    --执行更新操作
    UPDATE SCOTT.dept
    set loc = v_loc
    where deptno = v_deptno;
    --写入屏幕信息
    DBMS_OUTPUT.PUT_LINE('在内部嵌套块中成功更新部门资料');
    end;
EXCEPTION
    when no_data_found
    then 
    <<插入员工记录块>>
    begin
    INSERT into SCOTT.dept
    VALUES (v_deptno,'财务部','深圳');
    DBMS_OUTPUT.PUT_LINE('在异常处理的嵌套块中成功插入部门资料!');
    EXCEPTION
    when others
    then 
    DBMS_OUTPUT.PUT_LINE(sqlerrm);
    end;
end;

 SELECT *
    from SCOTT.dept
    

