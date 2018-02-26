#!/bin/bash

echo 'Starting world server...'

# check to see if the worldserver conf is specified.
# if not, copy in the default and change the ip address
# and the data dir for the vmaps and such
if [ ! -f "$CONF_DIR/worldserver.conf" ]; then
  echo 'Using default worldserver conf file'

  # copy installed via TrinityCore repo
  mkdir -p $CONF_DIR
  cp /usr/local/etc/worldserver.conf.dist $CONF_DIR/worldserver.conf
fi

# use the linked
sed -i "s/LoginDatabaseInfo.*$/LoginDatabaseInfo = \"127.0.0.1;3306;trinity;trinity;auth\"/" $CONF_DIR/worldserver.conf
sed -i "s/WorldDatabaseInfo.*$/WorldDatabaseInfo = \"127.0.0.1;3306;trinity;trinity;world\"/" $CONF_DIR/worldserver.conf
sed -i "s/CharacterDatabaseInfo.*$/CharacterDatabaseInfo = \"127.0.0.1;3306;trinity;trinity;characters\"/" $CONF_DIR/worldserver.conf
sed -i "s%DataDir.*$%DataDir = \"$MAPS_DIR\"%" $CONF_DIR/worldserver.conf

# RUN. IT.
/usr/local/bin/worldserver -c $CONF_DIR/worldserver.conf

echo 'Starting auth server...'

# check to see if the authserver conf is specified.
# if not, copy in the default and change the ip address
if [ ! -f "$CONF_DIR/authserver.conf" ]; then
  echo 'Using default auth conf file'

  # copy installed via TrinityCore repo
  mkdir -p $CONF_DIR
  cp /usr/local/etc/authserver.conf.dist $CONF_DIR/authserver.conf
fi

# update the config file with the linked db container address/port
sed -i "s/LoginDatabaseInfo.*$/LoginDatabaseInfo = \"127.0.0.1;3306;trinity;trinity;auth\"/" $CONF_DIR/authserver.conf

# RUN. IT.
/usr/local/bin/authserver -c $CONF_DIR/authserver.conf
