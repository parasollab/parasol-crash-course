# Parasol Planning Lab Crash Course

## Build Docker Container
### Install Docker Engine
Install docker engine from [here](https://docs.docker.com/engine/install/).

### 1. Grant privileges to the scripts
``` sh
chmod -R +x docker/ppl-crash-course/scripts/*
```

### 2. Build docker image
``` sh
./BUILD-DOCKER-IMAGE.sh
```

### 3. Create and run docker container
``` sh
./RUN-DOCKER-CONTAINER.sh
```

### 4. Build ROS 2 environment inside container
``` sh
ppl-cc-build-workspace
```

### Deleting Containers
To delete all docker containers (docker cache) run:
``` sh
docker system prune -a
```
## ROS 2 Tutorials

### 