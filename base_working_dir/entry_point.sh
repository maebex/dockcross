#!/bin/bash


echo "STARTING COMPILATION"


#echo "$(dpkg -l | grep libopencv)"
#echo "$(dpkg -l | grep libc6)"
#cd /home
#ls


export MY_ARCH="$1"
echo "entry_point: MY_ARCH: ${MY_ARCH}"
export MY_PROJECT_NAME="$2"
echo "entry_point: MY_PROJECT_NAME: ${MY_PROJECT_NAME}"
export DENKREMENT_DEV_PATH="$3"
echo "entry_point: DENKREMENT_DEV_PATH: ${DENKREMENT_DEV_PATH}"

cd base_working_dir/${MY_PROJECT_NAME}/cmake_tools

./config.sh ${1} ${2} ${3}  # DenKrement dev path is only used if necessary
./build.sh ${1} ${2} ${3}  # DenKrement dev path is only used if necessary
