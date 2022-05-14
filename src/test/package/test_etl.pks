create or replace package test_etl is
   --%suite

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
end test_etl;
/
