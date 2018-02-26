#!/bin/bash

# build
docker build -t trinitycore ./server/

# use the database script before this operation (if first time)
# populate db
cat database/tdb/TDB_full_world_*.sql | mysql -u root -D world

# update realmlist
cat database/sql/update_realmlist.sql | mysql -u root -D auth

# run
docker run --net="host" --name tiramisu-auth -ti -d -p 3724:3724 trinitycore
docker run --net="host" --name tiramisu-world -i -d -p 8085:8085 --volume $PWD/server/data/maps:/opt/trinitycore/maps trinitycore
