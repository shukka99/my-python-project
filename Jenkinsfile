pipeline {
	agent any
	environment {
        DOCKER_USER='shukka'
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
				withCredentials([string(credentialsId:'CHARLIE_DOCKER_PASSWORD', variable:'DOCKER_PASS')]) {
					sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
				}
				sh 'docker build -t shukka/my-python-app:$BUILD_NUMBER .'
				sh 'docker push shukka/my-python-app:$BUILD_NUMBER'
				}
			}
		}
	}
}
