#!/bin/bash

# Install optional packages/tools.
sudo apt-get update && sudo apt-get install -y --no-install-recommends \
    inetutils-ping \
    iproute2 \
    gdb \
    gdbserver \
    mesa-utils \
    nano \
    net-tools \
    openssh-client \
    unzip \
    vim \
    less \
    usbutils \
    && rm -rf /var/lib/apt/lists/*

cd /home/ubuntu

mkdir -p /home/ubuntu/ppl_cc_ws/src

cd /home/ubuntu/ppl_cc_ws/src

# Clone Moveit2 source code
git clone https://github.com/imngui/moveit2.git -b iron
for repo in moveit2/moveit2.repos $(f="moveit2/moveit2_iron.repos"; test -r $f && echo $f); do vcs import < "$repo"; done

# Clone MoveIt2 tutorials
git clone https://github.com/Parasol-Lab-Crash-Course-Summer-2024/moveit2_tutorials.git
vcs import < moveit2_tutorials/moveit2_tutorials.repos

# Clone UR Description package
git clone https://github.com/UniversalRobots/Universal_Robots_ROS2_Description.git -b iron

# Clone UR Robot Driver package
git clone https://github.com/UniversalRobots/Universal_Robots_ROS2_Driver -b iron

# Clone Robotiq Gripper package
git clone https://github.com/PickNikRobotics/ros2_robotiq_gripper.git
vcs import < ros2_robotiq_gripper/ros2_robotiq_gripper.iron.repos

# Clone TB3 package
git clone -b ros2-devel https://github.com/ROBOTIS-GIT/DynamixelSDK.git
git clone -b ros2-devel https://github.com/ROBOTIS-GIT/turtlebot3_msgs.git
git clone -b ros2-devel https://github.com/ROBOTIS-GIT/turtlebot3.git
git clone -b ros2-devel https://github.com/ROBOTIS-GIT/turtlebot3_simulations.git
sudo apt-get update && sudo apt-get install -y --no-install-recommends \
	ros-iron-gazebo-* ros-iron-cartographer ros-iron-cartographer-ros \
	ros-iron-navigation2 ros-iron-nav2-bringup

# Clone ppl-ros2-env package
git clone https://github.com/parasollab/ppl-ros2-env.git -b turtlebot3

# Clone ppl-ros package
git clone https://github.com/parasollab/ppl-ros.git

echo "\nsource /home/ubuntu/install/setup.bash" >> /home/ubuntu/.bashrc
echo "\nexport ROS_DOMAIN_ID=12" >> /home/ubuntu/.bashrc
echo "\nsource /home/ubuntu/ppl_cc_ws/install/setup.bash" >> /home/ubuntu/.bashrc
