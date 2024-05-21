# Parasol Planning Lab Crash Course

## Build Docker Container

### Install Docker Desktop

Install docker desktop for your system from [here](https://www.docker.com/products/docker-desktop/).

<details>
  <summary><h3>Ubuntu</h3></summary>
  > Fix docker permissions using [this](https://medium.com/@praveenadoni4456/error-got-permission-denied-while-trying-to-connect-to-the-docker-daemon-socket-at-e68bfab8146a).
</details>

<details>
  <summary><h3>Windows</h3></summary>
  Install Windows Subsystem for Linux following these [instructions](https://learn.microsoft.com/en-us/windows/wsl/install)
  <br>
  Setup Docker desktop to use WSL 2:
  1. Open Docker desktop.
  2. Navigate to Settings.
  3. Select the Resources tab.
  4. Select the WSL Integration sub-tab.
  5. Enable the Ubuntu integration.
  6. Select Apply & Restart.
  <br>
  Install openssh server
  1. Hit the windows button and seach for "optional features"
  2. Select the blue button that says "view features"
  3. Search for "OpenSSH Server" and hit install
  <br>
  Open WSL 2.
  1. Open Terminal
  2. Select the dropdown arrow next to the Windows PowerShell tab at the top of the window and select Ubuntu
  3. Create an ssh key for your WSL 2
  4. Add ssh key to github
  <br>
</details>

<details>
  <summary><h3>MacOS</h3></summary>
  <details>
    <summary><h4>Intel</h4></summary>
    TODO
  </details>
  <br>
  <details>
    <summary><h4>Apple Silicon</h4></summary>
    > TODO: Gazebo is not supported on ARM processors. See
  </details>

</details>

### Install Visual Studio Code

1. Install Visual Studio Code from [here](https://code.visualstudio.com/)
2. Install the Remote - Dev Containers extension from [here](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)

### 1. Grant privileges to the scripts

```sh
chmod -R +x docker/ppl-crash-course/scripts/*
```

### 2. Build docker image

```sh
./BUILD-DOCKER-IMAGE.sh
```

> If you get issues related to the docker daemon, try [this](https://medium.com/@praveenadoni4456/error-got-permission-denied-while-trying-to-connect-to-the-docker-daemon-socket-at-e68bfab8146a).

### 3. Create and run docker container

```sh
./RUN-DOCKER-CONTAINER.sh
```

### 4. Build ROS 2 environment inside container

```sh
ppl-cc-build-workspace
```

> If you get the following error, `c++: fatal error: Killed signal terminated program cc1plus`, rerun the command in 4.

### 5. Generate an ssh key

```sh
ssh-keygen
```

### 6. TODO

## Stop docker container

To stop the docker container run:

```sh
docker stop $USER-ppl-crash-course-1
```

## Deleting Containers

To delete all docker containers (docker cache) run:

```sh
docker system prune -a
```
