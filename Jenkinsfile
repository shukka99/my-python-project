pipeline {
	agent any
	environment {
        DOCKER_LOGIN=shukka
        DOCKER_PASS=test
	}
	stages {
		stage('Check') {
			steps {
				sh 'python3 --version'
				sh 'python3 -m flake8 --version'
				echo "Lancer l'analyse"
				sh 'python3 -m flake8 . --count --show-source --statistics || true'
			}
			post {
                // Actions to execute upon successful completion of the stage
                success {
                    echo "Check successful"
				}
                // Actions to execute if the stage fails
                failure {
                    echo "Check failed"
				}
			}
		}
		stage('Unit tests') {
			steps {
				sh 'pytest | tee report.txt'
			}
			post {
                // Actions to execute upon successful completion of the stage
                success {
                    echo "Unit tests successful"
				}
                // Actions to execute if the stage fails
                failure {
                    echo "Unit tests failed"
				}
			}
		}
		stage('Publish image') {
			steps {
				echo "Construire l'image Docker avec le BUILD_NUMBER de Jenkins"
				docker build -t shukka/my-python-app:$BUILD_NUMBER .
				echo "Se connecter à Docker Hub en utilisant le token d'accès"
				docker login -u $DOCKER_LOGIN -p $DOCKER_PASS
				echo "Pousser l'image sur Docker Hub"
				docker push shukka/my-python-app:$BUILD_NUMBER
			}
		}
	}
}
