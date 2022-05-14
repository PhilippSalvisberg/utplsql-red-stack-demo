create or replace trigger emp_as_iud after insert or update or delete on emp
begin
   etl.refresh_deptsal;
end;
/
