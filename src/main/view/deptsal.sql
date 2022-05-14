create or replace view deptsal as
   select d.deptno,
          d.dname,
          coalesce(sum(e.sal), 0) as sum_sal,
          coalesce(count(e.empno), 0) as num_emps,
          coalesce(round(avg(e.sal), 2), 0) as avg_sal
     from dept d
     left join emp e
       on e.deptno = d.deptno
    group by d.deptno, d.dname;
