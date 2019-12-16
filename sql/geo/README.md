```sh
docker run -e POSTGRES_PASSWORD=mysecretpassword -p 5433:5432 mdillon/postgis

psql -p 5433 -h localhost -U postgres -c "CREATE DATABASE test"
psql -p 5433 -h localhost -U postgres -d test -f geo_index.sql

ruby generate_points.rb > populate.sql
psql -p 5433 -h localhost -U postgres -d test -f populate.sql
```

