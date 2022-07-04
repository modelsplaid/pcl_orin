set(SUBSYS_NAME cuda_features)
set(SUBSYS_PATH cuda/features)
set(SUBSYS_DESC "Point Cloud CUDA Feature Estimation library")
set(SUBSYS_DEPS cuda_common io common)
message("+++++++++++++++++start cuda features cmake++++++++++++++++++++++++")
message("+++++++++++++++++start cuda features cmake++++++++++++++++++++++++")
message("+++++++++++++++++start cuda features cmake++++++++++++++++++++++++")
# ---[ Point Cloud Library - pcl/cuda/io

set(build TRUE)
PCL_SUBSYS_OPTION(build "${SUBSYS_NAME}" "${SUBSYS_DESC}" ON)
mark_as_advanced("BUILD_${SUBSYS_NAME}")
PCL_SUBSYS_DEPEND(build "${SUBSYS_NAME}" DEPS ${SUBSYS_DEPS})
PCL_SET_SUBSYS_INCLUDE_DIR("${SUBSYS_NAME}" "${SUBSYS_PATH}")

if(NOT build)
  return()
endif()

set(srcs
  src/normal_3d.cu
)

set(incs
  include/pcl/cuda/features/normal_3d.h
)


###########################################################################3
############################################################################
set(ORIN 1)
set(BUILD_TARGET "orin")
set(PATH_OF_TOOLCHAINS /home/tzq/disk2/pc_share/yh-orin/toolchains/aarch64--glibc--stable-2020.08-1/bin)
if(${BUILD_TARGET} MATCHES orin)
  message("+++compile in orin")
  #add_definitions(-D_EMBEDDED_ARM64_)
  #set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -w -O3 -Wno-dev" )
  set(CMAKE_C_COMPILER ${PATH_OF_TOOLCHAINS}/aarch64-buildroot-linux-gnu-gcc)
  set(CMAKE_CXX_COMPILER  ${PATH_OF_TOOLCHAINS}/aarch64-buildroot-linux-gnu-g++)
  message("---PATH_OF_TOOLCHAINS: ${PATH_OF_TOOLCHAINS}")
endif()

add_definitions(-D_EMBEDDED_ARM64_)
set(CMAKE_C_COMPILER ${PATH_OF_TOOLCHAINS}/aarch64-buildroot-linux-gnu-gcc)
set(CMAKE_CXX_COMPILER  ${PATH_OF_TOOLCHAINS}/aarch64-buildroot-linux-gnu-g++)


set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS}   -Wall -D_LARGE_FILE -fPIC")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS}   -std=gnu++14 -Wall -D_LARGE_FILE -fPIC")
set(THIRD_LIBS
    -pthread 
    )


include_directories(/home/tzq/disk2/pc_share/yh-orin/lib/3rdparty/boost1.71.0/include)
SET(CUDA_TOOLKIT_ROOT_DIR /home/tzq/disk2/pc_share/cuda-11.4)
SET(CUDA_SEPARABLE_COMPILATION ON)
#find_package(CUDA 11.4 REQUIRED)
message("++++++++CUDA_INCLUDE_DIRS" ${CUDA_INCLUDE_DIRS})
message("++++++++GLOB CUDA_LIBRARIES" ${CUDA_LIBRARIES})    
#include_directories(/home/tzq/disk2/pc_share/cuda-11.4/targets/aarch64-linux/include/crt)
set(CUDA_INCLUDE_DIRS /home/tzq/disk2/pc_share/cuda-11.4/targets/aarch64-linux/include)
include_directories(${CUDA_INCLUDE_DIRS})
set(CUDA_LIBRARIES_PATH /home/tzq/disk2/pc_share/cuda-11.4/targets/aarch64-linux/lib)
file(GLOB CUDA_LIBRARIES "${CUDA_LIBRARIES_PATH}/*.so")  
set(CUDA_NVCC_FLAGS -arch=sm_87; -rdc=true; -lcudadevrt -lcudart -lcublas -shared -rdc=true)

# Set target C++ standard and required compiler features
set(CMAKE_CXX_STANDARD 14 CACHE STRING "The target C++ standard. PCL requires C++14 or higher.")
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
set(PCL_CXX_COMPILE_FEATURES cxx_std_14)

set(CMAKE_CUDA_STANDARD 14 CACHE STRING "The target CUDA/C++ standard. PCL requires CUDA/C++ 14 or higher.")
set(CMAKE_CUDA_STANDARD_REQUIRED ON)

##############################################
###############################################

set(LIB_NAME "pcl_${SUBSYS_NAME}")
include_directories("${CMAKE_CURRENT_SOURCE_DIR}/include")
message("ccccccccccccIn cuda/features/cmakelist: ${LIB_NAME} COMPONENT ${SUBSYS_NAME} SOURCES ${srcs} ${incs}")
message("ccccccccccccIn cuda/features/cmakelist: ${LIB_NAME} COMPONENT ${SUBSYS_NAME} SOURCES ${srcs} ${incs}")
PCL_CUDA_ADD_LIBRARY(${LIB_NAME} COMPONENT ${SUBSYS_NAME} SOURCES ${srcs} ${incs})

set(EXT_DEPS "")
#set(EXT_DEPS CUDA)
PCL_MAKE_PKGCONFIG(${LIB_NAME} COMPONENT ${SUBSYS_NAME} DESC ${SUBSYS_DESC} PCL_DEPS ${SUBSYS_DEPS} EXT_DEPS ${EXT_DEPS})

# Install include files
PCL_ADD_INCLUDES("${SUBSYS_NAME}" "${SUBSYS_PATH}" ${incs})

message("+++++++++++++++++done cuda features cmake++++++++++++++++++++++++")
message("+++++++++++++++++done cuda features cmake++++++++++++++++++++++++")
message("+++++++++++++++++done cuda features cmake++++++++++++++++++++++++")