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

if [ $machine == "prodserver" ]; then
rsync -Pav -e "ssh -i /var/lib/jenkins/.ssh/prodserver" ec2-user@$machine:/$HOME_DIR/db "$WORKSPACE/db"
rsync -Pav -e "ssh -i /var/lib/jenkins/.ssh/prodserver" ec2-user@$machine:/docker-compose.yml $WORKSPACE/docker-compose.yml

ssh -i "/var/lib/jenkins/.ssh/prodserver" ec2-user@$machine "mkdir -p app;docker login;docker pull lironv/attendance:latest; docker-compose up -d --no-build; sleep 5"
fi


if [ $machine == "testserver" ]; then
   scp -r "$WORKSPACE/db" ec2-user@$machine:
   scp "$WORKSPACE/docker-compose.yml" "$WORKSPACE/testfile.sh" $ENVFILE_LOCATION ec2-user@$machine:
   ssh ec2-user@$machine "mkdir -p app; docker login;docker pull lironv/attendance:latest; docker-compose up -d --no-build; sleep 70;chmod u+x ./testfile.sh; ./testfile.sh;sleep 5; docker-compose down; docker volume prune -f"
       sleep 70;bash ./testfile.sh; docker-compose down; docker volume prune -f"
fi

