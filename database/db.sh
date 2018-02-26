#!/bin/bash

TCDB_FULL=https://github.com/TrinityCore/TrinityCore/releases/download/TDB335.63/TDB_full_335.63_2017_04_18.7z
TCDB_FOLDER=TDB_full_335.63_2017_04_18

cd sql/

mysql -u root < create_mysql.sql

wget $TCDB_FULL
7z x *.7z

mv $TCDB_FOLDER/ tdb/

rm -rf TDB_full_*.7z
