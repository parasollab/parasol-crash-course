# Parasol Planning Lab Crash Course

## Build Docker Container (Apple Silicon)

### Install Docker Desktop

### Tested Platforms: Ubuntu, Windows (WSL2), MacOS

Install docker desktop for your system from [here](https://www.docker.com/products/docker-desktop/).

### MacOS (Apple Silicon): Need to have Rosetta 2 installed

This [article](https://osxdaily.com/2020/12/04/how-install-rosetta-2-apple-silicon-mac/) provides some information on how to install Rosetta 2.

### Install Visual Studio Code

1. Install Visual Studio Code from [here](https://code.visualstudio.com/)
2. Install the Remote - Dev Containers extension from [here](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)

### 1. Start Docker with the following command:

```sh
DOCKER_DEFAULT_PLATFORM=linux/amd64 docker run -v ~/ros2_ws:/home/ubuntu:cached -p 6080:80 -p 10000:10000 --shm-size=1024m tiryoh/ros2-desktop-vnc:iron
```

### 2. Open a browser and navigate to `http://localhost:6080/` and hit connect

### 3. Open a terminal in the browser create an ssh-key with `ssh-keygen` and then add it to your github account.

```sh
ssh-keygen
```

```sh
cat ~/.ssh/id_rsa.pub
```

Then copy and paste the key into a new github ssh key

### 4. Clone your assignment repository

```sh
git clone <github_link>
```

> Make sure that everything that you clone is inside of the `/home/ubuntu` directory otherwise it will not save your data.

### 5. Build the ROS 2 workspace

```sh
cd /home/ubuntu/ppl_cc_ws
```

```sh
rosdep install -r --from-paths . --ignore-src --rosdistro iron -y
```

```sh
colcon build --symlink-install --executor sequential --cmake-args "-DCMAKE_BUILD_TYPE=Release"
```

```sh
source install/setup.bash
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
