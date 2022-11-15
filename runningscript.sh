#Deploy final project(ex4) into the main servers (Test and Prod)
#Vars
HOME_DIR="/home/ec2-user"
JENKINS_PIPE="/var/lib/jenkins/workspace/testpipe"
SSH_KEY_TEST="${HOME_DIR}/.ssh/testserver"
SSH_KEY_PROD="/var/lib/jenkins/.ssh/prodserver"
#machine names are testserver, prodserver
machine=$1



echo "deploying to $machine"
echo "creating project dir"
if [ $machine == "prodserver" ]; then
   echo "starting scp process"
   scp -i "/var/lib/jenkins/.ssh/prodserver" -o StrictHostKeyChecking=no -r -v "${WORKSPACE}/db" ec2-user@prodserver:
   scp -i "/var/lib/jenkins/.ssh/prodserver" -o StrictHostKeyChecking=no -v "${WORKSPACE}/docker-compose.yml" $ENVFILE_LOCATION ec2-user@prodserver:
   echo "start prod environment, deploying site"
   ssh -i "/var/lib/jenkins/.ssh/prodserver" ec2-user@$machine "mkdir -p app;docker login;docker pull lironv/attendance:latest; docker-compose up -d --no-build; sleep 70"
fi




#if the machine is test, copying and running tests on test-server 
if [ $machine == "testserver" ]; then
   scp -r "$WORKSPACE/db" ec2-user@$machine:
   scp "$WORKSPACE/docker-compose.yml" "$WORKSPACE/testfile.sh" $ENVFILE_LOCATION ec2-user@$machine:
   echo "start test environment, deploying site and testing"
   ssh ec2-user@$machine "mkdir -p app; docker login;docker pull lironv/attendance:latest; docker-compose up -d --no-build;sleep 70"
   echo "start testing process"
   ssh ec2-user@$machine "set -e; bash testfile.sh;sleep 5; docker-compose down;sleep 5; docker image rm lironv/attendance:latest; docker volume prune -f"
   echo "containers has been downed and images + volumes has been cleaned "
fi
