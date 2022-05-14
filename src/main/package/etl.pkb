create or replace package body etl is
   procedure refresh_deptsal is
   begin
      merge into deptsal t
      using (
               select d.deptno,
                      d.dname,
                      coalesce(sum(e.sal), 0) as sum_sal,
                      coalesce(count(e.empno), 0) as num_emps,
                      0 as delete_flag
                 from dept d
                 left join emp e
                   on e.deptno = d.deptno
                group by d.deptno, d.dname
               union all
               select deptno,
                      dname,
                      sum_sal,
                      num_emps,
                      1 as delete_flag
                 from deptsal
                where not exists (
                         select 1
                           from dept
                          where dept.deptno = deptsal.deptno
                      )
            ) s
         on (s.deptno = t.deptno)
       when matched then
            update
               set t.dname = s.dname,
                   t.sum_sal = s.sum_sal,
                   t.num_emps = s.num_emps
            delete
             where delete_flag = 1
       when not matched then
            insert (deptno, dname, sum_sal, num_emps)
            values (s.deptno, s.dname, s.sum_sal, s.num_emps);
   end refresh_deptsal;
end etl;
/
