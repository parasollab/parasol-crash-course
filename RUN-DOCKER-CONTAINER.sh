#!/bin/bash

################################################################################

# Set the Docker container name from a project name (first argument).
# If no argument is given, use the current user name as the project name.
PROJECT=$1
if [ -z "${PROJECT}" ]; then
  PROJECT=${USER}
fi
CONTAINER="${PROJECT}-ppl-crash-course-1"
echo "$0: PROJECT=${CONTAINER}"
# Run the Docker container in the background.
# Any changes made to './docker/docker-compose.yml' will recreate and overwrite the container.
docker compose -p ${PROJECT} -f ./docker/docker-compose.yml up -d

################################################################################

# Display GUI through X Server by granting full access to any external client.
HOST_IP=$(ipconfig getifaddr en0)
xhost +
# xhost +local:root

################################################################################

# Enter the Docker container with a Bash shell (with or without a custom).
case "$3" in
  ( "" )
  case "$2" in
    ( "" )
    docker exec -e DISPLAY=${HOST_IP}:0 -i -t ${CONTAINER} bash
    ;;
    ( * )
    docker exec -e DISPLAY=${HOST_IP}:0 -i -t ${CONTAINER} bash -i -c "~/ppl_cc_ws/docker/ppl-crash-course/scripts/run-command-repeatedly.sh $2"
  esac
  ;;
  ( *".launch")
  docker exec -e DISPLAY=${HOST_IP}:0 -i -t ${CONTAINER} bash -i -c "~/ppl_cc_ws/docker/ppl-crash-course/scripts/run-ros2-launch-repeatedly.sh $2 $3"
  ;;
  ( * )
  echo "Failed to enter the Docker container '${CONTAINER}': '$3' is not a valid argument value (needs to be a launch file or empty)."
  ;;
esac