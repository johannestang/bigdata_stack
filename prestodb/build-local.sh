#!/bin/bash
REPO=johannestang
IMAGE=prestodb
VERSION=$(grep PRESTO_VERSION Dockerfile | head -n 1 | awk '{print $2}' | cut -d '=' -f 2)
docker build -t ${REPO}/${IMAGE}:latest .
docker tag ${REPO}/${IMAGE}:latest ${REPO}/${IMAGE}:${VERSION}
