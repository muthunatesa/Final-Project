#!/bin/bash

set -e

DOCKER_IMAGE_NAME="muthunatesa/react-image"
DOCKER_TAG="latest"
CONTAINER_NAME="react-app" 


echo "Pulling the latest Docker image..."
docker pull ${DOCKER_IMAGE_NAME}:${DOCKER_TAG}

# Stop and remove the existing container if it exists
if [ "$(docker ps -q -f name=${CONTAINER_NAME})" ]; then
    echo "Stopping and removing existing container: ${CONTAINER_NAME}"
    docker stop ${CONTAINER_NAME}
    docker rm ${CONTAINER_NAME}
fi

echo "Running the new container..."
docker run -d --name ${CONTAINER_NAME} -p 80:80 ${DOCKER_IMAGE_NAME}:${DOCKER_TAG}

echo "Deployment successful: ${CONTAINER_NAME} is running."
