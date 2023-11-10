
# Builds OpenVDB locally using homebrew packages

git clone https://github.com/AcademySoftwareFoundation/openvdb.git 
cd openvdb 
git checkout tags/v10.0.1

brew install boost tbb c-blosc

# macOS build
mkdir build
cd build
cmake -DCMAKE_BUILD_TYPE=Release \
      "-DCMAKE_OSX_ARCHITECTURES=arm64;x86_64" \
      -DCMAKE_OSX_DEPLOYMENT_TARGET=11.0 \
      ..

