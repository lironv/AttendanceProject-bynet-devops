
#!/bin/bash
filename="docker-compose.yml"
if test -f "$filename";
then
    echo "$filename has found."
else
    echo "$filename has not been found"
fi
ping -c 1 127.0.0.1:5000 &> /dev/null && echo success || echo fail
