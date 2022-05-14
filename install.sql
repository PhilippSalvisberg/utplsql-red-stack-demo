-- connected as REDSTACK
declare
   procedure exec_sql(in_stmt in varchar2) is
      e_table_or_view_does_not_exist exception;
      e_object_does_not_exist        exception;
      e_mview_does_not_exist         exception;
      e_use_drop_mview               exception;
      pragma exception_init(e_table_or_view_does_not_exist, -942);
      pragma exception_init(e_object_does_not_exist, -4043);
      pragma exception_init(e_mview_does_not_exist, -12003);
      pragma exception_init(e_use_drop_mview, -12083);
   begin
      execute immediate sys.dbms_assert.noop(in_stmt);
   exception
      when e_table_or_view_does_not_exist or e_object_does_not_exist
         or e_mview_does_not_exist or e_use_drop_mview
      then
         -- ignore this exception
         null;
   end exec_sql;
begin
   -- drop objects used for previous DIY solution
   exec_sql('drop package etl');
   exec_sql('drop table deptsal purge');
   -- drop objects used for previous VIEW solution
   exec_sql('drop view deptsal');
   -- drop other objects
   exec_sql('drop table emp cascade constraints purge');
   exec_sql('drop table dept purge');
   exec_sql('drop materialized view deptsal');
   exec_sql('drop materialized view deptsal_dept_mv');
   exec_sql('drop materialized view deptsal_emp_mv');
   exec_sql('drop table mv_capabilities_table purge');
end;
/

@src/main/table/dept.sql
@src/main/table/emp.sql
@src/main/data/load_dept.sql
@src/main/data/load_emp.sql
@src/main/mviewlog/emp.sql
@src/main/mviewlog/dept.sql
@src/main/mview/deptsal_emp_mv.sql
@src/main/mviewlog/deptsal_emp_mv.sql
@src/main/mview/deptsal_dept_mv.sql
@src/main/mviewlog/deptsal_dept_mv.sql
@src/main/mview/deptsal.sql
@src/test/table/utlxmv.sql
@src/test/package/test_etl.pks
@src/test/package/test_etl.pkb

set serveroutput on size unlimited;
exec ut.run;
