#! /bin/bash

# Defines all relevant absolute directories
# assuming that variables.sh is in the same directory as is this file
source settings.sh

echo ""
echo ""
echo "%%%%%%%%%%%%%%%%%%%%%%%"
echo " > RUN"
echo "%%%%%%%%%%%%%%%%%%%%%%%"
echo ""

cd $BUILD_PATH ; ./$EXE_NAME
