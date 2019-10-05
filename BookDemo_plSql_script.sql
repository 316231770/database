SELECT
    *
FROM
    scott.emp;
--���������
SET SERVEROUTPUT ON;

--˳��ṹ
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
    dbms_output.put_line('Ա�����Ϊ'
                         || &&empno1
                         || '��н�ʺ�Ա�����Ϊ'
                         || &&empno2
                         || '��н�ʺϼ�Ϊ'
                         || v_sumsal);

END;

--���������
SET SERVEROUTPUT ON;
--��֧�ṹ
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
 --�ַ���=�ж����ִ�Сд
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
 dbms_output.put_line('�Ѿ�ΪԱ�� ' || &&empno1 ||' �ɹ���н!');
 dbms_output.put_line('��ǰн��Ϊ:' || emp_salary);
 exception
 when no_data_found
 then
 dbms_output.put_line('û���ҵ���Ա������');
 end;
 
 --ѭ���ṹ
 declare
 v_count number (2) := 0;
 begin
 loop
 v_count := v_count +1;
 dbms_output.put_line('��' || v_count || ': Hello pl/sql!');
-- if v_count = 10
-- then
--    exit;
--    end if;
exit when v_count = 10;
end loop;
 dbms_output.put_line('ѭ���Ѿ��˳���!');
 end;
 
 --continue
 declare
  x number := 0;
  BEGIN
  loop
  dbms_output.put_line('�ڲ�ѭ��ֵ: x= ' || to_char(x));
  x := x + 1;
--  if x < 3
--  then
--  continue;
--  end if;
  continue when x < 3;
  dbms_output.put_line('continue֮���ֵ: x= ' || to_char(x));
  exit when x = 5;
  end loop;
  dbms_output.put_line('ѭ���������ֵ: x= ' || to_char(x));
  end;

-- for-loop
DECLARE
v_total integer := 0;
begin
for i in REVERSE 1 .. 3
loop
v_total := v_total + 1;
dbms_output.put_line('ѭ��������: ' || i);
end loop;
dbms_output.put_line('ѭ���ܼ�: ' || v_total);
end;


 --�ڲ�Ƕ�׿�
DECLARE
v_deptcount number (2);
v_deptno number (2) :=60 ;
v_deptname VARCHAR2 (12);
BEGIN
    --�ڲ�Ƕ�׿�
    <<��ѯԱ�����ƿ�>>
    begin
    SELECT dname
    into v_deptname
    from SCOTT.dept
    where Deptno = v_deptno;
    DBMS_OUTPUT.PUT_LINE('����ѯ�Ĳ�������Ϊ:' || v_deptname);
    end;
    --�ڲ�Ƕ�׿�
    <<����Ա����¼��>>
    DECLARE
    v_loc VARCHAR2 (10) :='�����޺�';
    BEGIN
    --ִ�и��²���
    UPDATE SCOTT.dept
    set loc = v_loc
    where deptno = v_deptno;
    --д����Ļ��Ϣ
    DBMS_OUTPUT.PUT_LINE('���ڲ�Ƕ�׿��гɹ����²�������');
    end;
EXCEPTION
    when no_data_found
    then 
    <<����Ա����¼��>>
    begin
    INSERT into SCOTT.dept
    VALUES (v_deptno,'����','����');
    DBMS_OUTPUT.PUT_LINE('���쳣�����Ƕ�׿��гɹ����벿������!');
    EXCEPTION
    when others
    then 
    DBMS_OUTPUT.PUT_LINE(sqlerrm);
    end;
end;

 SELECT *
    from SCOTT.dept
    

