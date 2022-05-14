-- connected as SYS
create user redstack identified by redstack
   default tablespace users
   temporary tablespace temp
   quota 10m on users;

grant connect, resource, create view, create procedure, create materialized view to redstack;
