#!/bin/bash
cd "${0%/*}"
docker run -it --rm --network="bigdata_stack_default" --env-file ../config/hadoop-hive.env -v /:/host johannestang/hadoop-base /bin/bash

