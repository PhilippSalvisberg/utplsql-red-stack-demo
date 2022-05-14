create table dept (
   deptno number(2, 0) not null  constraint dept_pk primary key,
   dname  varchar2(14) not null,
   loc    varchar2(13) not null
);
