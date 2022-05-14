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
                nvl(round(avg(e.sal), 2), 0) as avg_sal
           from dept d
           left join emp e
             on e.deptno = d.deptno
          group by d.deptno, d.dname;
      ut.expect(c_actual).to_equal(c_expected).join_by('DEPTNO');
   end refresh_deptsal;

   procedure refresh_deptsal_new_dept_without_emp is
      c_actual   sys_refcursor;
      c_expected sys_refcursor;
   begin
      -- act
      insert into dept (deptno, dname, loc)
      values (-10, 'utPLSQL', 'Winterthur');
      etl.refresh_deptsal;
      
      -- assert
      open c_actual for select * from deptsal where deptno = -10;
      open c_expected for
         select -10 as deptno,
                'utPLSQL' as dname,
                0 as sum_sal,
                0 as num_emps,
                0 as avg_sal
           from dual;
      ut.expect(c_actual).to_equal(c_expected).join_by('DEPTNO');
   end refresh_deptsal_new_dept_without_emp;

   procedure refresh_deptsal_new_dept_with_emp is
      c_actual   sys_refcursor;
      c_expected sys_refcursor;
   begin
      -- act
      insert into dept (deptno, dname, loc)
      values (-10, 'utPLSQL', 'Winterthur');
      insert into emp (empno, ename, job, hiredate, sal, deptno)
      values (-1, 'Jacek', 'Developer', trunc(sysdate), 4700, -10);
      insert into emp (empno, ename, job, hiredate, sal, deptno)
      values (-2, 'Sam', 'Developer', trunc(sysdate), 4300, -10);
      etl.refresh_deptsal;
      
      -- assert
      open c_actual for select * from deptsal where deptno = -10;
      open c_expected for
         select -10 as deptno,
                'utPLSQL' as dname,
                9000 as sum_sal,
                2 as num_emps,
                4500 as avg_sal
           from dual;
      ut.expect(c_actual).to_equal(c_expected).join_by('DEPTNO');
   end refresh_deptsal_new_dept_with_emp;

   procedure refresh_deptsal_upd_dept_and_emp is
      c_actual   sys_refcursor;
      c_expected sys_refcursor;
   begin
      -- arrange
      insert into dept (deptno, dname, loc)
      values (-10, 'utPLSQL', 'Winterthur');
      insert into emp (empno, ename, job, hiredate, sal, deptno)
      values (-1, 'Jacek', 'Developer', trunc(sysdate), 4700, -10);
      insert into emp (empno, ename, job, hiredate, sal, deptno)
      values (-2, 'Sam', 'Developer', trunc(sysdate), 4300, -10);
      etl.refresh_deptsal;
      
      -- act
      update dept set dname = 'Testing' where deptno = -10;
      update emp set sal = 5000 where empno = -2;
      etl.refresh_deptsal;
      
      -- assert
      open c_actual for select * from deptsal where deptno = -10;
      open c_expected for
         select -10 as deptno,
                'Testing' as dname,
                9700 as sum_sal,
                2 as num_emps,
                4850 as avg_sal
           from dual;
      ut.expect(c_actual).to_equal(c_expected).join_by('DEPTNO');
   end refresh_deptsal_upd_dept_and_emp;

   procedure refresh_deptsal_del_dept is
      c_actual sys_refcursor;
   begin
      -- arrange
      insert into dept (deptno, dname, loc)
      values (-10, 'utPLSQL', 'Winterthur');
      etl.refresh_deptsal;

      -- act
      delete from dept where deptno = -10;
      etl.refresh_deptsal;

      -- assert
      open c_actual for select * from deptsal where deptno = -10;
      ut.expect(c_actual).to_have_count(0);
   end refresh_deptsal_del_dept;
end test_etl;
/
