-- connected as REDSTACK
declare
   procedure exec_sql(in_stmt in varchar2) is
      e_table_or_view_does_not_exist exception;
      e_object_does_not_exist        exception;
      pragma exception_init(e_table_or_view_does_not_exist, -942);
      pragma exception_init(e_object_does_not_exist, -4043);
   begin
      execute immediate sys.dbms_assert.noop(in_stmt);
   exception
      when e_table_or_view_does_not_exist or e_object_does_not_exist then
         -- ignore this exception
         null;
   end exec_sql;
begin
   -- drop objects used for previous DIY solution
   exec_sql('drop package etl');
   exec_sql('drop table deptsal purge');
   -- drop other objects
   exec_sql('drop table emp cascade constraints purge');
   exec_sql('drop table dept purge');
end;
/

@src/main/table/dept.sql
@src/main/table/emp.sql
@src/main/data/load_dept.sql
@src/main/data/load_emp.sql
@src/main/view/deptsal.sql
@src/test/package/test_etl.pks
@src/test/package/test_etl.pkb

set serveroutput on size unlimited;
exec ut.run;
