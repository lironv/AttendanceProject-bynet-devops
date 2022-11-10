# Attendance Project
web application based on flask, mysql deployed with docker compose.

## 🔗 Links
[![portfolio](https://img.shields.io/badge/my_portfolio-000?style=for-the-badge&logo=ko-fi&logoColor=white)](https://github.com/lironv)
[![linkedin](https://img.shields.io/badge/linkedin-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/liron-vaknin-669457161/)

####cvkmckmvm
## Installation

Clone the repository, you can paste the link below in your terminal

```bash
  git clone https://github.com/lironv/attendanceproject.git
```
*you do need the environment variables file (.env) for the project to work on your system*
*add the .env file inside the attendence folder 

```bash
  mv .env ./attendanceproject/attendance
```

after that, enter the "attendance" folder inside, and use the docker-compose command

```bash
   cd ./attendanceproject/attendance
   docker-compose up -d
```

the project takes about 1-2 mins to deploy

you can check the containers by pasting in the terminal 
```bash
   docker container ls
```

you can connect to the website by entering in your internet browser "http://localhost:5000"
## Screenshots


![App Screenshot](https://i.ibb.co/1vrGhM6/main-project-image.png)
![App Screenshot](https://i.ibb.co/cCWzfBS/main-project-homepage.png)
