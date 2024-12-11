#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Define variables
DOCKER_IMAGE_NAME="muthunatesa/react-image" # Replace with your Docker Hub username and app name
DOCKER_TAG="latest" # You can change this to a specific version if needed
CONTAINER_NAME="react-app" # Name of the running container

# Pull the latest image from Docker Hub
echo "Pulling the latest Docker image..."
docker pull ${DOCKER_IMAGE_NAME}:${DOCKER_TAG}

# Stop and remove the existing container if it exists
if [ "$(docker ps -q -f name=${CONTAINER_NAME})" ]; then
    echo "Stopping and removing existing container: ${CONTAINER_NAME}"
    docker stop ${CONTAINER_NAME}
    docker rm ${CONTAINER_NAME}
fi

# Run the new container
echo "Running the new container..."
docker run -d --name ${CONTAINER_NAME} -p 80:80 ${DOCKER_IMAGE_NAME}:${DOCKER_TAG}

echo "Deployment successful: ${CONTAINER_NAME} is running."
