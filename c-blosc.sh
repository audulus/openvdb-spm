
rm -rf c-blosc-1.21.5
rm -f v1.21.5.tar.gz

wget https://github.com/Blosc/c-blosc/archive/refs/tags/v1.21.5.tar.gz
tar zxf v1.21.5.tar.gz

cd c-blosc-1.21.5

mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFIX=/Users/holliday/openvdb-spm ..
cmake --build . --target install
