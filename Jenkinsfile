pipeline {
    agent any  // Runs on any available agent

    parameters {
        choice(name: 'REPOSITORY', choices: ['https://github.com/sibilucky/java-maven-app.git'], description: 'Select the Git repository URL')
        choice(name: 'BRANCH', choices: ['main', 'master', 'release'], description: 'Select the Git branch to checkout')
        choice(name: 'TAG', choices: ['latest', 'v1.0', 'v2.0'], description: 'Select the Docker image tag')
    }

    environment {
         REPO_URL = "https://github.com/sibilucky/java-maven-app.git"
         BRANCH_NAME = "main"
         IMAGE_TAG = "latest"
         JAVA_HOME = '/path/to/java17'  // Ensure this is the correct path to Java 17
         PATH = "${JAVA_HOME}/bin:${env.PATH}"
    }

    tools {
        // Use a specific Maven version if it's set up in Jenkins
        maven 'maven3'  // Reference to the Maven installation configured in Jenkins
    }

    stages {
        stage('Checkout') {
            steps {
                script {
                    echo "Checking out code from repository:https://github.com/sibilucky/java-maven-app.git , branch: main"
                    git url: "https://github.com/sibilucky/java-maven-app.git", branch: "main"
                }
            }
        }

        stage('Build') {
            steps {
                echo 'Building the project using Maven'
                sh 'mvn clean install'
            }
        }

        stage('Test') {
            steps {
                echo 'Running unit tests'
                sh 'mvn test'
            }
        }

        stage('Package') {
            steps {
                echo 'Packaging the Spring Boot application into a JAR...'
                sh 'mvn package'
            }
        }

        // Docker Login
        stage('Docker Login') {
            steps {
                echo 'Logging into Docker registry'
                withCredentials([usernamePassword(credentialsId: 'docker-credentials-id', usernameVariable: 'sibisam2301@gmail.com', passwordVariable: 'devika@123')]) {
                    sh 'docker login -u sibisam2301@gmail.com -p devika@123'
                }
            }
        }

        // Deploy the project
        stage('Deploy') {
            steps {
                echo "Deploying Docker container with tag: ${params.TAG}"
                sh """
                     #!/bin/bash
                    docker build -t java-maven-app:latest .
                    docker run -d -p 8082:8080 java-maven-app:latest
                    """

               
            }
        }
    }

    post {
        always {
            echo 'Cleaning up'
            cleanWs()  // Clean up the workspace after execution
        }
        success {
            echo 'Pipeline executed successfully!'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
}
 
