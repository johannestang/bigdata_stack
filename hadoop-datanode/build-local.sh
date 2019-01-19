#!/bin/bash
REPO=johannestang
IMAGE=hadoop-datanode
VERSION=2.0.0-$(grep hadoop-base Dockerfile |  cut -d '-' -f 3)-java8
docker build -t ${REPO}/${IMAGE}:latest .
docker tag ${REPO}/${IMAGE}:latest ${REPO}/${IMAGE}:${VERSION}
