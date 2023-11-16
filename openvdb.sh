set -euxo pipefail

rm -rf openvdb-11.0.0
rm -f v11.0.0.tar.gz

export root=`pwd`

wget https://github.com/AcademySoftwareFoundation/openvdb/archive/refs/tags/v11.0.0.tar.gz
tar zxf v11.0.0.tar.gz
cd openvdb-11.0.0

# macOS build
mkdir build
cd build
cmake -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_OSX_DEPLOYMENT_TARGET=11.0 \
      -DCMAKE_INSTALL_PREFIX=$root/install-macos \
      -DCMAKE_PREFIX_PATH=$root/install-macos \
      -DOPENVDB_BUILD_BINARIES=OFF \
      -DOPENVDB_CORE_SHARED=OFF \
      ..
make -j12 install
cd ..

# iOS build
mkdir build-ios
cd build-ios
cmake -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_SYSTEM_NAME=iOS \
      -DCMAKE_OSX_DEPLOYMENT_TARGET=12.0 \
      -DCMAKE_TOOLCHAIN_FILE=../../ios.toolchain.cmake \
      -DBUILD_SHARED_LIBS=OFF \
      -DPLATFORM=OS64 \
      -DDEPLOYMENT_TARGET=16.0 \
      -DCMAKE_INSTALL_PREFIX=$root/install-ios \
      -DCMAKE_PREFIX_PATH=$root/install-ios \
      -DOPENVDB_BUILD_BINARIES=OFF \
      -DOPENVDB_CORE_SHARED=OFF \
      ..
make -j12 install
cd ..

# iOS simulator build
mkdir build-ios-sim
cd build-ios-sim
cmake -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_SYSTEM_NAME=iOS \
      -DCMAKE_OSX_DEPLOYMENT_TARGET=12.0 \
      -DCMAKE_TOOLCHAIN_FILE=../../ios.toolchain.cmake \
      -DPLATFORM=SIMULATORARM64 \
      -DDEPLOYMENT_TARGET=16.0 \
      -DCMAKE_INSTALL_PREFIX=$root/install-ios-sim \
      -DCMAKE_PREFIX_PATH=$root/install-ios-sim \
      -DOPENVDB_BUILD_BINARIES=OFF \
      -DOPENVDB_CORE_SHARED=OFF \
      ..
make -j12 install
cd ..