
set -e
set -x

rm -rf openvdb 
rm -rf openvdb.xcframework

git clone https://github.com/AcademySoftwareFoundation/openvdb.git 
cd openvdb 
git checkout tags/v10.0.1

# macOS build
mkdir build
cd build
cmake -DCMAKE_BUILD_TYPE=Release \
      "-DCMAKE_OSX_ARCHITECTURES=arm64;x86_64" \
      -DCMAKE_OSX_DEPLOYMENT_TARGET=11.0 \
      -DCMAKE_INSTALL_PREFIX="$(pwd)/install" \
      -DBUILD_SHARED_LIBS=NO \
      -DBUILD_STATIC_LIBS=YES \
      -DBoost_NO_SYSTEM_PATHS=ON \
      -DBoost_NO_WARN_NEW_VERSIONS=1 \
      -DBoost_INCLUDE_DIR=/Users/holliday/openvdb-spm/boost \
      -DBoost_LIBRARY_DIR=/Users/holliday/openvdb-spm/boost/stage/lib \
      -DTbb_INCLUDE_DIR=/Users/holliday/openvdb-spm/tbb/include \
      ..
make -j8 install
cd ..

# iOS build
mkdir build_ios
cd build_ios

# from https://cmake.org/cmake/help/latest/manual/cmake-toolchains.7.html#cross-compiling-for-ios-tvos-or-watchos
cmake -GXcode \
      -DCMAKE_SYSTEM_NAME=iOS \
     "-DCMAKE_OSX_ARCHITECTURES=arm64;x86_64" \
      -DCMAKE_OSX_DEPLOYMENT_TARGET=11.0 \
      -DCMAKE_XCODE_ATTRIBUTE_ONLY_ACTIVE_ARCH=NO \
      -DCMAKE_IOS_INSTALL_COMBINED=YES \
      -DBUILD_SHARED_LIBS=NO \
      -DBUILD_STATIC_LIBS=YES \
      -DBoost_NO_SYSTEM_PATHS=YES \
      -DBOOST_INCLUDEDIR=../../boost \
      -DBOOST_LIBRARYDIR=../../boost/stage/lib \
      .. 

xcodebuild -configuration Release install
xcodebuild -configuration Release -sdk iphonesimulator install

cd ..

# move libraries into place
mkdir libs
libtool -o libs/openvdb_macos.a build/*.a
libtool -o libs/openvdb_ios.a build_ios/build/UninstalledProducts/iphoneos/*.a
libtool -o libs/openvdb_ios_simulator.a build_ios/build/UninstalledProducts/iphonesimulator/*.a

xcodebuild -create-xcframework \
           -library libs/openvdb_macos.a \
           -headers build/install/include \
           -library libs/openvdb_ios.a \
           -headers build/install/include \
           -library libs/openvdb_ios_simulator.a \
           -headers build/install/include \
           -output openvdb.xcframework

mv openvdb.xcframework ..
cd ..

