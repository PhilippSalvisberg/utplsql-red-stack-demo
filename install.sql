-- connected as REDSTACK
declare
   procedure exec_sql(in_stmt in varchar2) is
      e_table_or_view_does_not_exist exception;
      pragma exception_init(e_table_or_view_does_not_exist, -942);
   begin
      execute immediate sys.dbms_assert.noop(in_stmt);
   exception
      when e_table_or_view_does_not_exist then
         -- ignore this exception
         null;
   end exec_sql;
begin
   exec_sql('drop table emp cascade constraints purge');
   exec_sql('drop table dept purge');
   exec_sql('drop table deptsal purge');
end;
/

@src/main/table/dept.sql
@src/main/table/emp.sql
@src/main/data/load_dept.sql
@src/main/data/load_emp.sql
@src/main/table/deptsal.sql
@src/main/package/etl.pks
@src/main/package/etl.pkb
@src/test/package/test_etl.pks

set serveroutput on size unlimited;
exec ut.run;
