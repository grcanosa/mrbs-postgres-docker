#!/bin/sh

createdb -E UTF8 -T template0 mrbs
psql -a -f /docker-entrypoint-initdb.d/tables.pg.sql mrbs