#!/bin/bash

echo "Stopping containers"
docker stop mrbs postgres mrbs_pgadmin
echo "Deleting containers"
docker container rm mrbs postgres mrbs_pgadmin