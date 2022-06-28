set(SUBSYS_NAME gpu)
set(SUBSYS_DESC "Point cloud GPU libraries")
set(SUBSYS_DEPS)

option(BUILD_GPU "Build the GPU-related subsystems" ${DEFAULT})

if(NOT (BUILD_GPU AND CUDA_FOUND))
  return()
endif()

if(CMAKE_COMPILER_IS_GNUCXX)
  string(REPLACE "-Wold-style-cast" "" CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS}")
  string(REPLACE "-Wno-invalid-offsetof" "" CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS}")
  string(APPEND CMAKE_CXX_FLAGS " -Wno-conversion -Wno-unused-parameter -Wno-unused-variable -Wno-unused-function -Wno-unused-but-set-variable")
  # allow deprecation warnings in Eigen(3.3.7)/Core, see here: https://gitlab.kitware.com/vtk/vtk/-/issues/17661
  string(APPEND CMAKE_CXX_FLAGS " -Wno-error=cpp")
  # allow maybe-uninitialized warnings from thrust library.
  string(APPEND CMAKE_CXX_FLAGS " -Wno-error=maybe-uninitialized")
endif()

###########################################################################3
############################################################################
if(${BUILD_TARGET} MATCHES orin)
  message("+++compile in orin")
  #add_definitions(-D_EMBEDDED_ARM64_)
  #set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -w -O3 -Wno-dev" )
  set(CMAKE_C_COMPILER ${PATH_OF_TOOLCHAINS}/aarch64-buildroot-linux-gnu-gcc)
  set(CMAKE_CXX_COMPILER  ${PATH_OF_TOOLCHAINS}/aarch64-buildroot-linux-gnu-g++)
endif()

add_definitions(-D_EMBEDDED_ARM64_)
set(CMAKE_C_COMPILER ${PATH_OF_TOOLCHAINS}/aarch64-buildroot-linux-gnu-gcc)
set(CMAKE_CXX_COMPILER  ${PATH_OF_TOOLCHAINS}/aarch64-buildroot-linux-gnu-g++)


set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS}   -Wall -D_LARGE_FILE")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS}   -std=gnu++11 -Wall -D_LARGE_FILE")
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
set(CUDA_NVCC_FLAGS -arch=sm_87; -rdc=true; -lcudadevrt -lcudart -lcublas)

# Set target C++ standard and required compiler features
set(CMAKE_CXX_STANDARD 14 CACHE STRING "The target C++ standard. PCL requires C++14 or higher.")
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
set(PCL_CXX_COMPILE_FEATURES cxx_std_14)

set(CMAKE_CUDA_STANDARD 14 CACHE STRING "The target CUDA/C++ standard. PCL requires CUDA/C++ 14 or higher.")
set(CMAKE_CUDA_STANDARD_REQUIRED ON)

##############################################
###############################################

collect_subproject_directory_names("${CMAKE_CURRENT_SOURCE_DIR}" "CMakeLists.txt" PCL_GPU_MODULES_NAMES PCL_GPU_MODULES_DIRS)
set(PCL_GPU_MODULES_NAMES_UNSORTED ${PCL_GPU_MODULES_NAMES})
topological_sort(PCL_GPU_MODULES_NAMES PCL_ _DEPENDS)
sort_relative(PCL_GPU_MODULES_NAMES_UNSORTED PCL_GPU_MODULES_NAMES PCL_GPU_MODULES_DIRS)
foreach(subdir ${PCL_GPU_MODULES_DIRS})
  add_subdirectory("${CMAKE_CURRENT_SOURCE_DIR}/${subdir}")
endforeach()
