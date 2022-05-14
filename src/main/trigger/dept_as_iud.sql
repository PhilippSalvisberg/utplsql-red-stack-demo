create or replace trigger dept_as_iud after insert or update or delete on dept
begin
   etl.refresh_deptsal;
end;
/
