pipeline {
    agent {
        docker {
            image 'python:3.8-alpine'
        }
    }
    environment {
        IMAGE_NAME = 'alianib/my-second-python-app' 
        DOCKER_LOGIN = "alianib" 
    }
    stages {
        stage('Définir BUILD_VERSION') {
            steps {
                script {
                    env.BUILD_VERSION = "1.0.${env.BUILD_NUMBER}"
                }
            }
        }

        stage('Analyse statique et Tests') {
            parallel {
                stage('Linting avec Flake8') {
                    steps {
                        sh 'python3 --version'
                        sh 'pip install --user -r requirements.txt'
                        sh 'pip install flake8'  // Installation de Flake8
                        sh 'python3 -m flake8 --version'
                        sh 'python3 -m flake8 . --count --show-source --statistics || true'
                    }
                }
                stage('Tests unitaires avec Pytest') {
                    steps {
                        sh 'pip install -r requirements.txt'
                        sh 'pip install pytest'
                        sh 'pytest | tee report.txt'
                    }
                    post {
                        always {
                            archiveArtifacts artifacts: 'report.txt', fingerprint: true
                        }
                    }
                }
            }
        }

        stage('Build & Push Docker Image') {
            steps {
                script {
                    withCredentials([string(credentialsId: 'DOCKER_PASSWORD', variable: 'DOCKER_PASS')]) {
                        sh """
                            docker build -t ${IMAGE_NAME}:${env.BUILD_VERSION} .
                            docker login -u ${DOCKER_LOGIN} -p $DOCKER_PASS
                            docker push ${IMAGE_NAME}:${env.BUILD_VERSION}
                        """
                    }
                }
            }
        }
    }
}
