pipeline {
    agent any
    environment {
        DOCKER_CREDENTIALS_ID = 'dockerhub-credentials'
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
                    sh 'bash build.sh' 
                }
            }
        }
        stage('Push to Docker Hub') {
            steps {
                script {
                    // Login to Docker Hub
                    withCredentials([usernamePassword(credentialsId: DOCKER_CREDENTIALS_ID, usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        sh "echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin"
                    }
                    
                    // Push to repository based on branch
                    def targetRepository = ''
                    def targetTag = 'latest' 
                    if (env.BRANCH_NAME == 'dev') {
                        targetRepository = 'muthunatesa/dev' 
                    } else if (env.BRANCH_NAME == 'main') {
                        targetRepository = 'muthunatesa/prod'
                    } else {
                        echo "Branch ${env.BRANCH_NAME} does not match dev or main, skipping Docker push."
                        return
                    }
                    
                    
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
                    sh 'bash deploy.sh' 
                }
            }
        }
    }
}

