#Deploy final project(ex4) into the main servers (Test and Prod)

#Vars
HOME_DIR="/home/ec2-user"
JENKINS_PIPE="/var/lib/jenkins/workspace/testpipe"
SSH_KEY_TEST="${HOME_DIR}/.ssh/testserver"
SSH_KEY_PROD="/var/lib/jenkins/.ssh/prodserver"

machine=$1

#check args and using massages
#check edge cases


echo "deploying to $machine"
echo "creating project dir"

scp -r "${WORKSPACE}/db" ec2-user@testserver:
scp "${WORKSPACE}/docker-compose.yml" "${WORKSPACE}/testfile.sh" $ENVFILE_LOCATION ec2-user@testserver:
ssh ec2-user@testserver "mkdir app; docker login;docker pull lironv/attendance:latest; docker-compose up -d --no-build; sleep 100"
ssh ec2-user@testserver "chmod u+x ./testfile.sh"
ssh ec2-user@testserver "./testfile.sh"
ssh ec2-user@testserver "docker-compose down; docker volume prune -f"

