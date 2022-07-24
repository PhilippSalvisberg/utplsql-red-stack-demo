create materialized view deptsal_mv refresh fast on commit as
   select d.deptno,
          d.dname,
          sum(e.sal) as sum_sal,
          count(e.empno) as num_emps,
          avg(e.sal) as avg_sal,
          count(e.sal) as num_sal,   -- required for fast refresh after insert
          count(*) as num_rows       -- required for fast refresh after any DML
     from dept d
     join emp e                      -- ANSI-92 join works with fast refresh!
       on e.deptno = d.deptno
    group by d.deptno, d.dname;
