#!/bin/bash

# build
docker build -t trinitycore ./server/

# database script
./database/db.sh

# run
docker run --net="host" --name tiramisu-auth -ti -d -p 3724:3724 trinitycore
docker run --net="host" --name tiramisu-world -i -d -p 8085:8085 --volume $PWD/server/data/maps:/opt/trinitycore/maps trinitycore
