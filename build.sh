#!/bin/bash

set -e

DOCKER_IMAGE_NAME="react-image"
DOCKER_TAG="latest"

# Build the Docker image
echo "Building Docker image..."
docker build -t ${DOCKER_IMAGE_NAME}:${DOCKER_TAG} .

echo "Docker image built successfully: ${DOCKER_IMAGE_NAME}:${DOCKER_TAG}"
