#!/bin/bash
cd "${0%/*}"
docker-compose -f ../docker-compose.yml exec hue ./build/env/bin/hue syncdb --noinput
docker-compose -f ../docker-compose.yml exec hue ./build/env/bin/hue migrate
