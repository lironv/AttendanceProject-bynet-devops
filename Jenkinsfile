pipeline{
	
	agent any

	environment {
		DOCKERHUB_CREDENTIALS=credentials('1')
		ENVFILE_LOCATION="/var/lib/jenkins/workspace/.env"
	}

	stages {

		stage('Build') {
			steps {
			  checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], 
				    userRemoteConfigs: [[credentialsId: '831181b1-4a6f-47bf-8c0c-076d1732d795', url: 'git@github.com:lironv/AttendanceProject-bynet-devops.git']]])
			   dir("app") {
                		sh """pwd
                		      docker build -t lironv/attendance:latest .
				      echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin
				      docker push lironv/attendance:latest
				      sleep 5
				      docker image rm lironv/attendance:latest
				      docker volume prune -f
				"""
			   }
			}
		}
		stage('Test') {
			steps {
			   sshagent(credentials: ['ssh-key-test']) {
				 sh """bash -ex ./runningscript.sh testserver"""
				}
			}
		}
		stage('Prod') {
			steps {
			   	 sh """bash -xe ./runningscript.sh prodserver"""
				
			}
		}
	}

	post {
		always {
			sshagent(credentials: ['ssh-key-test']) {
				 sh """bash  ./cleanscript.sh """
				}
		}
	}

}
