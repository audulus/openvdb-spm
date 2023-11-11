
set -e
set -x

rm -rf openvdb 
rm -rf openvdb.xcframework

rm -rf openvdb-11.0.0
rm -f v11.0.0.tar.gz

wget https://github.com/AcademySoftwareFoundation/openvdb/archive/refs/tags/v11.0.0.tar.gz
tar zxf v11.0.0.tar.gz
cd openvdb-11.0.0

# macOS build
mkdir build
cd build
cmake -DCMAKE_BUILD_TYPE=Release \
      "-DCMAKE_OSX_ARCHITECTURES=arm64;x86_64" \
      -DCMAKE_OSX_DEPLOYMENT_TARGET=11.0 \
      -DCMAKE_INSTALL_PREFIX="$(pwd)/install" \
      -DCMAKE_PREFIX_PATH=/Users/holliday/openvdb-spm \
      ..
make -j8 install
cd ..

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

