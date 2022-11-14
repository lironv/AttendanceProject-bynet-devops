#clean final project(ex4) into the jenkins server and test server



echo "cleaning all machines"

echo "cleaning jenkins"
docker system prune --volumes

echo "cleaning test"
ssh ec2-user@testserver "docker image rm lironv/attendance:latest; docker volume prune -f"
