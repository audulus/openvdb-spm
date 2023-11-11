
set -e
set -x

rm -rf openvdb 
rm -rf openvdb.xcframework

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

xcodebuild -create-xcframework \
           -library install-macos/lib/libopenvdb.11.0.0.dylib \
           -headers install-macos/include/openvdb \
           -library install-ios/lib/libopenvdb.11.0.0.dylib \
           -headers install-ios/include/openvdb \
           -output openvdb.xcframework

# iOS build
# mkdir build_ios
# cd build_ios

# from https://cmake.org/cmake/help/latest/manual/cmake-toolchains.7.html#cross-compiling-for-ios-tvos-or-watchos
# make -GXcode \
#      -DCMAKE_SYSTEM_NAME=iOS \
#     "-DCMAKE_OSX_ARCHITECTURES=arm64;x86_64" \
#      -DCMAKE_OSX_DEPLOYMENT_TARGET=11.0 \
#      -DCMAKE_XCODE_ATTRIBUTE_ONLY_ACTIVE_ARCH=NO \
#      -DCMAKE_IOS_INSTALL_COMBINED=YES \
#      -DBUILD_SHARED_LIBS=NO \
#      -DBUILD_STATIC_LIBS=YES \
#      -DBoost_NO_SYSTEM_PATHS=YES \
#      -DBOOST_INCLUDEDIR=../../boost \
#      -DBOOST_LIBRARYDIR=../../boost/stage/lib \
#      .. 
# 
# codebuild -configuration Release install
# codebuild -configuration Release -sdk iphonesimulator install
# 
# d ..
# 
#  move libraries into place
# kdir libs
# ibtool -o libs/openvdb_macos.a build/*.a
# ibtool -o libs/openvdb_ios.a build_ios/build/UninstalledProducts/iphoneos/*.a
# ibtool -o libs/openvdb_ios_simulator.a build_ios/build/UninstalledProducts/iphonesimulator/*.a
# 
# codebuild -create-xcframework \
#           -library libs/openvdb_macos.a \
#           -headers build/install/include \
#           -library libs/openvdb_ios.a \
#           -headers build/install/include \
#           -library libs/openvdb_ios_simulator.a \
#           -headers build/install/include \
#           -output openvdb.xcframework
# 
# v openvdb.xcframework ..
# d ..

