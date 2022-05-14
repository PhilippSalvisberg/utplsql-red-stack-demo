create materialized view deptsal refresh fast on commit as
   select deptno,
          dname,
          sum_sal,
          num_emps,
          round(avg_sal, 2) as avg_sal,
          'EMP' as row_source,   -- required for fast refresh after insert
          rowid as row_id        -- required for fast refresh after any DML
     from deptsal_emp_mv
   union all
   select deptno,
          dname,
          0,
          0,
          0,
          'DEPT' as row_source,  -- required for fast refresh after insert
          rowid as row_id        -- required for fast refresh after any DML
     from deptsal_dept_mv
    where emp_deptno is null;
