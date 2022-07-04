export PKG_CONFIG_PATH=${PKG_CONFIG_PATH}:/home/tzq/disk2/pc_share/yh-orin/lib/3rdparty/flann1.9.1/lib/pkgconfig
export PKG_CONFIG_PATH=${PKG_CONFIG_PATH}:/home/tzq/disk2/pc_share/yh-orin/lib/3rdparty/eigen3.3.4/share/pkgconfig
export PATH=${PATH}:"/usr/local/cuda-11.4/bin"
export ORIN_CFG_PATH=/home/tzq/disk2/pc_share/yh-orin
export ORIN_THIRD_PARTY=${ORIN_CFG_PATH}/lib/3rdparty
export Boost_DIR=${ORIN_THIRD_PARTY}/boost1.71.0
export flann_DIR=${ORIN_THIRD_PARTY}/flann1.9.1
export CUDA_SDK_ROOT_DIR=/home/tzq/disk2/pc_share/cuda-11.4
#mkdir -p build2
cd build2
cmake -DWITH_OPENMP=OFF -DWITH_OPENGL=OFF -DWITH_VTK=OFF -DWITH_QT=OFF -DWITH_PCAP=OFF -DWITH_LIBUSB=OFF -DWITH_PNG=OFF -DWITH_QHULL=OFF -DWITH_CUDA=ON -DWITH_OPENNI=OFF -DWITH_OPENNI2=OFF -DBUILD_CUDA=ON -DBUILD_GPU=ON  -DCUDA_HOST_COMPILER=/home/tzq/disk2/pc_share/yh-orin/toolchains/aarch64--glibc--stable-2020.08-1/bin/aarch64-buildroot-linux-gnu-g++ -DCUDA_rt_LIBRARY=/home/tzq/disk2/pc_share/yh-orin/toolchains/aarch64--glibc--stable-2020.08-1/aarch64-buildroot-linux-gnu/sysroot/usr/lib/librt.so  -DCMAKE_INSTALL_PREFIX=/home/tzq/disk2/pcl_orin/pcl12/pcl_orin/install2 ..

#make 

# todo: 1. add -fpic in cXX flags, 2. add -rdc=true in cuda flags (https://forums.developer.nvidia.com/t/linking-device-code/35793/3)
