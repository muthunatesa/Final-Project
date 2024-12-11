#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Define variables
DOCKER_IMAGE_NAME="muthunatesa/react-image" # Replace with your Docker Hub username and app name
DOCKER_TAG="latest" # You can change this to a specific version if needed

# Build the Docker image
echo "Building Docker image..."
docker build -t ${DOCKER_IMAGE_NAME}:${DOCKER_TAG} .

# Optionally, you can also build using docker-compose
# Uncomment the following line if you want to use docker-compose
#docker-compose build ${DOCKER_IMAGE_NAME}:${DOCKER_TAG}

echo "Docker image built successfully: ${DOCKER_IMAGE_NAME}:${DOCKER_TAG}"
