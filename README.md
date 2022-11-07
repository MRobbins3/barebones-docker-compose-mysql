# barebones-docker-compose-mysql
## A barebones implementation of MySQL running in a Docker container.
### There are many like it, but this one is mine.

## Setup Steps
- Install Docker Desktop (https://docs.docker.com/engine/install/) or another containerization provider of your choice.
  - One good alternative is Rancher Desktop.
- WINDOWS USERS:
  - If you are using Docker Desktop and have a NVidia graphics card, you may want to select the installation option that uses Hyper-V
    - If you get an error message about "Hardware assisted virtualization":
    - [This Stack Overflow article proved useful](https://stackoverflow.com/questions/39684974/docker-for-windows-error-hardware-assisted-virtualization-and-data-execution-p). 

## Running the Docker Container
- Ensure Docker Desktop is running.
- From the root of the project, run `docker compose up`
  - Optionally, you can use the `-d` flag to run in detached mode, to not keep the command line tied up.
  - The first time it runs, it will pull and download a docker image made for MySQL
  - You should see a message that looks something like this:
    - `/usr/sbin/mysqld: ready for connections. Version: '8.0.31' socket: '...' port: 3306`
- In a new terminal, run the command `docker ps`
  - This shows a list of running docker containers. You should see our docker container listed there.

## Accessing MySQL inside the Docker Container
#### I followed [Mahbub Zaman's tutorial](https://towardsdatascience.com/how-to-run-mysql-using-docker-ed4cebcd90e4) for a good part of the docker compose portion.
- Once your Docker container is up and running, use the following command to enter it.
- `docker exec -it barebones-docker-compose-mysql-db-1 bash`
  - `docker exec` allows us to interact with the running container. 
  - `-it` makes the interaction continuous.
  - Substitute `barebones-docker-compose-mysql-db-1` with whatever name Docker gave your container. (This can be found using `docker ps`).
  - `bash` gives us a bash shell once we are inside the container.
- Now that we are inside the container, we can connect to MySQL with the following command. 
  - `mysql -uroot -proot`
    - `-u` and `-p` pass the username and password, respectively (and should not have a space before the argument). By 
default, in the docker-compose file, we have them set to be "root" and "root". This is a common pattern for databases 
that are only used locally. 
    - If, somehow, you have come across this tutorial for more serious work, don't do this in prod.
  - If this username and password combination is successful, you should now see a command line prompt that leads with `mysql> `
  - Run the query `SHOW DATABASES;`
    - This will show all databases that have been created, and is a good way to check that your access is set up correctly.
    - Note: Be sure to include the semicolon, or the query will wait for you to enter the next line. If that happens, just enter 
a semicolon and then hit enter.

## Adding Test Data to the Database
- First, we need to tell MySQL which database we are using.
- Add any desired setup files to the setup_scripts directory.
