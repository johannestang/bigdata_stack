#!/bin/bash
cd "${0%/*}"
docker-compose -f ../hue/docker-compose.yml exec hue ./build/env/bin/hue syncdb --noinput
docker-compose -f ../hue/docker-compose.yml exec hue ./build/env/bin/hue migrate
