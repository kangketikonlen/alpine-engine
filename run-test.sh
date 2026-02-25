#!/bin/bash

# Build the image
docker build -t alpine-engine:runtime-84 -f docker/runtime.Dockerfile .
docker build -t alpine-engine:build-84 -f docker/build-test.Dockerfile .

# Prune the image
docker image prune -f