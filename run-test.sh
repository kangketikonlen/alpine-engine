#!/bin/bash

# Build the image
docker build -t alpine-engine:runtime -f docker/runtime.Dockerfile .
docker build -t alpine-engine:build -f docker/build-test.Dockerfile .

# Prune the image
docker image prune -f