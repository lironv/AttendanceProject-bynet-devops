#Deploy final project(ex4) into the main servers (Test and Prod)

#Vars
HOME_DIR="/home/ec2-user"
JENKINS_PIPE="/var/lib/jenkins/workspace/testpipe"
SSH_KEY_TEST="/var/lib/jenkins/.ssh/testserver"
SSH_KEY_PROD="/var/lib/jenkins/.ssh/prodserver"

machine=$1

#check args and using massages
#check edge cases

echo "deploying to $machine"
echo "creating project dir"
ssh -i "${SSH_KEY_TEST}" ec2-user@${machine} "mkdir -p ${HOME_DIR}/final-project"
echo
pwd
echo "copying compose file to $machine"
scp -i "${SSH_KEY_TEST}" "${JENKINS_PIPE}/docker-compose.yml" "ec2-user@${machine}:${HOME_DIR}/final-project"
echo "starting project"

ssh -i "${SSH_KEY_TEST}" ${machine} "docker version; docker compose version; jq --version"