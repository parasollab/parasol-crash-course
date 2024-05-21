#!/bin/bash

################################################################################

# # Display information in CI for version traceability.
# if [[ "${CI}" == "true" ]]; then
#   echo -e "\n"
#   echo -e "######################## DEBUG DATA ########################"
#   echo -e "Current commit: $(cd /root/HSR/ && git rev-parse --short HEAD)"
#   echo -e "DOCKER_RUNTIME: $DOCKER_RUNTIME"
#   echo -e "DOCKER_IMAGE_VERSION: $DOCKER_IMAGE_VERSION"
#   echo -e "NVIDIA_CUDAGL_VERSION: $NVIDIA_CUDAGL_VERSION"
#   echo -e "NVIDIA_CUDNN_VERSION: $NVIDIA_CUDNN_VERSION"
#   echo -e "ROS_DESKTOP_VERSION: $ROS_DESKTOP_VERSION"
#   echo -e "ROS_TMC_VERSION: $ROS_TMC_VERSION"
#   echo -e "ROS_GAZEBO_VERSION: $ROS_GAZEBO_VERSION"
#   echo -e "PYTHON_PIP_VERSION: $PYTHON_PIP_VERSION"
#   echo -e "############################################################"
#   echo -e "\n"
# fi

# ################################################################################

# # Make additional preparations when inside the GitLab CI environement.
# if [ "${CI}" = "true" ]; then
#   # Terminate the script after the first failure and return non-zero exit code.
#   set -e

#   # Download and initialize all the Git submodules recursively.
#   # https://git-scm.com/book/en/v2/Git-Tools-Submodules
#   cd /root/o2ac-ur/ && git submodule update --init --recursive
# fi

################################################################################

# Download package lists from Ubuntu repositories.
apt-get update

# Install system dependencies required by specific ROS packages.
# http://wiki.ros.org/rosdep
# rosdep update

# Source the updated ROS environment.
source /opt/ros/iron/setup.bash

# FIXME: Setting PhoLocalization env variable manually seems to be required for ci.
#        Apparently it's not loaded correctly although the installation seems be complete.
# export PHO_LOCALIZATION_PATH=/opt/PhotoneoSDK/Localization

################################################################################

# Initialize the underlay workspace with wstool and install dependencies
# cd /root/o2ac-ur/underlay_ws/      && \
#     wstool update -t src --delete-changed-uris
cd /root/ppl_cc_ws

rosdep install -r --from-paths . --ignore-src --rosdistro iron -y > /dev/null 2>&1 || FAILED=true
# rosdep install --from-paths src --ignore-src -r -y > /dev/null 2>&1 || FAILED=true

if [ $FAILED ]; then
    echo "rosdep install failed"
fi

# Initialize, build and source the underlay workspace.
colcon build --symlink-install --cmake-args "-DCMAKE_BUILD_TYPE=Release"
source /root/ppl_cc_ws/install/setup.bash

################################################################################

# pip install -e /root/o2ac-ur/underlay_ws/src/ur_python_utilities/dependencies/tf2rl
# apt remove -y libcudnn8 && apt install -y libcudnn8=8.8.0.121-1+cuda11.8