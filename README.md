# barebones-docker-compose-mysql
## A barebones implementation of MySQL running in a Docker container.
### There are many like it, but this one is mine.

------
<details open>
  <summary><h1> Section 1: Docker/Rancher </h1></summary>
  
  ## Setup Steps
  - Install [Rancher Desktop](https://rancherdesktop.io/) or another containerization provider of your choice.
  
  ### Rancher Desktop (recommended)
  - I recommend using Rancher Desktop, as the installation process has been much smoother and Docker updated their licencing in 2022.
  - Get the latest version [here](https://rancherdesktop.io/)
    - You do not need to enable Kubernetes
    - Be sure to select `dockerd (moby)` as your Container Runtime.

  - To verify that you are set up for Docker, launch the Rancher Desktop application, wait for the loading bars in the lower left to finish updates. 
  - Next, go to File -> Preferences -> Container Engine
    - Make sure that "dockerd (moby)" is selected.
    - Under -> Kubernetes, you can uncheck the box that says "Enable Kubernetes"

  <details>
    <summary><h2> Docker Desktop ... (Rancher Desktop OR Docker Desktop, not both.) </h2></summary>
    
  - Install [Docker Desktop](https://docs.docker.com/engine/install/)
  - WINDOWS USERS:
    - If you are using Docker Desktop and have a Nvidia graphics card, you may want to select the installation option that uses Hyper-V
      - If you get an error message about "Hardware assisted virtualization": [This Stack Overflow article proved useful](https://stackoverflow.com/questions/39684974/docker-for-windows-error-hardware-assisted-virtualization-and-data-execution-p)
      - I ended up having to edit the visualization settings in my BIOS. 
  </details>
  
  ---
  ## Running the Docker Container
  - Ensure Docker/Rancher Desktop is running.
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

  <details>
    <summary><h3> Troubleshooting </h3></summary>

  ### Windows: "Docker error - the docker daemon is not running"
  - This is an error you might see if the Windows Subsystem for Linux is not running on your machine. 
  - The full debugging steps are [available on this site](https://linuxhint.com/resolve-docker-daemon-not-running/) and outlined below
    - Open Powershell as an Administrator
    - Check the docker version using `docker --version` to ensure Windows can run docker commands
    - Run `docker run hello-world` 
      - If you get an error about the docker daemon, do the following: 
      - Check the Docker Desktop Service in Services->Local-> Docker Desktop Service (make sure the status is "Running")
      - If the status is already "Running", you need to install / install the WSL 
      - [WSL Update from Microsoft](https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi)
      - Restart, then go back to the beginning of this debugging section and try again.
        - If `docker run hello-world` prints properly, you are good to go to try `docker compose up -d`
  </details>

  ---

  <details>
    <summary><h2> Manually Testing Proper Setup to the Docker Container </h2></summary>

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
    - `-u` and `-p` pass the username and password, respectively (and should not have a space before the argument). By default, in the docker-compose file, we have them set to be "root" and "root". This is a common pattern for databases that are only used locally. 
    - If, somehow, you have come across this tutorial for more serious work, don't do this in prod.
    - If this username and password combination is successful, you should now see a command line prompt that leads with `mysql> `
    - Run the query `SHOW DATABASES;`
      - This will show all databases that have been created, and is a good way to check that your access is set up correctly.
      - Note: Be sure to include the semicolon, or the query will wait for you to enter the next line. If that happens, just enter a semicolon and then hit enter.
  </details>

  ---

  <details>
    <summary><h2> Adding Test Data to the Database from a file </h2></summary>
    
  ### Data Load
  - If you are still in the mysql command line, use `exit` to get back to the bash shell.
  - Files in the `setup_scripts` directory are accessible inside our container because we mounted them in the docker-compose.yml file.
  - To load a file, use the following command, where the argument after the `<` symbol is the sql file you want to load.
  > mysql -uroot -p barebones_db < school.sql/school.sql

  ### Ensure the data loaded
  -  First, we need to tell MySQL which database we are using. The database name is defined around line 8 of docker-compose.yml. You will replace `barebones_db` with whatever you called your database, if you changed it.
    > USE barebones_db;
  - Next, run the command to list all tables.
    > SHOW TABLES;
    
  </details>
    
</details>

---
  
<details>
  <summary><h1> Setting up MySQL Workbench </h2></summary>

## Step 1: Download and Install
  - Download and install the latest version from Oracle's website. 
    - [Link to the Workbench Download](https://dev.mysql.com/downloads/workbench/)
    - They make it hard to find, but you don't need to pay and you don't need to sign up for an account.
    - You also only need the Workbench, you don't need "All MySQL Products"

  ---

## Step 2: Connect MySQL to Docker Container

  ### Ensure Docker is Running
  - Make sure your docker container is running (see previous section.)
    - After initial setup, this should be as easy as running `docker compose up -d

  ### Connect on Workbench
  - In MySQL Workbench, go to `MySQL Connections` and hit the + Icon
    - The connection settings can be found in the dockercompose.yml file.
    - Unless you changed them, they are here:
      ```
      - Hostname: 127.0.0.1
      - Port: 3306
      - Username: user
      - Password: password
      ```
    - I recommend also connecting as root, to have a user with elevated privledges. You can create a second connection the same way. 
      ```
      - Hostname: 127.0.0.1
      - Port: 3306
      - Username: root
      - Password: root
      ```

</details>
