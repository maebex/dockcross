#! /bin/bash


export MY_ARCH="$1"
echo "settings: MY_ARCH: ${MY_ARCH}"

export DENKREMENT_DEV_PATH="$3"
echo "settings: DENKREMENT_DEV_PATH: ${DENKREMENT_DEV_PATH}"

# CMAKE EXECUTABLE
# set a standard CMAKe path
#export PATH_TO_CMAKE=/home/max/cmake-3.20.2-linux-x86_64/bin/cmake
CMAKE_PATH=cmake
echo "CMAKE_PATH: $CMAKE_PATH"

# user prompt if no cmake command exists or no cmake executable can be found at specified location
if   ! command -v $CMAKE_PATH &> /dev/null ;then
    echo "Can not find Cmake executable at specified location."
    echo -e "Enter path to your CMake executable  ${YELLOW}(tilde/~ as alias for your home directory is not supported)${NC}: "
    read -e CMAKE_PATH
    echo $CMAKE_PATH
    # check if existent and executable
    if [ ! -x "$CMAKE_PATH" ]; then
        echo -e "[${RED} Cannot find file or it does not have execution permission granted.${NC}]"
    fi
fi

# SOURCE PATH
export SOURCE_PATH=../src/

# BUILD PATH
export BUILD_PATH=../build/${MY_ARCH}


# RUN AS TEST
# uncomment this if you do not want to run a tes1
export TESTS_PATH=../tests

# EXECUTABLE NAME
export EXE_NAME=main

# COMPILE AS SHARE LIB
export COMPILE_AS_SHARED=1
export MAJOR_VERSION_NUM=1
export MINOR_VERSION_NUM=1
export PATCH_NUM=1


# COMPILE AS STATIC LIB
export COMPILE_AS_STATIC=1



