#REDCap(PHP) Dockerized Environment
This repository provides a Dockerized setup for deploying a REDCap application with Nginx, PHP-FPM, Postfix, MySQL, and additional tools like Portainer for container management. The setup is designed for seamless deployment and maintainability of the REDCap application in a production-like environment.
________________________________________
Table of Contents
1.	Features
2.	Prerequisites
3.	Getting Started
4.	Environment Variables
5.	Services Overview
6.	Volumes
7.	Networks
8.	Port Mappings
9.	License
________________________________________
Features

•	Nginx: Serves as the web server for hosting the REDCap application.
•	PHP-FPM: Processes PHP scripts for the REDCap application.
•	MySQL: Acts as the database backend for REDCap.
•	Postfix: setup inside PHP-FPM container for Email replay 
•	Portainer: Provides a graphical interface to manage Docker containers.
•	Persistent Storage: Includes volumes for logs, session files, and database data to ensure persistence.
•	Customizable SMTP Settings: Supports configuration for email notifications using SMTP.

________________________________________
Prerequisites

1.	Docker and Docker Compose installed on your system.
2.	You much have Redcap University community account and subscription to get Redcap files and media. click here
3.	Environment variables configured for sensitive data (see Environment Variables).
4.	Sufficient resources to run containers (minimum 2 GB RAM recommended).
5.  you must have Redcap Subscriptions to get Redcap Allications and files. if you like to Deploy Redcap Applications Click here https://projectredcap.org/resources/community/
6.  Once you have Redcap Applications(PHP-App) , copy the Redcap folder to root /Redcap_docker/nginx/redcap/

________________________________________
Getting Started
1.	Clone this repository:

 >    git clone (https://github.com/rimiag/REDCap-PHP-Dockerized-Environment.git) redcap
 >    cd redcap
2.	Set up your environment variables:
o	Create a .env or you can find .env file in the root directory and add the necessary variables (refer to Environment Variables).
3.	Build and start the container using docker compose , it will spin up all the container for you 
  >   docker-compose up --build -d
4.	Access services:
o	REDCap: http://localhost (or your server's IP)
o	Portainer: http://localhost:9001
________________________________________
Environment Variables
Define these variables in a .env file in the root of the project:
# MySQL Settings
MYSQL_ROOT_PASSWORD=<your-root-password>
MYSQL_DATABASE=<database-name>
MYSQL_USER=<db-username>
MYSQL_PASSWORD=<db-password>

# SMTP Settings
EMAIL=<smtp-email>
EMAIL_PASSWORD=<smtp-password>
MAIL_NAME=<email-display-name>
SMTP_DOMAIN=<smtp-server-domain>
SMTP_PORT=<smtp-port>
HOSTNAME=<container-hostname>
________________________________________
Services Overview
1. Nginx
•	Role: Web server for serving REDCap.
•	Ports: Exposed on port 80 or 443.
•	Volumes:
o	Application files: ./nginx/redcap:/var/www/html
o	Logs: nginx-logs:/var/log/nginx
2. PHP-FPM
•	Role: Processes PHP scripts for REDCap.
•	Ports: Exposed on port 9000.
•	Volumes:
o	Application files: ./nginx/redcap:/var/www/html
o	PHP sessions: php-sessions:/var/lib/php/sessions
3. MySQL
•	Role: Database backend for REDCap.
•	Ports: Exposed on port 3306.
•	Volumes:
o	Initialization scripts: ./mysql:/docker-entrypoint-initdb.d
o	Data storage: mysql-data:/var/lib/mysql
4. Portainer
•	Role: Container management tool with a web-based UI.
•	Ports: Exposed on port 9001.
•	Volumes:
o	Data: portainer_data:/data
o	Docker socket: /var/run/docker.sock:/var/run/docker.sock
________________________________________
Volumes
•	nginx-logs: Stores logs generated by the Nginx web server.
•	php-sessions: Holds PHP session files.
•	mysql-data: Stores persistent MySQL database data.
•	portainer_data: Keeps Portainer configuration and management data.
________________________________________
Networks
•	redcap-network: Bridge network used for inter-container communication.
________________________________________
Port Mappings
•	80:80 (Nginx for REDCap)
•	9000:9000 (PHP-FPM)
•	3306:3306 (MySQL)
•	9001:9000 (Portainer management UI)
________________________________________

