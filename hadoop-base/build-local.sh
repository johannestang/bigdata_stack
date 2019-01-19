#!/bin/bash
REPO=johannestang
IMAGE=hadoop-base
VERSION=2.0.0-hadoop$(grep HADOOP_VERSION Dockerfile | head -n 1 | awk '{print $3}')-java8
docker build -t ${REPO}/${IMAGE}:latest .
docker tag ${REPO}/${IMAGE}:latest ${REPO}/${IMAGE}:${VERSION}
