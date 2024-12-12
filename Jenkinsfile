pipeline {
    agent any
    environment {
        DOCKER_CREDENTIALS_ID = 'dockerhub-credentials'  // Jenkins credentials ID for Docker Hub
        DOCKER_IMAGE_NAME = 'react-image'
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
                    // Build the Docker image
                    sh 'bash build.sh'  // Ensure this script builds your Docker image
                }
            }
        }
        stage('Push to Docker Hub') {
            steps {
                script {
                    // Login to Docker Hub once before pushing images
                    withCredentials([usernamePassword(credentialsId: DOCKER_CREDENTIALS_ID, usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        sh "echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin"
                    }
                    
                    // Push to the appropriate repository based on the branch name
                    def targetRepository = ''
                    def targetTag = 'latest'  // Default tag is latest
                    if (env.BRANCH_NAME == 'dev') {
                        targetRepository = 'muthunatesa/dev'  // Push to dev repository
                    } else if (env.BRANCH_NAME == 'main') {
                        targetRepository = 'muthunatesa/prod'  // Push to prod repository
                    } else {
                        echo "Branch ${env.BRANCH_NAME} does not match dev or main, skipping Docker push."
                        return
                    }
                    
                    // Tag and push the image
                    echo "Tagging image for repository: $targetRepository"
                    sh "docker tag ${DOCKER_IMAGE_NAME}:latest ${targetRepository}:${targetTag}"
                    sh "docker push ${targetRepository}:${targetTag}"
                }
            }
        }
        stage('Deploy') {
            steps {
                script {
                    // Deploy the application
                    sh 'bash deploy.sh'  // Ensure this script handles deployment properly
                }
            }
        }
    }
}

