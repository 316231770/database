--�鿴�����û�
select * from all_users;
--�鿴�û�ӵ�е�Ȩ�ޣ�
select * from dba_sys_privs where grantee='scott';
select * from all_tab_privs where grantee='scott';
--�鿴�û�ӵ�еĽ�ɫ��
select * from dba_role_privs where grantee='system';
--�鿴��ɫ
select * from dba_roles;
--�鿴��¼�û�Ȩ��
select * from session_privs;
--�鿴��¼�û���ɫ�Լ�Ȩ��
select * from role_sys_privs;
--��Ȩ
grand dba to scott;