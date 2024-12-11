pipeline {
    agent any
    environment {
        DOCKER_CREDENTIALS_ID = 'dockerhub-credentials' // Jenkins credentials ID for Docker Hub
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
                    // Build the Docker image
                    sh 'bash build.sh'
                }
            }
        }
        stage('Push to Docker Hub') {
            steps {
                script {
                    // Determine the branch and push to the appropriate Docker Hub repository
                    if (env.GIT_BRANCH == 'origin/dev') {
                        // Push to dev repository
                        sh "docker tag ${DOCKER_IMAGE_NAME}:latest ${DOCKER_IMAGE_NAME}/dev:latest"
                        withCredentials([usernamePassword(credentialsId: DOCKER_CREDENTIALS_ID, usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                            sh "echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin"
                            sh "docker push ${DOCKER_IMAGE_NAME}/dev:latest"
                        }
                    } else if (env.GIT_BRANCH == 'origin/master') {
                        // Push to prod repository
                        sh "docker tag ${DOCKER_IMAGE_NAME}:latest ${DOCKER_IMAGE_NAME}/prod:latest"
                        withCredentials([usernamePassword(credentialsId: DOCKER_CREDENTIALS_ID, usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                            sh "echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin"
                            sh "docker push ${DOCKER_IMAGE_NAME}/prod:latest"
                        }
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
    triggers {
        // Poll SCM for changes
        pollSCM('* * * * *')
    }
}
