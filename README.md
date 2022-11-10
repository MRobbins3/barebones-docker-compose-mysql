# barebones-docker-compose-mysql
## A barebones implementation of MySQL running in a Docker container.
### There are many like it, but this one is mine.
------
# Setting Up Docker
---
## Setup Steps
- Install Docker Desktop (https://docs.docker.com/engine/install/) or another containerization provider of your choice.
  - One good alternative is Rancher Desktop.
- WINDOWS USERS:
  - If you are using Docker Desktop and have a Nvidia graphics card, you may want to select the installation option that uses Hyper-V
    - If you get an error message about "Hardware assisted virtualization":
    - [This Stack Overflow article proved useful](https://stackoverflow.com/questions/39684974/docker-for-windows-error-hardware-assisted-virtualization-and-data-execution-p). 
---
## Running the Docker Container
- Ensure Docker Desktop is running.
- BEFORE you create the container, be sure to add any desired setup files to the setup_scripts directory.
- From the root of the project, run 
> docker compose up -d
- Breaking down the parts of the command...
  - The `-d` flag is optional, and is used to run in detached mode, (to not keep the command line tied up.)
  - The first time it runs, it will pull and download a docker image made for MySQL
    - You should see a message that looks something like this:
    `/usr/sbin/mysqld: ready for connections. Version: '8.0.31' socket: '...' port: 3306`
- In a new terminal, run the command 
> docker ps
  - This shows a list of running docker containers. You should see our docker container listed there.
---
## Accessing MySQL inside the Docker Container
#### I followed [Mahbub Zaman's tutorial](https://towardsdatascience.com/how-to-run-mysql-using-docker-ed4cebcd90e4) for a good part of the docker compose portion.
- Once your Docker container is up and running, use the following command to enter it.
> docker exec -it barebones-docker-compose-mysql-db-1 bash
- Breaking down the parts of the command...
  - `docker exec` allows us to interact with the running container. 
  - `-it` makes the interaction continuous.
  - Substitute `barebones-docker-compose-mysql-db-1` with whatever name Docker gave your container. (This can be found using `docker ps`).
  - `bash` gives us a bash shell once we are inside the container.
- Now that we are inside the container, we can connect to MySQL with the following command. 
> mysql -uroot -proot
- Explanation of this command...
  - `-u` and `-p` pass the username and password, respectively (and should not have a space before the argument). By 
default, in the docker-compose file, we have them set to be "root" and "root". This is a common pattern for databases 
that are only used locally. 
  - If, somehow, you have come across this tutorial for more serious work, don't do this in prod.
  - If this username and password combination is successful, you should now see a command line prompt that leads with `mysql> `
  - Run the query `SHOW DATABASES;`
    - This will show all databases that have been created, and is a good way to check that your access is set up correctly.
    - Note: Be sure to include the semicolon, or the query will wait for you to enter the next line. If that happens, just enter 
a semicolon and then hit enter.
---
## Adding Test Data to the Database from a file
- If you are still in the mysql command line, use `exit` to get back to the bash shell.
- Files in the `setup_scripts` directory are accessible inside our container because we mounted them in the docker-compose.yml file.
- To load a file, use the following command, where the argument after the `<` symbol is the sql file you want to load.
> mysql -uroot -p gvu_databases < school.sql/school.sql

### Ensure the data loaded
-  First, we need to tell MySQL which database we are using. The database name is defined around line 8 of docker-compose.yml
> USE gvu_databases;
- Next, run the command to list all tables.
> SHOW TABLES;

---

# Setting up MySQL Workbench
## Download and Install
- Download and install the latest version from Oracle's website. 
  - [Link to the Workbench Download](https://dev.mysql.com/downloads/workbench/)
  - They make it hard to find, but you don't need to pay and you don't need to sign up for an account.
  - You also only need the Workbench, you don't need "All MySQL Products"

## Connecting MySQL to Docker Container
- Make sure your docker container is running (see previous section.)
- In MySQL Workbench, go to `MySQL Connections` and hit the + Icon
- The connection settings can be found in the dockercompose.yml file.
   - Unless you changed them, they are here:
     - Hostname: 127.0.0.1
     - Port: 3306
     - Username: user
     - Password: password
