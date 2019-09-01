#!/bin/bash


PWD=$(pwd)

#Creamos una red para los dos containers
NETWORK_NAME=net_mrbs
docker network create \
  --driver=bridge \
  --subnet=175.10.0.0/16 \
  --ip-range=175.10.0.0/24 \
  --gateway=175.10.0.1 \
  $NETWORK_NAME


# --network: se lanza en la network previamente definida 
# -v: se hace un bind para que los datos estén en el host
# --name: le ponemos nombre al container (de esta manera todos los containers en una misma red tienen resolucion por dns)
# -d: se lanza en modo demonio
# --ip: Le damos una IP fija en la red (que es la misma que hemos puesto en config.inc.php)
docker run --network $NETWORK_NAME \
             -v "$PWD/postgresql/:/var/lib/postgresql/data/" \
             --name postgres \
             -d \
             -e "POSTGRES_PASSWORD=mrbs_password" \
             -e "PGDATA=/var/lib/postgresql/data/mrbsdata" \
             --ip "175.10.0.2" \
             mrbs_postgres

docker run -d --network net_mrbs -p "8081:80" \
-e "PGADMIN_DEFAULT_EMAIL=user@domain.com" \
--name mrbs_pgadmin \
-e "PGADMIN_DEFAULT_PASSWORD=password" dpage/pgadmin4

sleep 10

docker run --network $NETWORK_NAME \
         --name mrbs \
         -p "8080:80" \
         -d \
         mrbs_php


echo "================================="
echo ""
echo "MRBS: http://localhost:8080/mrbs"
echo "PGADMIN4: http://localhost:8081 , usuario: user@domain.com, password: password"
echo "> Añade un server con host: postgres y puerto: 5432, para ver la base de datos. "
