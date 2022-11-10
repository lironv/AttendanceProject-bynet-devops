
#!/bin/bash 
################
#testfile .
################

#check if files are located in machine 
filename="docker-compose.yml"
if test -f "$filename";
then
    echo "$filename has found."
else
    echo "$filename has not been found"
fi


#check curl to server.
status_code=`curl -s -I ${localhost:5001} | grep HTTP | awk {'print $2'}`
if [[ $status_code -eq 200 ]] ; then
  echo "Site status changed to $status_code"
  exit 1
else
  echo "successful task, curl localhost:5000"
fi


#check if containers are live.
CONTAINER_NAME_APP='ec2-user_app_1'
CONTAINER_NAME_DB='ec2-user_db_1'
CID=$(docker ps -q -f status=running -f name=^/${CONTAINER_NAME_APP}$)
if [  "${CID}" ]; then
  echo "Container exists, success"
fi
CID=$(docker ps -q -f status=running -f name=^/${CONTAINER_NAME_DB}$)
if [  "${CID}" ]; then
  echo "Container exists, success"
fi
unset CID
