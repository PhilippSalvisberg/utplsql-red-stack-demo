create materialized view deptsal_dept_mv refresh fast on commit as
   select d.deptno,
          e.deptno as emp_deptno,
          d.dname,
          d.rowid as dept_rowid,   -- required for fast refresh after any DML
          e.rowid as emp_rowid     -- required for fast refresh after any DML
     from dept d, deptsal_emp_mv e
    where d.deptno = e.deptno (+);
