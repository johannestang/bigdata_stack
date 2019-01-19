#!/bin/bash
cd "${0%/*}"

PRESTO_VERSION=0.215
if [ ! -e presto-cli.jar ]; then
    wget https://repo1.maven.org/maven2/com/facebook/presto/presto-cli/$PRESTO_VERSION/presto-cli-$PRESTO_VERSION-executable.jar -O presto-cli.jar
fi 
java -jar presto-cli.jar --server localhost:8080 --catalog hive --schema default
