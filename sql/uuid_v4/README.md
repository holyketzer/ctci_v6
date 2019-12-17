```sh
docker run -e POSTGRES_PASSWORD=password -p 5433:5432 postgres:12

psql -p 5433 -h localhost -U postgres -c "CREATE DATABASE test"
psql -p 5433 -h localhost -U postgres -d test -f create.sql

ruby generate_items.rb > populate.sql
psql -p 5433 -h localhost -U postgres -d test -f populate.sql

# Inspect
psql -p 5433 -h localhost -U postgres -d test
```

