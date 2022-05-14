create or replace package body test_etl is
   procedure refresh_deptsal is
      c_actual   sys_refcursor;
      c_expected sys_refcursor;
   begin
      -- act
      etl.refresh_deptsal;
      
      -- assert;
      open c_actual for select * from deptsal;
      open c_expected for
         select d.deptno,
                d.dname,
                nvl(sum(e.sal), 0) as sum_sal,
                nvl(count(e.empno), 0) as num_emps,
                nvl(trunc(avg(e.sal), 2), 0) as avg_sal
           from dept d
           left join emp e
             on e.deptno = d.deptno
          group by d.deptno, d.dname;
      ut.expect(c_actual).to_equal(c_expected).join_by('DEPTNO');
   end refresh_deptsal;
end test_etl;
/
