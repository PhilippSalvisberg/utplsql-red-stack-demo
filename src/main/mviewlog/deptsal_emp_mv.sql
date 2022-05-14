create materialized view log on deptsal_emp_mv
   with rowid, sequence (deptno)
   including new values for fast refresh;
