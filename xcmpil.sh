export PKG_CONFIG_PATH=${PKG_CONFIG_PATH}:/home/tzq/disk2/pc_share/yh-orin/lib/3rdparty/flann1.9.1/lib/pkgconfig
export PKG_CONFIG_PATH=${PKG_CONFIG_PATH}:/home/tzq/disk2/pc_share/yh-orin/lib/3rdparty/eigen3.3.4/share/pkgconfig
export PATH=${PATH}:"/usr/local/cuda-11.4/bin"
export ORIN_CFG_PATH=/home/tzq/disk2/pc_share/yh-orin
export ORIN_THIRD_PARTY=${ORIN_CFG_PATH}/lib/3rdparty
export Boost_DIR=${ORIN_THIRD_PARTY}/boost1.71.0
export flann_DIR=${ORIN_THIRD_PARTY}/flann1.9.1
mkdir -p build
cd build
rm -rf *
cmake -DWITH_OPENMP=OFF -DWITH_OPENGL=OFF -DWITH_VTK=OFF -DWITH_QT=OFF -DWITH_PCAP=OFF -DWITH_LIBUSB=OFF -DWITH_PNG=OFF -DWITH_QHULL=OFF -DWITH_CUDA=ON -DWITH_OPENNI=OFF -DWITH_OPENNI2=OFF .. 
make  
