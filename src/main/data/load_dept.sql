insert into dept (deptno, dname, loc) values (10, 'ACCOUNTING', 'NEW YORK');
insert into dept (deptno, dname, loc) values (20, 'RESEARCH', 'DALLAS');
insert into dept (deptno, dname, loc) values (30, 'SALES', 'CHICAGO');
insert into dept (deptno, dname, loc) values (40, 'OPERATIONS', 'BOSTON');
commit;

begin
   dbms_stats.gather_table_stats(ownname => user, tabname => 'DEPT');
end;
/
