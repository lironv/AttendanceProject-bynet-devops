
# Use an official Python runtime as an image
FROM python:3.10-slim-bullseye
ENV PYTHON_VERSION 3.10.7

#set workdir and copy files
WORKDIR /app
COPY . /app

# The EXPOSE instruction indicates the ports on which a container
EXPOSE 5000

#downloads requirements
RUN python -m pip install --upgrade pip
RUN pip install -r requirements.txt

#running the app file
CMD sh -c 'trap "exit" TERM; while true; do sleep 1; done'
ENTRYPOINT ["python3", "app.py"]
