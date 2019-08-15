for i in `seq 0 100000`
do
  echo "${i}:"
  PGPASSWORD=password psql -U digdag -h 127.0.0.1 -c "insert into projects (id, site_id, name, created_at) values (${i} ,0, 'p${i}', now());"
  PGPASSWORD=password psql -U digdag -h 127.0.0.1 -c "insert into revisions (project_id, name, archive_type, archive_md5, created_at) values (${i}, '1c2e7c9f-aaba-49b1-9544-e0686dd3b0be', 'db', '\x2c95301a1883329e89a1c352bddc9d11', now())"
done



insert into projects (id, site_id, name, created_at)
select
  i,
  0,
  format('p%s', i),
  clock_timestamp()
from
  generate_series(0, 1000000) as i
;


insert into revisions (project_id, name, archive_type, archive_md5, created_at)
select
  i % 1000000,
  format('1c2e7c9f-aaba-49b1-9544-e0686dd%s', i),
  'db',
  '\x2c95301a1883329e89a1c352bddc9d11',
  clock_timestamp()
from
  generate_series(0, 3000000) as i
;
