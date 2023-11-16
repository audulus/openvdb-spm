
rm -rf tbb
rm -f v2021.10.0.tar.gz

export root=`pwd`

# see https://github.com/Homebrew/homebrew-core/blob/5401dd66d7c7091ab20dcd46efc9ae64eb2b852e/Formula/t/tbb.rb

wget https://github.com/oneapi-src/oneTBB/archive/refs/tags/v2021.10.0.tar.gz
tar zxf v2021.10.0.tar.gz
mv oneTBB-2021.10.0 tbb 

cd tbb

mkdir build && cd build
cmake -DCMAKE_INSTALL_PREFIX=$root/install-macos \
      -DBUILD_SHARED_LIBS=OFF \
      ..
make -j 12 install
cd ..
rm -rf build

mkdir build-ios && cd build-ios
cmake -DCMAKE_INSTALL_PREFIX=$root/install-ios \
      -DCMAKE_SYSTEM_NAME=iOS \
      -DCMAKE_OSX_DEPLOYMENT_TARGET=11.0 \
      -DBUILD_SHARED_LIBS=OFF \
      ..
make -j 12 install target=ios
cd ..

mkdir build-ios-sim && cd build-ios-sim
cmake -DCMAKE_INSTALL_PREFIX=$root/install-ios-sim \
      -DCMAKE_TOOLCHAIN_FILE=../../ios.toolchain.cmake \
      -DCMAKE_SYSTEM_NAME=iOS-Simulator \
      -DPLATFORM=SIMULATORARM64 \
      -DBUILD_SHARED_LIBS=OFF \
      -DTBB_TEST=OFF \
      ..
make -j 12 install target=ios-simulator
cd ..

cd ..
rm -rf tbb v2021.10.0.tar.gz
