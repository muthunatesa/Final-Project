pipeline {
    agent any
    environment {
        DOCKER_CREDENTIALS_ID = 'dockerhub-credentials'  // Jenkins credentials ID for Docker Hub
        DOCKER_IMAGE_NAME = 'muthunatesa/react-image'
    }
    stages {
        stage('Checkout') {
            steps {
                // Checkout the code from the repository
                checkout scm
            }
        }
        stage('Build') {
            steps {
                script {
                    // Ensure the Docker image is built (if it's not built in build.sh)
                    sh 'bash build.sh'
                }
            }
        }
        stage('Push to Docker Hub') {
            steps {
                script {
                    // Docker login using Jenkins credentials
                    withCredentials([usernamePassword(credentialsId: DOCKER_CREDENTIALS_ID, usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        sh "echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin"
                    }
                    
                    // Push to the appropriate repository based on the branch name
                    if (env.BRANCH_NAME == 'dev') {
                        // Tag and push to dev repository
                        sh "docker tag ${DOCKER_IMAGE_NAME}:latest ${DOCKER_IMAGE_NAME}/dev:latest"
                        sh "docker push muthunatesa/dev:latest"
                    } else if (env.BRANCH_NAME == 'main') {
                        // Tag and push to prod repository
                        sh "docker tag ${DOCKER_IMAGE_NAME}:latest ${DOCKER_IMAGE_NAME}/prod:latest"
                        sh "docker push muthunatesa/prod:latest"
                    } else {
                        echo "Branch ${env.BRANCH_NAME} does not match dev or main, skipping Docker push."
                    }
                }
            }
        }
        stage('Deploy') {
            steps {
                script {
                    // Deploy the application
                    sh 'bash deploy.sh'
                }
            }
        }
    }
}

