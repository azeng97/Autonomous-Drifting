#!/bin/bash

#Install ROS
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
sudo -E apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
sudo apt-get update
sudo apt-get -y install ros-kinetic-desktop-full
sudo rosdep init
rosdep update
echo "source /opt/ros/kinetic/setup.bash" >> ~/.bashrc
source ~/.bashrc
sudo apt-get -y install python-rosinstall python-rosinstall-generator python-wstool build-essential

# Install Gazebo
# curl -ssL http://get.gazebosim.org | sh
sudo apt-get -y install gazebo7

# Install Gazebo-ROS bridge libs
sudo apt-get -y install libsdformat4 
sudo apt-get -y install libgazebo7
sudo apt-get -y install ros-kinetic-gazebo-ros
sudo apt-get -y install ros-kinetic-gazebo-ros-pkgs ros-kinetic-gazebo-ros-control
sudo apt-get -y install ros-kinetic-joint-state-controller
sudo apt-get -y install ros-kinetic-effort-controllers
sudo apt-get -y install ros-kinetic-joy
sudo apt-get -y install ros-kinetic-robot-localization

# Install pip
sudo apt-get -y install python-pip


# install cuDNN v6.0
# CUDNN_TAR_FILE="cudnn-8.0-linux-x64-v6.0.tgz"
# wget http://developer.download.nvidia.com/compute/redist/cudnn/v6.0/${CUDNN_TAR_FILE}
# tar -xzvf ${CUDNN_TAR_FILE}
# sudo cp -P cuda/include/cudnn.h /usr/local/cuda-8.0/include
# sudo cp -P cuda/likdb64/libcudnn* /usr/local/cuda-8.0/lib64/
# sudo chmod a+r /usr/local/cuda-8.0/lib64/libcudnn*

# set environment variables
# echo 'export CUDA_HOME=/usr/local/cuda-8.0' >> ~/.bashrc
# echo 'export PATH=$CUDA_HOME/bin:${PATH}' >> ~/.bashrc
# echo 'export LD_LIBRARY_PATH=/usr/local/cuda-8.0/lib64:${LD_LIBRARY_PATH}' >> ~/.bashrc
echo 'alias kd="killall -9 python || killall -9 roslaunch || killall -9 gzserver || killall -9 gzclient"' >> ~/.bashrc

source ~/.bashrc
