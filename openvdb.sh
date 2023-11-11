set -euxo pipefail

rm -rf openvdb-11.0.0
rm -f v11.0.0.tar.gz

export prefix=`pwd`

wget https://github.com/AcademySoftwareFoundation/openvdb/archive/refs/tags/v11.0.0.tar.gz
tar zxf v11.0.0.tar.gz
cd openvdb-11.0.0

# macOS build
mkdir build
cd build
cmake -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_OSX_DEPLOYMENT_TARGET=11.0 \
      -DCMAKE_INSTALL_PREFIX=$prefix/install-macos \
      -DCMAKE_PREFIX_PATH=$prefix/install-macos \
      -DOPENVDB_BUILD_BINARIES=OFF \
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
      -DPLATFORM=OS64 \
      -DDEPLOYMENT_TARGET=16.0 \
      -DCMAKE_INSTALL_PREFIX=$prefix/install-ios \
      -DCMAKE_PREFIX_PATH=$prefix/install-ios \
      -DOPENVDB_BUILD_BINARIES=OFF \
      ..
make -j12 install
cd ..