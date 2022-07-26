#
#
## TOP LEVEL CMakeLists
#
#
cmake_minimum_required (VERSION 3.13)


# PROJECT NAME
project( example_project )
message( STATUS "> CMAKE_PROJECT_NAME: ${CMAKE_PROJECT_NAME}" )


# X-COMPILATION FLAG
set( X_COMPILE "0" CACHE STRING "Cross compilation option - 0:=no X-compilation | 1:=X-compile arm64 | 2=X-compile arm32 | ... (no more specified yet)" )
message( STATUS "> X-COMPILATION OPTION: ${X_COMPILE}" )


# HERE YOU CAN SPECIFY YOUR SETTINGS FOR CROSS COMPILATION PROCEDURE
if ( ${X_COMPILE} EQUAL 0 )
    message( STATUS "No X-Compilation" )
else()
    #elseif ( ${X_COMPILE} EQUAL 1 )
    message( STATUS " " )
    message( STATUS "---- START X COMPILATION SETTINGS ----" )

    # CMake-identifier of the target platform to build for
    set( CMAKE_SYSTEM_NAME Linux )
    message( STATUS "> CMAKE_SYSTEM_NAME: ${CMAKE_SYSTEM_NAME}" )

    # CMake-identifier of the target architecture to build for
    set( CMAKE_SYSTEM_PROCESSOR arm )
    message( STATUS "> CMAKE_SYSTEM_PROCESSOR: ${CMAKE_SYSTEM_PROCESSOR}" )

    # optional, and may be specified if a sysroot is available
    set(CMAKE_SYSROOT NO_SET )
    message( STATUS "> CMAKE_SYSROOT: ${CMAKE_SYSROOT}" )

    # optional. It may be used to specify a path on the host to install to.
    #The CMAKE_INSTALL_PREFIX is always the runtime installation location, even when cross-compiling.
    set(CMAKE_STAGING_PREFIX NO_SET )
    message( STATUS "> CMAKE_STAGING_PREFIX: ${CMAKE_STAGING_PREFIX}" )

    # variables may be set to full paths, or to names of compilers to search for in standard locations.
    # For toolchains that do not support linking binaries without custom flags or scripts one may set 
    # the CMAKE_TRY_COMPILE_TARGET_TYPE variable to STATIC_LIBRARY to tell CMake not to try to link executables
    # during its checks.
    set( tools /usr )
    if ( ${X_COMPILE} EQUAL 1 )
        set( CMAKE_C_COMPILER ${tools}/bin/aarch64-linux-gnu-gcc )
    elseif( ${X_COMPILE} EQUAL 2 )
        set( CMAKE_C_COMPILER ${tools}/bin/arm-linux-gnueabi-gcc )
    else()
        message( FATAL_ERROR "Unrecognized X-compile option" )
    endif()    
        
    set( CMAKE_CXX_COMPILER NO_SET )
    message( STATUS "> CMAKE_C_COMPILER: ${CMAKE_C_COMPILER}" )
    message( STATUS "> CMAKE_CXX_COMPILER: ${CMAKE_CXX_COMPILER}" )

    set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
    set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
    set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
    set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)

    message( STATUS "> CMAKE_FIND_ROOT_PATH_MODE_PROGRAM: ${CMAKE_FIND_ROOT_PATH_MODE_PROGRAM}" )
    message (STATUS "> CMAKE_FIND_ROOT_PATH_MODE_LIBRARY: ${CMAKE_FIND_ROOT_PATH_MODE_LIBRARY}" )
    message (STATUS "> CMAKE_FIND_ROOT_PATH_MODE_INCLUDE: ${CMAKE_FIND_ROOT_PATH_MODE_INCLUDE}" )
    message (STATUS "> CMAKE_FIND_ROOT_PATH_MODE_PACKAGE: ${CMAKE_FIND_ROOT_PATH_MODE_PACKAGE}" )

    message( STATUS "---- END X COMPILATION SETTINGS ----" )
    message( STATUS " " )
endif()


# TESTRUN OPTION
# this should only be used for libraries without an actual executable main file
# --> in ${TESTS_PATH}/main.c should be the overall test routine including all other relevant test files (from ${TEST_PATH}/include/)
string(LENGTH "${TESTS_PATH}" TESTS_PATH__STRINGLENGTH)
if (${TESTS_PATH__STRINGLENGTH} EQUAL 0)
    set( TESTRUN "0" )
    message( STATUS "> TESTRUN OPTION: 0" )
else()
    set( TESTRUN "1" )
    set( EXE_NAME "main_test.c" )
    message( STATUS "> TESTRUN OPTION: 1 | TESTS_PATH: ${TESTS_PATH} | EXE_NAME: ${EXE_NAME}" )
    add_executable( main ${TESTS_PATH}/${EXE_NAME} )
    target_include_directories( main PUBLIC ${TESTS_PATH}/include )    
endif()
unset( TESTS_PATH__STRINGLENGTH )


# SHARED LIBRARY OPTION
if (${SHAREDLIB} EQUAL 1)
    message( STATUS "> COMPILING AS SHARED LIBRARY | Version ${VERS_POSTFIX} TODO!!! VERSION NUMBER !!!" )
    add_library( ${CMAKE_PROJECT_NAME} SHARED example_source.c )
endif()


# STATIC LIBRARY OPTION
if (${STATICLIB} EQUAL 1)
    message( STATUS "< COMPILING AS SHARED LIBRARY" )
    add_library( ${CMAKE_PROJECT_NAME}_static STATIC example_source.c )
endif()


# -fPIC flag
# position independent code - enable this flag ifd you e.g. build a library that you want to execute somewhere else than wehere it's built
set(CMAKE_POSITION_INDEPENDENT_CODE ON)
message( STATUS "> CMAKE_POSITION_INDEPENDENT_CODE: ${CMAKE_POSITION_INDEPENDENT_CODE}" )


# GENERAL INCLUDE DIRECS   # TODO not good - do not use include_directories, use target_include_directories instead!!!
target_include_directories(  ${CMAKE_PROJECT_NAME} PUBLIC ../include  )

#
add_subdirectory( ../src/ )

## LINKER
set(SOME_LIB_DIREC "/usr/lib")
set SOME_LIB_NAME "somelib")
target_link_directories( ${CMAKE_PROJECT_NAME} PUBLIC  ${SOME_LIB_DIREC})
target_link_libraries( ${CMAKE_PROJECT_NAME ${SOME_LIB_NAME} )

message( STATUS " " )



