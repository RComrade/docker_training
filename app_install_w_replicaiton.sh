#!/bin/bash

echo
echo Starting deploy...
echo
export FIRST_REPL_USER=${MARIADB_FIRST_REPLICATION_USER:-'repl'}
export FIRST_REPL_PASSWORD=${MARIADB_FIRST_REPLICATION_PASSWORD:-'password2'}
export FIRST_ROOT_PASSWORD=${MARIADB_FIRST_ROOT_PASS:-'password'}
export SECOND_ROOT_PASSWORD=${MARIADB_SECOND_ROOT_PASS:-'password'}
 
export FIRST_HOST=${MARIADB_FIRST_HOST:-'mariadb_master'}
export SECOND_HOST=${MARIADB_SECOND_HOST:-'mariadb_slave'}

 result=$(docker exec $FIRST_HOST mariadb -u root --password=$FIRST_ROOT_PASSWORD --execute="show master status;")
 log=$(echo $result|awk '{print $5}')
 position=$(echo $result|awk '{print $6}')
 
docker-compose up -d
echo
echo Waiting 30s for containers to be up and running...
echo Implementing mariadb master-slave replication...
sleep 30

echo
# Create user on master database.
 docker exec $FIRST_HOST \
   mariadb -u root --password=$FIRST_ROOT_PASSWORD \
   --execute="create user '$FIRST_REPL_USER'@'%' identified by '$FIRST_REPL_PASSWORD';\
   grant replication slave on *.* to '$FIRST_REPL_USER'@'%';\
   flush privileges;"
# Get the log position and name.
 result=$(docker exec $FIRST_HOST mariadb -u root --password=$FIRST_ROOT_PASSWORD --execute="show master status;")
 log=$(echo $result|awk '{print $5}')
 position=$(echo $result|awk '{print $6}')
# Connect slave to master.
 docker exec $SECOND_HOST \
   mariadb -u root --password=$SECOND_ROOT_PASSWORD \
   --execute="stop slave;\
   reset slave;\
   CHANGE MASTER TO MASTER_HOST='$FIRST_HOST', MASTER_USER='$FIRST_REPL_USER', \
   MASTER_PASSWORD='$FIRST_REPL_PASSWORD', MASTER_LOG_FILE='$log', MASTER_LOG_POS=$position;\
   start slave;\
   SHOW SLAVE STATUS\G;"

docker exec -it testovoe php artisan migrate:fresh --seed