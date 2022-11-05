
#!/bin/bash
filename="docker-compose.yml"
if test -f "$filename";
then
    echo "$filename has found."
else
    echo "$filename has not been found"
fi
ping -c 1 127.0.0.1:5000 &> /dev/null && echo success || echo fail

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
