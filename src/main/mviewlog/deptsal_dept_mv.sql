create materialized view log on deptsal_dept_mv
   with rowid, sequence (deptno, dname)
   including new values for fast refresh;
