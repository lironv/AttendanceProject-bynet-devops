#Deploy final project(ex4) into the main servers (Test and Prod)

#Vars
HOME_DIR="/home/ubuntu"
JENKINS_PIPE="/var/lib/jenkins/workspace/testpipe"
SSH_KEY_TEST="/.ssh/testserver"
SSH_KEY_PROD="/.ssh/prodserver"

machine=$1

#check args and using massages
#check edge cases

echo "deploying to $machine"
echo "creating project dir"
ssh -i "${SSH_KEY_TEST}" ${machine} "mkdir -p ${HOME_DIR}/final-project"
echo "copying compose file to $machine"
ssh -i "${SSH_KEY_TEST}" ${machine} "mkdir -p ${HOME_DIR}/final-project"
echo "starting project"

ssh -i "${SSH_KEY_TEST}" ${machine} "docker version; docker compose version; jq --version"
