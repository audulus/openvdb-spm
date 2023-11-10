
rm -rf tbb
rm -f v2021.10.0.tar.gz

# see https://github.com/Homebrew/homebrew-core/blob/5401dd66d7c7091ab20dcd46efc9ae64eb2b852e/Formula/t/tbb.rb

wget https://github.com/oneapi-src/oneTBB/archive/refs/tags/v2021.10.0.tar.gz
tar zxf v2021.10.0.tar.gz
mv oneTBB-2021.10.0 tbb 

cd tbb
mkdir build
cd build
cmake ..
make -j 12 compiler=clang arch=[ia32,intel64,armv7,arm64] stdlib=libc++ stdver=c++0x target=ios tbb
