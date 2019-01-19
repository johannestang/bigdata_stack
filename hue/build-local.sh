#!/bin/bash
REPO=johannestang
IMAGE=hue
HUE_VERSION=$(grep HUE_VERSION Dockerfile | head -n 1 | awk '{print $2}' | cut -d '=' -f 2)
PRESTO_VERSION=$(grep PRESTO_VERSION Dockerfile | head -n 1 | awk '{print $2}' | cut -d '=' -f 2)
VERSION=${HUE_VERSION}-presto${PRESTO_VERSION}
docker build -t ${REPO}/${IMAGE}:latest .
docker tag ${REPO}/${IMAGE}:latest ${REPO}/${IMAGE}:${VERSION}
