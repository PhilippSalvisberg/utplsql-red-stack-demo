create table deptsal (
    deptno   number(2, 0)  not null constraint deptsal_pk primary key,
    dname    varchar2(14)  not null,
    sum_sal  number(10, 2) not null,
    num_emps number(4, 0)  not null,
    avg_sal  number(7, 2)  generated always as (
                              case
                                 when num_emps != 0 then
                                    round(sum_sal / num_emps, 2)
                                 else
                                    0
                              end
                           ) virtual
);
