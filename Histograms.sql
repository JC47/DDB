begin
    dbms_stats.gather_table_stats(ownname => user,
                                  tabname => 'T',
                                  method_opt=>'for all columns size 4');
end;
/

create table t
as select rownum x
from dual
connect by rownum <= 11110

begin
    dbms_stats.gather_table_stats(ownname => user,
                                  tabname => 'T',
                                  cascade => true,
                                  method_opt => 'for columns size 1');
end;
/

begin
     dbms_stats.gather_table_stats(ownname => user,
                                   tabname => 'T',
                                   cascade => true);
end;


select table_name,column_name,NUM_DISTINCT,NUM_NULLS,NUM_BUCKETS, histogram from user_tab_col_statistics where table_name = 'T';
