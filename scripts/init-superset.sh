#!/bin/bash
cd "${0%/*}"
docker-compose -f ../superset/docker-compose.yml exec superset superset-init
docker cp add-presto.yml $(docker-compose -f ../superset/docker-compose.yml ps -q superset):/tmp
docker-compose -f ../superset/docker-compose.yml exec superset superset import_datasources -p /tmp/add-presto.yml
