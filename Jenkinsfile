pipeline{

	agent any

	environment {
		DOCKERHUB_CREDENTIALS=credentials('1')
	}

	stages {
         stage('Pull') {
            steps {
                git branch: 'main',
                 credentialsId: '831181b1-4a6f-47bf-8c0c-076d1732d795',
                 url: 'git@github.com:lironv/privaterepotest.git'
		    }
        	}
		
        
		stage('Build') {

			steps {
			   dir("app") {
                sh "pwd"
                sh 'docker build -t lironv/attendance:latest .'
			   }
			}
		}

		stage('Login') {

			steps {
				sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
			}
		}

		stage('Push') {

			steps {
				sh 'docker push lironv/attendance:latest'
			}
		}
		stage('StartingTestServer') {
			steps {
			   sshagent(credentials: ['ssh-key-test']) {
				 sh '''
      				 scp -r "${WORKSPACE}/db" ec2-user@testserver:
				 scp "${WORKSPACE}/docker-compose.yml" "${WORKSPACE}/testfile.sh" ec2-user@testserver:
				 ssh ec2-user@testserver "docker login; docker-compose up -d; sleep 1"
				 ssh ec2-user@testserver "chmod u+x ./testfile.sh"
				 ssh ec2-user@testserver "./testfile.sh"
				 ssh ec2-user@testserver "docker-compose down"
				 '''
				}
			}
		}
		stage('StartingProdServer') {
			steps {
			   	 sh '''
      				 scp -i "/var/lib/jenkins/.ssh/prodserver" -r "${WORKSPACE}/db" ec2-user@prodserver:
				 scp "${WORKSPACE}/docker-compose.yml" ec2-user@prodserver:
				 ssh ec2-user@prodserver "docker login; docker-compose up -d; sleep 5"
				 '''
				
			}
		}
	}

	post {
		always {
			sh 'docker ps'
		}
	}

}
