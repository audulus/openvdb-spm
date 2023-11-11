
rm -rf c-blosc-1.21.5 v1.21.5.tar.gz

wget https://github.com/Blosc/c-blosc/archive/refs/tags/v1.21.5.tar.gz
tar zxf v1.21.5.tar.gz

export prefix=`pwd`

cd c-blosc-1.21.5

mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFIX=$prefix/install-macos ..
cmake --build . --target install
cd ..

mkdir build-ios
cd build-ios
cmake -DCMAKE_INSTALL_PREFIX=$prefix/install-ios \
      -DCMAKE_SYSTEM_NAME=iOS \
      -DCMAKE_OSX_DEPLOYMENT_TARGET=11.0 \
      -DCMAKE_TOOLCHAIN_FILE=../../ios.toolchain.cmake \
      -DPLATFORM=OS64 \
      ..
cmake --build . --target install
cd ..

rm -rf c-blosc-1.21.5 v1.21.5.tar.gz