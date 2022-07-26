#! /bin/bash

# Defines all relevant absolute directories
# assuming that variables.sh is in the same directory as is this file

source settings.sh

echo ""
echo ""
echo "%%%%%%%%%%%%%%%%%%%%%%%"
echo " > CONFIG"
echo "%%%%%%%%%%%%%%%%%%%%%%%"
echo ""
echo "-----------------------------------------"
echo ""
echo "Exported variables:"
echo ""
echo "CMAKE_PATH: $CMAKE_PATH"
echo "SOURCE_PATH: $SOURCE_PATH"
if [ ${#TESTS_PATH} -gt 0 ];then
    echo "Running as a test"
    echo "TESTS_PATH: ${TESTS_PATH}"    
fi
echo "BUILD_PATH: $BUILD_PATH"
echo "EXE_NAME: $EXE_NAME"
echo "COMPILE_AS_SHARED: $COMPILE_AS_SHARED"
if [ $COMPILE_AS_SHARED -eq 1 ];then
    VERSION_NUM=$MAJOR_VERSION_NUM.$MINOR_VERSION_NUM.$PATCH_NUM
    echo "VERSION: $VERSION_NUM  !!! TODO !!!"
fi
echo "COMPILE_AS_STATIC: $COMPILE_AS_STATIC"
echo ""
echo "-----------------------------------------"
echo ""

export MY_ARCH="$1"
echo "config: MY_ARCH: ${MY_ARCH}"
export MY_PROJECT_NAME="$2"
echo "config: MY_PROJECT_NAME: ${MY_PROJECT_NAME}"
export DENKREMENT_DEV_PATH="$3"
echo "config: DENKREMENT_DEV_PATH: ${DENKREMENT_DEV_PATH}"

$CMAKE_PATH -DSHAREDLIB:INT="$COMPILE_AS_SHARED" -DVERS_POSTFIX:STRING="$VERSION_NUM" -DSTATICLIB:INT="$COMPILE_AS_STATIC" -DTESTS_PATH:STRING="$TESTS_PATH" -DDENKREMENT_DEV_PATH:STRING="$DENKREMENT_DEV_PATH" -DMY_ARCH:STRING="$MY_ARCH" -S $SOURCE_PATH -B $BUILD_PATH 








