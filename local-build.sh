
# Builds OpenVDB locally using homebrew packages

rm -rf openvdb-11.0.0
rm -f v11.0.0.tar.gz

wget https://github.com/AcademySoftwareFoundation/openvdb/archive/refs/tags/v11.0.0.tar.gz
tar zxf v11.0.0.tar.gz
cd openvdb-11.0.0

brew install boost tbb c-blosc

# macOS build
mkdir build
cd build
cmake ..
make -j 8

