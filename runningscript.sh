#Deploy final project(ex4) into the main servers (Test and Prod)

#Vars
HOME_DIR="/home/ec2-user"
JENKINS_PIPE="/var/lib/jenkins/workspace/testpipe"
SSH_KEY_TEST="${HOME_DIR}/.ssh/testserver"
SSH_KEY_PROD="/var/lib/jenkins/.ssh/prodserver"

#machine names are testserver, prodserver
machine=$1

#check args and using massages
#check edge cases


echo "deploying to $machine"
echo "creating project dir"

if [[$machine == "prodserver" ]]; then
scp -i "/var/lib/jenkins/.ssh/prodserver" -o StrictHostKeyChecking=no -r "${WORKSPACE}/db" ec2-user@$machine:
scp -i "/var/lib/jenkins/.ssh/prodserver" -o StrictHostKeyChecking=no "${WORKSPACE}/docker-compose.yml" $ENVFILE_LOCATION ec2-user@$machine:
ssh -i "/var/lib/jenkins/.ssh/prodserver" ec2-user@$machine "docker login; docker-compose up -d; sleep 5"
fi





#if the machine is test, copying and running tests on test-server 
if [[$machine == "testserver" ]]; then
   scp -r "${WORKSPACE}/db" ec2-user@$machine:
   scp "${WORKSPACE}/docker-compose.yml" "${WORKSPACE}/testfile.sh" $ENVFILE_LOCATION ec2-user@$machine:
   ssh ec2-user@$machine "mkdir -p app; docker login;docker pull lironv/attendance:latest; docker-compose up -d --no-build; sleep 100"
   ssh ec2-user@$machine "chmod u+x ./testfile.sh"
   ssh ec2-user@$machine "./testfile.sh"
   ssh ec2-user@$machine "docker-compose down; docker volume prune -f"
fi
