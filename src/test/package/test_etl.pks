create or replace package test_etl is
   --%suite
   --%rollback(manual)
   
   --%beforeeach
   --%aftereach
   procedure cleanup;

   --%context(refresh)

   --%test(existing data)
   procedure refresh_deptsal;

   --%test(new dept without emp)
   procedure refresh_deptsal_new_dept_without_emp;

   --%test(new dept with emp)
   procedure refresh_deptsal_new_dept_with_emp;

   --%test(upd dept and emp)
   procedure refresh_deptsal_upd_dept_and_emp;

   --%test(del dept)
   procedure refresh_deptsal_del_dept;
   
   --%endcontext
   
   --%context(explain mview regarding fast refresh)
   
   --%test(capabilities of deptsal_emp_mv)
   procedure capabilities_of_deptsal_emp_mv;
   
   --%test(capabilities of deptsal_dept_mv)
   procedure capabilities_of_deptsal_dept_mv;
   
   --%test(capabilities of deptsal)
   procedure capabilities_of_deptsal;

   --%endcontext
end test_etl;
/
