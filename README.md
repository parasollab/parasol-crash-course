# Parasol Planning Lab Crash Course

## Build Docker Container

### Install Docker Desktop

### Tested Platforms: Ubuntu, Windows (WSL2), MacOS

Install docker desktop for your system from [here](https://www.docker.com/products/docker-desktop/).

<!-- <details>
  <summary><h3>Ubuntu</h3></summary>
  Fix docker permissions using [this guide](https://medium.com/@praveenadoni4456/error-got-permission-denied-while-trying-to-connect-to-the-docker-daemon-socket-at-e68bfab8146a).
</details> -->

### Windows
<details>
  <summary><h3>WSL2 Install</h3></summary>
  <ol>
    <li>Install Windows Subsystem for Linux following these <a href="https://learn.microsoft.com/en-us/windows/wsl/install">instructions</a>.</li>
    <li>Setup Docker Desktop to use WSL 2:
      <ol>
        <li>Open Docker Desktop.</li>
        <li>Navigate to Settings.</li>
        <li>Select the Resources tab.</li>
        <li>Select the WSL Integration sub-tab.</li>
        <li>Enable the Ubuntu integration.</li>
        <li>Select Apply & Restart.</li>
      </ol>
    </li>
    <li>Install OpenSSH server:
      <ol>
        <li>Hit the Windows button and search for "optional features".</li>
        <li>Select the blue button that says "view features".</li>
        <li>Search for "OpenSSH Server" and hit install.</li>
      </ol>
    </li>
    <li>Open WSL 2:
      <ol>
        <li>Open Terminal.</li>
        <li>Select the dropdown arrow next to the Windows PowerShell tab at the top of the window and select Ubuntu.</li>
        <li>Create an SSH key for your WSL 2.</li>
        <li>Add the SSH key to GitHub.</li>
      </ol>
    </li>
  </ol>
</details>

### MacOS (Apple Silicon): Need to have Rosetta 2 installed

This [article](https://osxdaily.com/2020/12/04/how-install-rosetta-2-apple-silicon-mac/) provides some information on how to install Rosetta 2.

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

### 6. Add ssh key to your github

```sh
cat ~/.ssh/id_rsa.pub
```

Then copy and paste the key into a new github ssh key

### 7. Clone assignment

```sh
git clone <github_link>
```

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
