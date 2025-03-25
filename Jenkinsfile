pipeline {
	agent any
	stages {
		stage('Check') {
			steps {
				sh 'python3 --version'
				sh 'python3 -m flake8 --version'
				sh 'python3 -m flake8 . --count --show-source --statistics || true'
			}
		}
		stage('Test') {
			steps {
				echo "TODO..."
			}
		}
	}
}
