pipeline{

	agent any

	environment {
		DOCKERHUB_CREDENTIALS=credentials('1')
		ENVFILE_LOCATION="/var/lib/jenkins/workspace/.env"
	}

	stages {

		stage('Build') {
			steps {
			   git branch: 'main',
                           credentialsId: '831181b1-4a6f-47bf-8c0c-076d1732d795',
                 	   url: 'git@github.com:lironv/privaterepotest.git'
			   dir("app") {
                		sh "pwd"
                		sh 'docker build -t lironv/attendance:latest .'
				sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
				sh 'docker push lironv/attendance:latest'
			   }
			}
		}
		stage('Test') {
			steps {
			   sshagent(credentials: ['ssh-key-test']) {
				 sh """bash ./runningscript.sh testserver"""
				}
			}
		}
		stage('Prod') {
			steps {
			   	 sh """bash ./runningscript.sh prodserver"""
				
			}
		}
	}

	post {
		always {
			sh 'docker ps'
		}
	}

}
