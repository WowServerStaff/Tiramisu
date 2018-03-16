#!/bin/bash

TCDB_FULL=https://github.com/TrinityCore/TrinityCore/releases/download/TDB335.63/TDB_full_335.63_2017_04_18.7z
TCDB_FOLDER=TDB_full_335.63_2017_04_18

cd sql/

mysql -u root < create_mysql.sql

wget $TCDB_FULL

if [$? -eq 0]; then
  7z x *.7z
  rm -rf TDB_full_*.7z
else
  echo "### TDB archive not found on the Trinity Github ###"
  echo "Using local archive..."
fi

mv $TCDB_FOLDER/ tdb/

# populate db
cat tdb/TDB_full_world_*.sql | mysql -u root -D world

# update realmlist
cat sql/update_realmlist.sql | mysql -u root -D auth
