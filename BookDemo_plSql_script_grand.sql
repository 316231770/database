--查看所有用户
select * from all_users;
--查看用户拥有的权限：
select * from dba_sys_privs where grantee='scott';
select * from all_tab_privs where grantee='scott';
--查看用户拥有的角色：
select * from dba_role_privs where grantee='system';
--查看角色
select * from dba_roles;
--查看登录用户权限
select * from session_privs;
--查看登录用户角色以及权限
select * from role_sys_privs;
--授权
grand dba to scott;