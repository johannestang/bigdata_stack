#!/bin/sh

export CLASSPATH=$CLASSPATH:/opt/presto/presto-jdbc.jar

./build/env/bin/hue syncdb --noinput
./build/env/bin/hue migrate
./build/env/bin/supervisor
