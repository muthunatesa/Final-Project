#!/bin/bash

set -e


DOCKER_IMAGE_NAME="react-image"
DOCKER_TAG="latest"
CONTAINER_NAME="react-app"
BRANCH_NAME=$(git rev-parse --abbrev-ref HEAD)

echo "Branch name is: ${BRANCH_NAME}"

# Determine which repository (dev or prod) to pull the image from
if [ "$BRANCH_NAME" == "dev" ]; then
    REPOSITORY="muthunatesa/dev"
elif [ "$BRANCH_NAME" == "master" ]; then
    REPOSITORY="muthunatesa/prod"
else
    echo "Branch ${BRANCH_NAME} does not match dev or master, skipping deployment."
    exit 0
fi

echo "Pulling the latest Docker image from ${REPOSITORY}:${DOCKER_TAG}..."

# Pull the Docker image
docker pull ${REPOSITORY}:${DOCKER_TAG}

# Stop and remove the existing container
if [ "$(docker ps -q -f name=${CONTAINER_NAME})" ]; then
    echo "Stopping and removing existing container: ${CONTAINER_NAME}"
    docker stop ${CONTAINER_NAME}
    docker rm ${CONTAINER_NAME}
fi


echo "Running the new container..."
docker run -d --name ${CONTAINER_NAME} -p 80:80 ${REPOSITORY}:${DOCKER_TAG}

echo "Deployment successful: ${CONTAINER_NAME} is running."

