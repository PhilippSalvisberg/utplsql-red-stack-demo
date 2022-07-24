create or replace package test_etl is
   --%suite(test_etl - deptsal)
   --%rollback(manual)
   
   procedure cleanup;

   --%context(keep dept/emp "as is")

   --%test(existing data)
   procedure refresh_deptsal;

   --%endcontext
   
   --%context(modifying dept/emp)

   --%test(new dept without emp)
   --%beforetest(cleanup)
   procedure refresh_deptsal_new_dept_without_emp;

   --%test(new dept with emp)
   --%beforetest(cleanup)
   procedure refresh_deptsal_new_dept_with_emp;

   --%test(upd dept and emp)
   --%beforetest(cleanup)
   procedure refresh_deptsal_upd_dept_and_emp;

   --%test(del dept)
   --%beforetest(cleanup)
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
