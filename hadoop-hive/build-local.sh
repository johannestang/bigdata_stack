#!/bin/bash
REPO=johannestang
IMAGE=hive
VERSION=$(grep HIVE_VERSION Dockerfile | head -n 1 | awk '{print $3}')-postgresql-metastore-s3
docker build -t ${REPO}/${IMAGE}:latest .
docker tag ${REPO}/${IMAGE}:latest ${REPO}/${IMAGE}:${VERSION}
