create materialized view log on dept
   with rowid, primary key, sequence (dname)
   including new values for fast refresh;
