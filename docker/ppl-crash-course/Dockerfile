FROM ubuntu:22.04

# Avoid user interaction during install of tzdata
# https://askubuntu.com/questions/909277/avoiding-user-interaction-with-tzdata-when-installing-certbot-in-a-docker-contai
ENV TZ=US
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

################################################################################

# Install ROS 2 Iron Irwini

# Set the locale
RUN apt-get update && apt-get install -q -y --no-install-recommends \
    locales \
    && rm -rf /var/lib/apt/lists/*
RUN locale-gen en_US en_US.UTF-8
RUN update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

# Setup required repositories
RUN apt-get update && apt-get install -q -y --no-install-recommends \
    software-properties-common \
    && rm -rf /var/lib/apt/lists/*

RUN add-apt-repository universe

# Install optional packages/tools.
RUN apt-get update && apt-get install -y --no-install-recommends \
    inetutils-ping \
    iproute2 \
    gdb \
    mesa-utils \
    nano \
    net-tools \
    openssh-client \
    unzip \
    vim \
    less \
    usbutils \
    && rm -rf /var/lib/apt/lists/*

# # Update cache and install VS Code as a package.
# RUN apt-get update && apt-get install -y --no-install-recommends \
#     code \
# 	&& rm -rf /var/lib/apt/lists/*



# Setup sources.list and keys
RUN apt update && apt-get install -q -y --no-install-recommends \
    curl \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*
# RUN update-ca-certificates
RUN curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | tee /etc/apt/sources.list.d/ros2.list > /dev/null

ENV ROS_DISTRO=iron

# Install ROS 2 packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    ros-dev-tools \
    ros-iron-desktop \
    ros-iron-rmw-cyclonedds-cpp \
    && rm -rf /var/lib/apt/lists/*

RUN echo "export RMW_IMPLEMENTATION=rmw_cyclonedds_cpp" >> /root/.bashrc

# Install required packages/tools/dependencies for subsequent installations.
RUN apt-get update && apt-get install -y --no-install-recommends \
    apt-transport-https \
    wget \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-cache policy git
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    cmake \
    git \
    python3-pip \
    python3-colcon-common-extensions \
    python3-flake8 \
    python3-rosdep \
    python3-setuptools \
    python3-vcstool \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Prepare setup for ROS 2 workspace
RUN apt-get update && rosdep init && rosdep update
RUN echo "source /opt/ros/iron/setup.bash" >> /root/.bashrc
RUN apt-get update && apt-get remove -y --no-install-recommends \
    ros-iron-moveit* \
    && rm -rf /var/lib/apt/lists/*

# Create workspace
RUN mkdir -p /root/ppl_cc_ws/src

# Change working directory
WORKDIR /root/ppl_cc_ws/src

# Clone Moveit2 source code
RUN git clone https://github.com/imngui/moveit2.git -b iron
RUN for repo in moveit2/moveit2.repos $(f="moveit2/moveit2_iron.repos"; test -r $f && echo $f); do vcs import < "$repo"; done

# Clone MoveIt2 tutorials
RUN git clone https://github.com/Parasol-Lab-Crash-Course-Summer-2024/moveit2_tutorials.git
RUN vcs import < moveit2_tutorials/moveit2_tutorials.repos

# Clone UR Description package
RUN git clone https://github.com/UniversalRobots/Universal_Robots_ROS2_Description.git -b iron

# Clone UR Robot Driver package
RUN git clone https://github.com/UniversalRobots/Universal_Robots_ROS2_Driver -b iron

# Clone Robotiq Gripper package
RUN git clone https://github.com/PickNikRobotics/ros2_robotiq_gripper.git
WORKDIR /root/ppl_cc_ws/src/ros2_robotiq_gripper
RUN vcs import < ros2_robotiq_gripper.iron.repos

# Clone TB3 package
WORKDIR /root/ppl_cc_ws/src
RUN git clone -b ros2-devel https://github.com/ROBOTIS-GIT/DynamixelSDK.git
RUN git clone -b ros2-devel https://github.com/ROBOTIS-GIT/turtlebot3_msgs.git
RUN git clone -b ros2-devel https://github.com/ROBOTIS-GIT/turtlebot3.git
RUN git clone -b ros2-devel https://github.com/ROBOTIS-GIT/turtlebot3_simulations.git
RUN apt-get update && apt-get install -y --no-install-recommends \
	ros-iron-gazebo-* ros-iron-cartographer ros-iron-cartographer-ros \
	ros-iron-navigation2 ros-iron-nav2-bringup

# Clone ppl-ros2-env package
RUN git clone https://github.com/parasollab/ppl-ros2-env.git -b turtlebot3

# Clone ppl-ros package
RUN git clone https://github.com/parasollab/ppl-ros.git

# Install package dependencies
WORKDIR /root/ppl_cc_ws
# RUN apt-get update && rosdep install -r --from-paths . --ignore-src --rosdistro iron -y

# Copy the helper scripts to the working directory.
COPY ./docker/ppl-crash-course/scripts/. /root/ppl_cc_ws/docker/ppl-crash-course/scripts/
RUN chmod -R +x /root/ppl_cc_ws/docker/ppl-crash-course/scripts/*

COPY ./requirements.txt /root/ppl_cc_ws/
RUN pip3 install -r requirements.txt

# Setup the Bash shell environment with '/root/.bashrc'.
RUN echo "source /root/ppl_cc_ws/docker/ppl-crash-course/scripts/initialize-bash-shell.sh" >> /root/.bashrc
RUN echo "\nsource /root/ppl_cc_ws/install/setup.bash" >> /root/.bashrc
RUN echo "\n export ROS_DOMAIN_ID=12" >> /root/.bashrc

# RUN colcon build --merge-install --symlink-install --cmake-args "-DCMAKE_BUILD_TYPE=Release"

# Force color prompt in terminal.
RUN sed -i 's/#force_color_prompt=yes/force_color_prompt=yes/' /root/.bashrc

# Overwrite the entry point of the parent image.
ENTRYPOINT []

# Enter the container with a Bash shell.
CMD ["/bin/bash"]
