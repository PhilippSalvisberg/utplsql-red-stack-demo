create materialized view log on emp
   with rowid, primary key, sequence (deptno, sal)
   including new values for fast refresh;
