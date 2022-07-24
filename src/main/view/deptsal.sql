create or replace view deptsal as
   select d.deptno,
          d.dname,
          nvl(m.sum_sal, 0) as sum_sal,
          nvl(m.num_emps, 0) as num_emps,
          nvl(round(m.avg_sal, 2), 0) as avg_sal
     from dept d
     left join deptsal_mv m
       on m.deptno = d.deptno;
