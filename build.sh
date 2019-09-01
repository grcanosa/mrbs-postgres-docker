#!/bin/bash

docker build -t mrbs_postgres -f postgres.Dockerfile .

docker build -t mrbs_php -f php.Dockerfile .