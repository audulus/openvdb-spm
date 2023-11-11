
rm -rf c-blosc-1.21.5
rm -f v1.21.5.tar.gz

wget https://github.com/Blosc/c-blosc/archive/refs/tags/v1.21.5.tar.gz
tar zxf v1.21.5.tar.gz

export prefix=`pwd`

cd c-blosc-1.21.5

mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFIX=$prefix/install-macos ..
cmake --build . --target install
